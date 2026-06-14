local palette_raw = require('tirrcolo/palette')
local util = require('tirrcolo/util')

local function make_palette(p3)
  local colors = {}
  local colors_oklch = {}
  if p3 == 1 then
    colors._color_encoding = 'display-p3'

    for name, group in pairs(palette_raw) do
      colors[name] = {}
      colors_oklch[name] = {}
      for _, level in ipairs(group.levels) do
        local oklch = { l = level.l, c = level.c, h = group.h }
        colors_oklch[name][level.level] = oklch

        local p3 = util.oklch_to_display_p3(oklch)
        colors[name][level.level] = util.rgb_color_code(p3)
      end
    end
  else
    colors._color_encoding = 'srgb'

    for name, group in pairs(palette_raw) do
      colors[name] = {}
      colors_oklch[name] = {}
      for _, level in ipairs(group.levels) do
        local oklch = { l = level.l, c = level.c, h = group.h }
        colors_oklch[name][level.level] = oklch

        local srgb = util.oklch_to_srgb_fallback(oklch)
        colors[name][level.level] = util.rgb_color_code(srgb)
      end
    end
  end

  colors.make = function(hue, level, chroma_boost)
    local oklch_base = colors_oklch[hue][level]
    local oklch = {
      l = oklch_base.l,
      c = oklch_base.c * chroma_boost,
      h = oklch_base.h,
    }

    local rgb
    if p3 == 1 then
      rgb = util.oklch_to_display_p3(oklch)
    else
      rgb = util.oklch_to_srgb_fallback(oklch)
    end

    return util.rgb_color_code(rgb)
  end

  return colors
end

return {
  palette_raw = palette_raw,
  make_palette = make_palette,
  util = util,
}
