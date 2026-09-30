# 新机器操作清单（bootstrap）

> 换电脑 / 换平台后，照这份清单操作，让新 agent 在 10 分钟内认识你。

## 前置条件

- [ ] 新机器已安装 git（`git --version` 有输出）
- [ ] 已安装并登录 GitHub CLI（`gh auth status` 显示已登录，且能看到那两个**私有**仓库）
- [ ] 知道两个仓库的地址（灵魂仓 URL、记忆仓 URL）

> 没有 gh CLI？去 https://cli.github.com/ 按系统装一个，然后 `gh auth login` 按提示登录。
> 不想装 gh？用 HTTPS clone，推送时会弹浏览器/密码框让输凭证。

## 操作步骤

```bash
# 1. 克隆两个仓库（地址换成你自己的）
git clone https://github.com/<你的组织或用户名>/<灵魂仓>.git
git clone https://github.com/<你的组织或用户名>/<记忆仓>.git

# 2. 确认是私有仓库（Private 一栏应为 yes）
gh repo view <组织或用户名>/<灵魂仓> --json isPrivate -q .isPrivate
gh repo view <组织或用户名>/<记忆仓> --json isPrivate -q .isPrivate
```

## 让新 agent 读完并报到

把下面这段话发给你的新 agent（Muse/豆包/ChatGPT/Coze/Dify 均可）：

> 我刚换到新机器/新平台，这是我之前积累的"灵魂"和"记忆"，存在两个私有 GitHub 仓库里。
> 灵魂仓：`<灵魂仓 URL>`，记忆仓：`<记忆仓 URL>`。
> 请按灵魂仓 README 里的阅读顺序读完并向我报到，然后按记忆仓 README 的顺序读记忆并做记忆报到。
> 读完告诉我你学到了什么，再问我第一件事干什么。

## 报到验收（用户自己检查）

新 agent 的报到必须包含：

- [ ] 灵魂报到：三句话（我是谁 / 它该是什么样的助手 / 最重要的规矩）
- [ ] 记忆报到：三句话（我最近在忙什么 / 最重要的长期承诺 / 它最该注意什么）
- [ ] 问了"第一件事干什么"（而不是自顾自开工）

缺任何一项，让它重读对应章节。报到不合格的新 agent 不许直接开工。

## 之后

- 在新机器上把 `references/sync.sh` 挂成每日同步（见主 skill 第 6 步），记忆继续生长。
- 旧机器确认同步无误后，再退役。
