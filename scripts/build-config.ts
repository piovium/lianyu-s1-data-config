import { mkdir, readFile, writeFile } from "node:fs/promises";
import { fileURLToPath } from "node:url";
import { join } from "node:path";

import { parse, stringify } from "yaml";

const root = fileURLToPath(new URL("..", import.meta.url));
const inputPaths = {
  overrides: join(root, "configs", "static-data-overrides.yml"),
  versions: join(root, "configs", "gi-tcg-version-selection.json"),
  mod: join(root, "src", "mod.gts"),
};

const [overridesSource, versionsSource, mod] = await Promise.all([
  readFile(inputPaths.overrides, "utf8"),
  readFile(inputPaths.versions, "utf8"),
  readFile(inputPaths.mod, "utf8"),
]);

const overridesConfig = parse(overridesSource);
const versions = JSON.parse(versionsSource);


if (!mod.trim()) {
  throw new TypeError(`${inputPaths.mod} must not be empty`);
}

const config = {
  overrides: overridesConfig.overrides,
  versions,
  mods: [mod],
};

const outputDirectory = join(root, "dist");
await mkdir(outputDirectory, { recursive: true });
await Promise.all([
  writeFile(
    join(outputDirectory, "config.json"),
    `${JSON.stringify(config, null, 2)}\n`,
  ),
  writeFile(join(outputDirectory, "config.yml"), stringify(config)),
]);

console.log("Generated dist/config.json and dist/config.yml");
