local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local helper = require("helper.color")

-- スペース
local Space = { provider = " " }

local Bar = function(count)
  --return { provider = string.rep("━", count) }
  return { provider = string.rep(" ", count) }
end

local Align = { provider = "%=" }

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (" " .. self.icon .. "  ")
  end,
  hl = function(self)
    return { bg = self.icon_color, fg = helper.contrast_color(self.icon_color) or "" }
  end,
}

local FileName = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":.")
    if filename == "" then
      return "[No Name]"
    end
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
  --hl = { fg = utils.get_highlight("Directory").fg },
  hl = function(self)
    return {
      fg = utils.get_highlight("Directory").fg,
      bg = conditions.is_active() and "#bdd1dd" or "#e4dcd4",
    }
  end,
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = "❌",
    hl = { fg = "red" },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = "",
    hl = { fg = "red" },
  },
}

local FileNameActive = {
  hl = function()
    if conditions.is_active then
      return { fg = utils.get_highlight("Directory").fg, bg = "#bdd1dd", bold = true, force = true }
    else
      return { fg = utils.get_highlight("Directory").fg, bg = "#e4dcd4", bold = true, force = true }
    end
  end,
}

FileNameBlock = utils.insert(
  FileNameBlock,
  FileFlags,
  Space,
  FileIcon,
  FileName,
  Space,
  { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
)

local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = "%7(%l/%3L%):%2c %P",
}

local ViMode = {
  static = {
    mode_names = {
      n = "N",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no\22"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "V",
      vs = "Vs",
      V = "V_",
      Vs = "Vs",
      ["\22"] = "^V",
      ["\22s"] = "^V",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "I",
      ic = "Ic",
      ix = "Ix",
      R = "R",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "C",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
    },
    mode_colors_map = {
      n = "#BEBEBE",
      i = "#55AAEE",
      v = "#DD5522",
      V = "#DD5522",
      ["\22"] = "#DD5522",
      c = "#00FF00",
      s = "purple",
      S = "purple",
      ["\19"] = "purple",
      R = "#DC669B",
      r = "#DC669B",
      ["!"] = "red",
      t = "green",
    },
    mode_color = function(self)
      local mode = conditions.is_active() and vim.fn.mode() or "n"
      return self.mode_colors_map[mode]
    end,
  },
  provider = function(self)
    local mode_name = self.mode_names[vim.fn.mode(1)] and self.mode_names[vim.fn.mode(1)] or "NORMAL"
    return " %2(" .. mode_name .. "%)"
  end,
  hl = function(self)
    local color = self:mode_color() -- here!
    return { fg = color, bold = true }
  end,
  update = {
    "ModeChanged",
  },
}

local SkkMode = {
  init = function(self)
    if vim.g.loaded_skkeleton then
      self.mode = vim.fn["skkeleton#mode"]()
    else
      self.mode = ""
    end
  end,
  static = {
    mode_names = {
      [""] = "＠",
      hira = "あ",
      kata = "ア",
      hankata = "ｱｲ",
      zenkaku = "Ａ",
      abbrev = "※",
    },
    mode_colors_map = {
      [""] = "#bebebe",
      hira = "#ffc0cb",
      kata = "#00ff00",
      zenkaku = "#ffd700",
      hankata = "#bebebe",
      abbrev = "#bebebe",
    },
  },
  provider = function(self)
    return " " .. self.mode_names[self.mode] .. " "
  end,
  hl = function(self)
    local color = self.mode_colors_map[self.mode]
    return { bg = color, fg = "#3d2b5a", bold = true }
  end,
  update = {
    "User",
    pattern = "skkeleton-mode-changed",
  },
}

local DefaultStatusline = {
  Bar(1),
  ViMode,
  Space,
  SkkMode,
  Space,
  Bar(3),
  FileNameBlock,
  Bar(3),
  Ruler,
}

local InactiveStatusline = {
  condition = conditions.is_not_active,
  Bar(1),
  FileNameBlock,
  Bar(1),
}

local StatusLines = {

  hl = function()
    if conditions.is_active() then
      return "StatusLine"
    else
      return "StatusLineNC"
    end
  end,

  -- the first statusline with no condition, or which condition returns true is used.
  -- think of it as a switch case with breaks to stop fallthrough.
  fallthrough = false,

  --InactiveStatusline,
  DefaultStatusline,
}

require("heirline").setup({ statusline = StatusLines })
