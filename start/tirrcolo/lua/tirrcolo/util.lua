-- Color conversion functions
local XYZ_SRGB_MAT = {
  4.0767416621, -3.3077115913, 0.2309699292,
  -1.2684380046, 2.6097574011, -0.3413193965,
  -0.0041960863, -0.7034186147, 1.7076147010,
}
local XYZ_P3_MAT = {
  3.12811053, -2.25707502, 0.12930479,
  -1.09112816, 2.41326676, -0.32216817,
  -0.02601365, -0.50802765, 1.53331668,
}

local function oklch_to_lms(oklch)
  local l = oklch.l
  local c = oklch.c
  local h = math.rad(oklch.h)
  local a = c * math.cos(h)
  local b = c * math.sin(h)

  local l_ = l + 0.3963377774 * a + 0.2158037573 * b;
  local m_ = l - 0.1055613458 * a - 0.0638541728 * b;
  local s_ = l - 0.0894841775 * a - 1.2914855480 * b;
  return {
    l = l_ * l_ * l_,
    m = m_ * m_ * m_,
    s = s_ * s_ * s_,
  }
end

local function matmul_vec(mat, v)
  return {
    mat[1] * v[1] + mat[2] * v[2] + mat[3] * v[3],
    mat[4] * v[1] + mat[5] * v[2] + mat[6] * v[3],
    mat[7] * v[1] + mat[8] * v[2] + mat[9] * v[3],
  }
end

local function lms_to_linear_srgb(lms)
  local v = matmul_vec(XYZ_SRGB_MAT, { lms.l, lms.m, lms.s })
  return { r = v[1], g = v[2], b = v[3] }
end

local function lms_to_linear_p3(lms)
  local v = matmul_vec(XYZ_P3_MAT, { lms.l, lms.m, lms.s })
  return { r = v[1], g = v[2], b = v[3] }
end

local function linear_to_srgb(rgb)
  local ret = {}
  for k, v in pairs(rgb) do
    if v <= 0.0031308 then
      ret[k] = v * 12.92
    else
      ret[k] = 1.055 * (v ^ (1.0 / 2.4)) - 0.055
    end
  end
  return ret
end

local function map_into_srgb(oklch)
  local rgb = lms_to_linear_srgb(oklch_to_lms(oklch))
  if rgb.r >= 0.0 and rgb.g >= 0.0 and rgb.b >= 0.0 then
    return oklch
  end

  local c_max = oklch.c
  local c_min = 0.0
  local c_mid

  local test
  while c_max - c_min > 0.00001 do
    c_mid = (c_max + c_min) / 2.0
    test = { l = oklch.l, c = c_mid, h = oklch.h }
    rgb = lms_to_linear_srgb(oklch_to_lms(test))
    if rgb.r >= 0.0 and rgb.g >= 0.0 and rgb.b >= 0.0 then
      c_min = c_mid
    else
      c_max = c_mid
    end
  end

  return { l = oklch.l, c = c_min, h = oklch.h }
end

local function rgb_color_code(rgb)
  local r = math.max(0.0, math.min(math.floor(rgb.r * 255.0 + 0.5), 255.0))
  local g = math.max(0.0, math.min(math.floor(rgb.g * 255.0 + 0.5), 255.0))
  local b = math.max(0.0, math.min(math.floor(rgb.b * 255.0 + 0.5), 255.0))
  return string.format('#%02x%02x%02x', r, g, b)
end

return {
  oklch_to_lms = oklch_to_lms,
  lms_to_linear_srgb = lms_to_linear_srgb,
  lms_to_linear_p3 = lms_to_linear_p3,
  linear_to_srgb = linear_to_srgb,
  map_into_srgb = map_into_srgb,
  rgb_color_code = rgb_color_code,

  oklch_to_display_p3 = function(oklch)
    return linear_to_srgb(lms_to_linear_p3(oklch_to_lms(oklch)))
  end,
  oklch_to_srgb_fallback = function(oklch)
    return linear_to_srgb(lms_to_linear_srgb(oklch_to_lms(map_into_srgb(oklch))))
  end,
}
