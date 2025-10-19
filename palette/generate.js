import * as fs from 'node:fs';
import * as path from 'node:path';

const parseOklch = str => str.substring(6, str.length - 1).split(' ').map(Number);

const palettePath = path.resolve(import.meta.dirname, './palette.json');
const palette = JSON.parse(await fs.promises.readFile(palettePath, { encoding: 'utf-8' }));

const paletteGrayPath = path.resolve(import.meta.dirname, './palette-gray.json');
const paletteGray = JSON.parse(await fs.promises.readFile(paletteGrayPath, { encoding: 'utf-8' }));

const grouped = {};
for (const item of [...palette, ...paletteGray]) {
  const { level, oklch } = item;
  const hue = item.hue.toLowerCase();
  if (grouped[hue] == null) {
    grouped[hue] = [];
  }

  grouped[hue].push({
    level,
    oklch: parseOklch(oklch),
  });
}

const hueGroups = [];
for (const [hue, groups] of Object.entries(grouped)) {
  const h = groups[0].oklch[2];
  const convertedGroups = groups.map(({ level, oklch: [l, c] }) => ({ level, lc: [l, c] }));
  hueGroups.push({
    name: hue,
    h,
    levels: convertedGroups,
  });
}

hueGroups.sort((a, b) => a.h - b.h);

const paletteBody = hueGroups.map(({ name, h, levels }) => {
  const levelsBody = levels.map(({ level, lc: [l, c] }) => {
    return `      { level = "${level}", l = ${l}, c = ${c} },`;
  }).join('\n');
  return `  ${name} = {\n    h = ${h},\n    levels = {\n${levelsBody}\n    },\n  },`;
});
const lua = 'return {\n' + paletteBody.join('\n') + '\n}';
console.log(lua);
