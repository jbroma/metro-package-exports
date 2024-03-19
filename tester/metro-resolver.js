const { resolve } = require("metro-resolver");
const fs = require("fs");
const path = require("path");

const dir = __dirname;
const specifier = process.argv[2];

console.log("dir:", dir);
console.log("specifier:", specifier);

const resolved = resolve(
  {
    assetExts: new Set(),
    sourceExts: ["js"],
    originModulePath: path.join(dir, "index.js"),
    unstable_enableSymlinks: true,
    unstable_enablePackageExports: true,
    unstable_conditionNames: [],
    nodeModulesPaths: [],
    getPackageForModule: (modulePath) => {
      const candidate = path.join(modulePath, "package.json");
      if (fs.existsSync(candidate)) {
        const contents = fs.readFileSync(candidate, "utf8");
        return { rootPath: modulePath, packageJson: JSON.parse(contents) };
      } else return null;
    },
    doesFileExist: (p) => fs.existsSync(p),
    unstable_logWarning: (msg) => console.warn(msg),
    redirectModulePath: (p) => p,
  },
  specifier,
  null
);

console.log("resolved: ", resolved);
