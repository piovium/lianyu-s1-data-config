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

## 原始融合spec by @CherryC9H13N

> 部分“融合版”可使用 version selection 方式指定的，已在 [JSON](./configs/gi-tcg-version-selection.json) 中指定；剩余卡牌在 [mod](./src/mod.gts) 中写出。仅描述改动在 [YML](./configs/static-data-overrides.yml) 中。

- 卡齐娜5.6（数据依赖缺东西没把这个版本分出来）
- 阿佩普的绿洲守望者5.0（static-data缺伤害类型，需要补一下）
- 勘探钻机4.8（需要手动增加tag减伤）
- 便携动力锯，船坞长剑：原创一个版本，对标勘探钻机4.8
- 苦舍桓4.7（费用用4.7的，描述修改了一些不严谨的，用最新的，效果应该是没改过）
- 兽肉薄荷卷3.3（效果确实是3.3，描述太粗糙了，可以对照新版本优化一下）
- 纯水精灵（base最新，仅元素爆发回调到4.1）
- 卡维（base最新，迸发扫描回调到4.7，描述里的原本费用改为当前费用）
- 吞星之鲸4.7（需要手动增加tag寰宇劫灭）
- 荒泷一斗4.1（元素爆发及其状态回调到4.1，阿丑使用最新的）
- 闲云（base最新，仅元素战技回调到5.3）
- 甘雨（base最新，仅天赋牌回调到3.6）
- 宵宫（base最新，仅元素爆发（角色最大能）回调到3.3：2点充能（数据里没把费用变化切出来））
- 夜兰（base最新，仅元素爆发和玄掷玲珑回调到4.6.1初版）
- 重云天赋及其领域（4.1的效果但改为3费）
- 灶火（最新：第一回合抽天赋+4.3剩余回合抽当前回合数的牌 上限4）
- 化种匣（4.5+最新：1费装备和所有支援牌都能减费）
- 行秋（base最新，仅元素爆发和虹剑势回调到3.5初版）
- 雷音权限（base最新，仅天赋牌回调到4.3）
