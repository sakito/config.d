local M = {}


function M.setup()

  vim.fn["ddc#custom#patch_global"]({
      ui = "pum",
      autoCompleteEvents = {
        "InsertEnter",
        "TextChangedI",
        "TextChangedP",
        "CmdlineChanged",
      },
      sources = {
        "around",
        "cmdline",
        "cmdline-history",
        "file",
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
          minAutoCompleteLength = 1,
          ignoreCase = true,
          sorters = {
            "sorter_fuzzy",
            "sorter_rank"
          },
          matchers = {
            "matcher_fuzzy",
            "matcher_head"
          },
          converters = {
            "converter_fuzzy",
            "converter_remove_overlap"
          },
        },
        around = {
          mark = "[A]"
        },
        file = {
          mark = "[F]",
          isVolatile = true,
          forceCompletionPattern = [[\S/\S*]],
        },
        cmdline = {
          mark = "[CMD]",
        },
        ["cmdline-history"] = {
          mark = "[HIST]",
        },
      },
      sourceParams = {
        around = { maxSize = 500 },
      },
  })

  vim.fn["ddc#enable"]()

end

return M
