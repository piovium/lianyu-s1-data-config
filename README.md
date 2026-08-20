# 恋雨杯 S1 赛事 data 配置仓库

本仓库维护恋雨杯 S1 使用的版本选择、静态数据覆盖和 GTS 模组，并将它们合并为可直接读取的 JSON/YAML 配置。

发布后可从 GitHub Pages 获取：

- `https://piovium.github.io/lianyu-s1-data-config/config.json`
- `https://piovium.github.io/lianyu-s1-data-config/config.yml`

## 本地开发

需要 Node.js 26.1+ 和 pnpm 11.17。首次检出后运行：

```sh
git submodule update --init --recursive
pnpm install
pnpm setup
```

`pnpm setup` 会从 `genius-invokation` 子模块生成 `custom-data-loader` 的声明文件。建议在 VS Code 中安装 [GamingTS](https://marketplace.visualstudio.com/items?itemName=Guyutongxue.gamingts-vscode) 扩展；仓库的 `package.json` 和 `tsconfig.json` 已配置为使用 `custom-data-loader` provider。

数据来源：

- `configs/static-data-overrides.yml`：输出的 `overrides`
- `configs/gi-tcg-version-selection.json`：输出的 `versions`
- `src/mod.gts`：输出的 `mods[0]`

修改后可运行：

```sh
pnpm check
pnpm build
```

`pnpm check` 检查 GTS 类型并验证配置输入；`pnpm build` 在 `dist/` 中生成 `config.json` 和 `config.yml`。

## 发布

推送到 `main` 后，GitHub Actions 会重新安装依赖、生成 GTS 声明、执行检查并将 `dist/` 部署到 GitHub Pages。仓库首次启用时，需要在 GitHub 的 Pages 设置中将 Source 设为 **GitHub Actions**。
