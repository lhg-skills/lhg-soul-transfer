#!/usr/bin/env bash
# 每日同步脚本：把本机的灵魂/记忆文件同步到两个私有 GitHub 仓库。
# 用法：先按你的盘点结果改"配置区"，然后挂成每日任务（cron / 计划任务 / 手动跑）。
# 逻辑：按映射复制 → 密钥扫描 → 有变化才 commit/push。成功保持安静，失败报错退出。
set -euo pipefail

# ============ 配置区（按你的实际情况改） ============
SOUL_REPO="$HOME/souls"        # 灵魂仓本地克隆目录
MEMORY_REPO="$HOME/memorys"    # 记忆仓本地克隆目录

# 灵魂文件映射：格式 "源文件:仓库内目标路径"，一行一个
SOUL_MAP=(
  "$HOME/SOUL.md:SOUL.md"
  "$HOME/IDENTITY.md:IDENTITY.md"
  "$HOME/USER.md:USER.md"
  "$HOME/AGENTS.md:AGENTS.md"
  "$HOME/TOOLS.md:TOOLS.md"
)
# 记忆文件映射
MEMORY_MAP=(
  "$HOME/MEMORY.md:MEMORY.md"
)
# 记忆目录映射（用 rsync --delete 全量同步）：格式 "源目录:仓库内目标目录"
MEMORY_DIR_MAP=(
  "$HOME/memory:memory"
)
# ============ 配置区结束 ============

TODAY="$(date +%F)"
FAILED=0

# 密钥扫描：命中任一模式即返回 1（中止推送）
scan_secrets() {
  local dir="$1"
  if grep -rEn --exclude-dir=.git \
      '(sk-|ghp_|gho_|skh_)[A-Za-z0-9_-]{16,}|(password|api_key|secret|token)\s*[:=]' \
      "$dir" >/tmp/soul-transfer-scan.log 2>&1; then
    echo "[ABORT] 密钥扫描命中，停止推送该仓库。命中清单："
    cat /tmp/soul-transfer-scan.log
    return 1
  fi
  # 危险文件名检查
  if find "$dir" -path "$dir/.git" -prune -o \
      \( -name '.env' -o -name 'credentials*' -o -name '*.pem' -o -name '*.key' -o -name 'id_rsa*' \) \
      -print 2>/dev/null | grep -q .; then
    echo "[ABORT] 发现疑似凭证文件，停止推送该仓库："
    find "$dir" -path "$dir/.git" -prune -o \
      \( -name '.env' -o -name 'credentials*' -o -name '*.pem' -o -name '*.key' -o -name 'id_rsa*' \) \
      -print 2>/dev/null
    return 1
  fi
  return 0
}

sync_repo() {
  local repo="$1"; shift
  local -n file_map="$1"; shift
  local -n dir_map="$1"; shift
  local label="$1"

  [ -d "$repo/.git" ] || { echo "[SKIP] $label：$repo 不是 git 仓库，跳过"; return 0; }

  # 复制文件映射
  local pair src dst
  for pair in "${file_map[@]}"; do
    src="${pair%%:*}"; dst="$repo/${pair#*:}"
    if [ -f "$src" ]; then
      mkdir -p "$(dirname "$dst")"
      cp "$src" "$dst"
    else
      echo "[WARN] $label：源文件不存在，跳过：$src"
    fi
  done
  # 同步目录映射
  if [ "${#dir_map[@]}" -gt 0 ]; then
    for pair in "${dir_map[@]}"; do
      src="${pair%%:*}"; dst="$repo/${pair#*:}"
      if [ -d "$src" ]; then
        mkdir -p "$dst"
        if command -v rsync >/dev/null 2>&1; then
          rsync -a --delete --exclude=.git "$src/" "$dst/"
        else
          rm -rf "$dst" && cp -r "$src" "$dst"
        fi
      else
        echo "[WARN] $label：源目录不存在，跳过：$src"
      fi
    done
  fi

  cd "$repo"
  git add -A
  if git diff --cached --quiet; then
    echo "[OK] $label：无变化，跳过提交"
    cd - >/dev/null
    return 0
  fi
  if ! scan_secrets "$repo"; then
    cd - >/dev/null
    return 1
  fi
  git commit -qm "chore: 每日同步 $TODAY"
  if git push -q origin HEAD; then
    echo "[OK] $label：已推送（$(git rev-parse --short HEAD)）"
  else
    echo "[FAIL] $label：推送失败"
    cd - >/dev/null
    return 1
  fi
  cd - >/dev/null
}

EMPTY_DIR_MAP=()
sync_repo "$SOUL_REPO" SOUL_MAP EMPTY_DIR_MAP "灵魂仓" || FAILED=1
sync_repo "$MEMORY_REPO" MEMORY_MAP MEMORY_DIR_MAP "记忆仓" || FAILED=1

if [ "$FAILED" -eq 0 ]; then
  echo "同步完成：$TODAY"
else
  echo "同步有失败项，请检查上方 [ABORT]/[FAIL]"
  exit 1
fi
