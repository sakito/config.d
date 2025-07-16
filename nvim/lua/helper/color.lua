-- 参考: https://github.com/b0o/incline.nvim
-- 参考: https://github.com/ryota2357/dotfiles/blob/master/vim/lua/vimrc/highlight.lua

-- MIT License

-- Copyright (c) 2022 Maddison Hellstrom

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local M = {}

---@class RGBColor
---@field r number a number between 0 and 1 inclusive
---@field g number a number between 0 and 1 inclusive
---@field b number a number between 0 and 1 inclusive

---@alias HexColor string a hex color string

---@alias Color RGBColor|HexColor

---Check if a color is a hex color. Leading # is optional.
---@param color unknown
---@return boolean
local is_hex_color = function(color)
  return type(color) == "string" and color:match("^#?%x%x%x%x%x%x$")
end

local is_rgb_color = function(color)
  return type(color) == "table"
    and type(color.r) == "number"
    and type(color.g) == "number"
    and type(color.b) == "number"
end

---Convert a hex string to an RGB color
---@param color Color
---@return RGBColor
M.hex_to_rgb = function(color)
  if is_rgb_color(color) then
    ---@type RGBColor
    return color
  end
  assert(is_hex_color(color), "color must be a hex color")
  assert(type(color) == "string", "color must be a string") -- for type checking
  local hex = color:gsub("#", ""):lower()
  return {
    r = tonumber(hex:sub(1, 2), 16) / 255,
    g = tonumber(hex:sub(3, 4), 16) / 255,
    b = tonumber(hex:sub(5, 6), 16) / 255,
  }
end

---Convert an RGBColor to a HexColor
---@param rgb RGBColor
---@return HexColor
M.rgb_to_hex = function(rgb)
  local function to_hex(channel)
    local hex = string.format("%x", math.floor(channel * 255))
    if #hex == 1 then
      hex = "0" .. hex
    end
    return hex
  end
  return "#" .. to_hex(rgb.r) .. to_hex(rgb.g) .. to_hex(rgb.b)
end

---Given a color, return its relative luminance
---@param color Color
M.relative_luminance = function(color)
  local rgb = M.hex_to_rgb(color)
  local r, g, b = rgb.r, rgb.g, rgb.b
  local function adjust(channel)
    if channel <= 0.03928 then
      return channel / 12.92
    else
      return ((channel + 0.055) / 1.055) ^ 2.4
    end
  end
  r, g, b = adjust(r), adjust(g), adjust(b)
  return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

---@class ContrastColorOptions
---@field dark? Color (default '#000000')
---@field light? Color (default '#ffffff')
---@field threshold? number (default 0.179)

---Given a color, return either a dark or light color depending on the
---relative luminance of the input color.
---@param color Color
---@param opts? ContrastColorOptions
---@return Color
M.contrast_color = function(color, opts)
  opts = opts or {}
  local dark = opts.dark or "#000000"
  local light = opts.light or "#ffffff"
  local threshold = opts.threshold or 0.179
  if M.relative_luminance(M.hex_to_rgb(color)) > threshold then
    return dark
  else
    return light
  end
end

---@param hls table<string, vim.api.keyset.highlight>
---@return nil
function M.set_hl(hls)
  for group, value in pairs(hls) do
    vim.api.nvim_set_hl(0, group, value)
  end
end

---@param links table<string, string>
---@return nil
function M.set_link(links)
  for from, to in pairs(links) do
    vim.api.nvim_set_hl(0, from, {
      link = to,
    })
  end
end

function M.separator(word, color)
  color = color or "#000000"

  local hlGroup = "DduDummy" .. color:gsub("[^a-zA-Z0-9]", "")
  vim.api.nvim_set_hl(0, hlGroup, { bg = color, fg = M.contrast_color(color), bold = true })
  return {
    name = "dummy",
    params = { word = word, hlGroup = hlGroup },
  }
end

return M
