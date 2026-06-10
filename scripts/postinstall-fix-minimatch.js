const fs = require("fs");
const path = require("path");

const target = path.join(
  process.cwd(),
  "node_modules",
  "minimatch",
  "dist",
  "commonjs",
  "index.js"
);
try {
  if (!fs.existsSync(target)) {
    console.log("minimatch commonjs bundle not found, skipping patch");
    process.exit(0);
  }
  let content = fs.readFileSync(target, "utf8");
  const marker =
    "\n// Export compatibility for CommonJS consumers\nmodule.exports = exports.minimatch || module.exports;\n";
  if (!content.includes("module.exports = exports.minimatch")) {
    content += marker;
    fs.writeFileSync(target, content, "utf8");
    console.log(
      "Patched minimatch commonjs bundle to export function as module.exports"
    );
  } else {
    console.log("minimatch already patched");
  }
} catch (err) {
  console.error("Failed to patch minimatch:", err);
  process.exit(1);
}
