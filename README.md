# 灵魂迁移（lhg-soul-transfer）

把你在某个 AI 那里积累的"灵魂（身份/性格/用户画像/偏好）+ 记忆（长期记忆/日报/人物关系）"打包进两个**私有** GitHub 仓库，换机器、换平台时，新 agent 按固定阅读顺序 10 分钟认识你。

## 发给 Agent 的安装话术（推荐）

复制下面整段话，发给你的 Agent（豆包 / WorkBuddy / Claude Code / Codex / Cursor 等）：

> 请帮我安装 Skill「lhg-soul-transfer」：先从 Gitee 上 lhg-skills 组织下的 lhg-soul-transfer 仓库下载；如果 Gitee 无法访问或下载失败，改从 GitHub 上 lhg-skills 组织下的同名仓库下载。按当前 Agent 的规范安装其中的 Skill，优先全局安装，保留完整目录和依赖。请直接执行，完成后验证是否安装成功，告诉我实际使用的来源、安装的版本号以及如何调用；遇到访问或安装限制请说明具体原因。需要登录账号、输入令牌或确认风险时停下来等我。

**怎么算装好了**：Agent 能在已安装的 Skill 里看到 `lhg-soul-transfer`，并报出版本号（与仓库 `manifest.yaml` 的 `version` 一致）。只是打开了仓库网页不算安装。

## 功能速览

- **第 1 步 盘点**：发现清单 + 映射工作表，先找到你平台上灵魂/记忆文件在哪（Muse / 豆包工作 / ChatGPT / Coze / Dify 都适用）
- **第 2 步 建仓**：建两个**私有**仓库——灵魂仓（身份类，变化慢）+ 记忆仓（记忆类，天天长）
- **第 3 步 搬运**：按映射复制文件，README 模板自带"新 agent 阅读顺序"与"报到指令"
- **第 4 步 安检**：推送前密钥扫描，命中 `sk-`/`ghp_` 等模式即中止
- **第 5 步 同步**：`sync.sh` 每日同步，有变化才提交推送
- **第 6 步 报到**：新机器上新 agent 按顺序读完，三句话复述 + 问"第一件事干什么"

方法 skill 本身公开，你的两个数据仓永远私有。

## 一键安装

```bash
npx skills add lhg-skills/lhg-soul-transfer
```

- GitHub 仓库：https://github.com/lhg-skills/lhg-soul-transfer
- ZIP 下载：https://github.com/lhg-skills/lhg-soul-transfer/archive/refs/heads/main.zip
- 导入：
  - 桌面 agent（如 Muse）：放到 skills 目录后重启即生效
  - 扣子：扣子编程 → 技能面板 → 创建技能 → 本地上传（仓库根目录已有 SKILL.md，直接压缩仓库文件夹即可；页面要求 `.skill` 后缀时由扣子导入后自动生成，**不要只改 zip 扩展名**）
  - Trae：设置 → 技能 → 上传技能（同上 zip）；或手动放到 `~/.trae/skills/lhg-soul-transfer/`（TRAE Work 国区版路径为 `~/.trae-cn/skills/`）

## 版本

- 1.0.1（2026-10-01）：补 SkillHub 自定义头像（内容无变化）。
- 1.0.0（2026-10-01）：首版。双仓方法论（灵魂仓+记忆仓）、平台适配发现清单、密钥扫描、sync.sh、bootstrap 清单、README 模板×2、映射工作表、冒烟测试 6 用例全绿。

## 出品：刘洪光

本 skill 由真人出镜 IP「刘洪光」（安徽合肥）出品，归属 [lhg-skills](https://github.com/lhg-skills)。

- GitHub 主页：https://github.com/lhg-skills —— 全部 skill 开源在此，欢迎 star
- 视频号：搜「刘洪光实名上网」
- 微信：lhgsmsw
