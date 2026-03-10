# OpenClaw + Polymarket: skill 安装说明

结论：
- 在当前 Codex 运行环境中，系统技能 `skill-creator` 与 `skill-installer` 已经预装。
- 仅为了部署 OpenClaw 对接 Polymarket，并不“必须”再装额外 Codex 技能。
- 真正关键的是：OpenClaw 本体配置、Polymarket API/签名凭据、风控参数与监控。

## 一键自检/安装脚本

仓库提供了：

```bash
bash scripts/install_codex_skills.sh
```

如果你有额外 skill 的 GitHub URL，可直接传入：

```bash
bash scripts/install_codex_skills.sh \
  https://github.com/<owner>/<repo>/tree/main/<path/to/skill>
```

安装完成后重启 Codex 以加载新技能。
