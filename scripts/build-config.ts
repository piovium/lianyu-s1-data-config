import { mkdir, readFile, writeFile } from "node:fs/promises";
import { fileURLToPath } from "node:url";
import { join } from "node:path";
import pkgJson from "../package.json" with { type: "json" };
import JSONC from "tiny-jsonc";
import { parse, stringify } from "yaml";
import { createOfficialVersionResolver } from "@gi-tcg/core";

const root = fileURLToPath(new URL("..", import.meta.url));
const inputPaths = {
  overrides: join(root, "configs", "static-data-overrides.yml"),
  versions: join(root, "configs", "gi-tcg-version-selection.jsonc"),
  mod: join(root, "src", "mod.gts"),
};

const [overridesSource, versionsSource, mod] = await Promise.all([
  readFile(inputPaths.overrides, "utf8"),
  readFile(inputPaths.versions, "utf8"),
  readFile(inputPaths.mod, "utf8"),
]);

const overridesConfig = parse(overridesSource);
const versions = JSONC.parse(versionsSource);

for (const [key, value] of Object.entries(versions)) {
  if (key.length === 4) {
    versions[`2${key}1`] ??= value;
  }
}

createOfficialVersionResolver(void 0, versions);

if (!mod.trim()) {
  throw new TypeError(`${inputPaths.mod} must not be empty`);
}

const config = {
  version: pkgJson.version,
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

console?.log?.("Generated dist/config.json and dist/config.yml");
