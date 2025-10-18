local palette_raw = require('tirrcolo/palette')
local util = require('tirrcolo/util')

local function make_palette(p3)
  local colors = {}
  if p3 == 1 then
    for name, group in pairs(palette_raw) do
      colors[name] = {}
      for _, level in ipairs(group.levels) do
        local oklch = { l = level.l, c = level.c, h = group.h }
        local p3 = util.oklch_to_display_p3(oklch)
        colors[name][level.level] = util.rgb_color_code(p3)
      end
    end
  else
    for name, group in pairs(palette_raw) do
      colors[name] = {}
      for _, level in ipairs(group.levels) do
        local oklch = { l = level.l, c = level.c, h = group.h }
        local p3 = util.oklch_to_srgb_fallback(oklch)
        colors[name][level.level] = util.rgb_color_code(p3)
      end
    end
  end

  return colors
end

return {
  palette_raw = palette_raw,
  make_palette = make_palette,
  util = util,
}
