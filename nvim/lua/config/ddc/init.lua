local M = {}

local function setup_ddc()
  local helper = require("helper.ddc")

  helper.patch_global({
    --ui = "pum",
    ui = "native",

    autoCompleteEvents = {
      "InsertEnter",
      "TextChangedI",
      "TextChangedP",
      "CmdlineChanged",
    },

    sources = {
      "lsp",
      "denippet",
      "rg",
      "file",
      "around",
    },
    cmdlineSources = {
      [":"] = {
        "cmdline",
        "around",
      },
      ["/"] = {
        "around",
      },
      ["?"] = {
        "around",
      },
    },
    sourceOptions = {
      _ = {
        minAutoCompleteLength = 2,
        ignoreCase = true,
        matchers = {
          "matcher_fuzzy",
          "matcher_head",
        },
        sorters = {
          "sorter_fuzzy",
          "sorter_rank",
        },
        converters = {
          "converter_fuzzy",
          "converter_remove_overlap",
        },
      },
      around = {
        mark = "[A]",
      },
      file = {
        mark = "[F]",
        isVolatile = true,
        forceCompletionPattern = [[\S/\S*]],
      },
      rg = {
        mark = "[RG]",
        minAutoCompleteLength = 4,
      },
      denippet = {
        minAutoCompleteLength = 1,
        mark = "[S]",
      },
      cmdline = {
        mark = "[CMD]",
      },
      ["cmdline-history"] = {
        mark = "[HIST]",
      },
    },
    sourceParams = {
      around = { maxSize = 300 },
    },
  })

  local ddc_visible = vim.fn["ddc#visible"]
  local map = require("helper.keymap").map()

  map("i", "<Tab>", function()
    if ddc_visible() then
      vim.fn["pum#map#insert_relative"](1)
    else
      return "<Tab>"
    end
  end)

  map("i", "<S-Tab>", function()
    if ddc_visible() then
      vim.fn["pum#map#insert_relative"](-1)
    else
      return "<S-Tab>"
    end
  end)

  map("i", "<C-n>", function()
    if ddc_visible() then
      vim.fn["pum#map#insert_relative"](1)
    else
      return "<Down>"
    end
  end, { expr = true, noremap = false })

  map("i", "<C-p>", function()
    if ddc_visible() then
      vim.fn["pum#map#insert_relative"](-1)
    else
      return "<Up>"
    end
  end, { expr = true, noremap = false })

  map("i", "<C-y>", function()
    vim.fn["pum#map#confirm"]()
  end, { expr = true, noremap = false })

  map("i", "<C-g>", function()
    if ddc_visible() then
      vim.fn["pum#map#cancel"]()
    else
      return "<esc>"
    end
  end, { expr = true, noremap = false })
end

function M.setup()
  vim.fn["ddc#enable"]()
  vim.fn["signature_help#enable"]()

  vim.fn["pum#set_option"]({
    padding = true,
    preview = true,
  })

  vim.g["signature_help_config"] = {
    contentStyle = "remainingLabels",
    viewStyle = "virtual",
  }

  vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    pattern = "*",
    callback = function()
      setup_ddc()
    end,
  })
end

return M
