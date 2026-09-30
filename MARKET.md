# MARKET.md（lhg-soul-transfer 市场调研，2026-10-01）

## 供给：现有同类方案

| 方案 | 定位 | 局限 |
|---|---|---|
| Hermes 系 `hermes-agent-migration`（0x-0cd/emma-skills） | Hermes agent 换机器：clone hermes-soul 仓库 + install.sh 恢复到 `~/.hermes/`，每日 cron 自动同步 | 只认 Hermes 框架，英文，路径写死 `~/.hermes` |
| Hermes 系 `hermes-profile-orientation`（penhollowstudiolabs/aios-backup） | 新机器上 agent 自我定位：找 SOUL.md/MEMORY.md、确认 profile | 只是"找到文件"，不管跨平台迁移，不管记忆打包 |
| `rookery-agent` 内置 Migration（jonax1337） | 从 Hermes/OpenClaw 导入身份文件到 Rookery | 目标平台唯一的单向导入，不是通用方法 |
| `account-migrate`（young1108/skillhub，中文） | WorkBuddy 换账号后 SQLite 数据合并恢复 | 只解决**同一 App 内换账号**，不解决换机器/换平台 |
| SkillHub 中文市场 | 未发现"灵魂+记忆跨平台迁移"类 skill | 中文供给空白 |

## 需求证据

- 用户原话（本 skill 的直接来源）："记录我在你这里的一切，好方便我后续转移到别的机器里继续开始工作，让新机器最快了解我"——换机/换平台时重建上下文是真实痛点。
- Hermes 生态多个独立仓库都在造"迁移"轮子（migration skill、NEW-MACHINE-SETUP.md、migration.tgz 方案），说明各平台用户都在用土办法解决同一问题。

## 槽点（现有方案被吐槽最多的）

1. 平台绑定：Hermes 方案换到 Muse/豆包/ChatGPT 就用不了。
2. 只有"搬文件"，没有"新 agent 怎么读"：拷过去一堆 md，新 agent 不知道先看哪个。
3. 安全靠自觉：土办法（tar 包 AirDrop、scp 全量 `~/.hermes`）经常把密钥一起打包带走。

## 差异化（本 skill 凭什么赢）

1. **平台中立**：不绑定任何 agent 框架，先盘点（发现清单+映射工作表）再套模板，Muse/豆包工作/ChatGPT/Coze/Dify 通吃——现有方案全是单平台绑定。
2. **中文原生方法论**：双仓分工（灵魂稳定 vs 记忆生长）讲透"为什么两个仓"，新 agent"报到"流程解决"搬过去没人会读"的问题，不只是文件拷贝。
3. **安全内建**：密钥扫描是流程硬性步骤、双仓必须 private、"方法公开/数据私有"的界限写进文档——土办法最大的雷点被前置堵住。
4. **SkillHub 可分发**：标准 skill 包格式（SKILL.md frontmatter + references 不压平），Coze/Trae 通用，走中文 skill 市场而英文方案够不着。
