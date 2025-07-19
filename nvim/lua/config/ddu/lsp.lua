-- オリジナル: https://github.com/koralle/dotfiles-nixos/blob/main/users/koralle/.config/nvim/lua/plugins/ddu/source-lsp.lua

local M = {}

local helper = require("helper.ddu")
local map = require("helper.keymap").map()

local ddu = {
  start = vim.fn["ddu#start"],
}

local ddu_lsp_setup = function()
  helper.patch_global({
    kindOptions = {
      lsp = {
        defaultAction = "open",
      },
      lsp_codeAction = {
        defaultAction = "apply",
      },
    },
  })

  helper.patch_local("lsp:diagnostic", {
    sources = {
      {
        name = "lsp_diagnostic",
        params = {
          buffer = 0,
        },
      },
    },
    sourceOptions = {
      lsp_diagnostic = {
        converters = {
          {
            name = "converter_lsp_diagnostic",
            params = {
              iconMap = {
                Error = "Error 󰅚 ",
                Warning = "Warn 󰀪 ",
                Info = "Info 󰌶 ",
                Hint = "Hint  ",
              },
            },
          },
        },
      },
    },
  })

  helper.patch_local("lsp:diagnostic_all", {
    sources = {
      {
        name = "lsp_diagnostic",
        params = {
          buffer = vim.NIL,
        },
      },
    },
    sourceOptions = {
      lsp_diagnostic = {
        converters = {
          {
            name = "converter_lsp_diagnostic",
            params = {
              iconMap = {
                Error = "Error 󰅚 ",
                Warning = "Warn 󰀪 ",
                Info = "Info 󰌶 ",
                Hint = "Hint  ",
              },
            },
          },
        },
      },
    },
  })

  helper.patch_local("lsp:references", {
    sources = {
      "lsp_references",
    },
    sourceOptions = {
      ["lsp_references"] = {
        matchers = {
          "matcher_substring",
          "matcher_fzf",
        },
      },
    },
    filterParams = {
      ["matcher_fzf"] = {
        highlightMatched = "Search",
      },
    },
  })

  helper.patch_local("lsp:code_action", {
    sources = {
      "lsp_codeAction",
    },
  })

  helper.patch_local("lsp:document_symbol", {
    sources = {
      {
        name = "lsp_documentSymbol",
      },
    },
    sourceOptions = {
      ["lsp_documentSymbol"] = {
        matchers = {
          "matcher_substring",
          "matcher_fzf",
        },
        converters = {
          "converter_lsp_symbol",
        },
      },
    },
    filterParams = {
      ["matcher_fzf"] = {
        highlightMatched = "Search",
      },
    },
  })

  for name, method in pairs({
    ["lsp:declaration"] = "textDocument/declaration",
    ["lsp:definition"] = "textDocument/definition",
    ["lsp:type_definition"] = "textDocument/typeDefinition",
    ["lsp:implementation"] = "textDocument/implementation",
  }) do
    helper.patch_local(name, {
      sources = {
        {
          name = "lsp_definition",
          params = {
            method = method,
          },
        },
      },
      sync = true,
      uiParams = {
        ff = {
          immediateAction = "open",
        },
      },
    })
  end

  helper.patch_local("lsp:definition_all", {
    sources = {
      helper.ff_sep("Definition", "#fc514e"),
      { name = "lsp_definition", params = { method = "textDocument/definition" } },
      helper.ff_sep("Type definition", "#ffcb8b"),
      { name = "lsp_definition", params = { method = "textDocument/typeDefinition" } },
      helper.ff_sep("Declaration", "#21c7a8"),
      { name = "lsp_definition", params = { method = "textDocument/declaration" } },
      helper.ff_sep("Implementation", "#5e97ec"),
      { name = "lsp_definition", params = { method = "textDocument/implementation" } },
    },
  })

  for name, method in pairs({
    ["lsp:incoming_call"] = "callHierarchy/incomingCalls",
    ["lsp:outgoing_call"] = "callHierarchy/outgoingCalls",
    ["lsp:super_type"] = "typeHierarchy/supertypes",
    ["lsp:sub_type"] = "typeHierarchy/subtypes",
  }) do
    helper.patch_local(name, {
      sources = {
        {
          name = "lsp_callHierarchy",
          params = { method = method },
        },
      },
      uiParams = {
        ff = {
          displayTree = true,
          startFilter = false,
        },
      },
    })
  end

  helper.patch_local("lsp:finder", {
    sources = {
      helper.ff_sep("Definition", "#fc514e"),
      { name = "lsp_definition" },
      helper.ff_sep("References", "#5e97ec"),
      { name = "lsp_references", params = { includeDeclaration = false } },
    },
  })

  for name, method in pairs({
    ["lsp:incoming_call"] = "callHierarchy/incomingCalls",
    ["lsp:outgoing_call"] = "callHierarchy/outgoingCalls",
    ["lsp:super_type"] = "typeHierarchy/supertypes",
    ["lsp:sub_type"] = "typeHierarchy/subtypes",
  }) do
    helper.patch_local(name, {
      sources = {
        {
          name = "lsp_callHierarchy",
          params = { method = method },
        },
      },
      uiParams = {
        ff = {
          displayTree = true,
          startFilter = false,
        },
      },
    })
  end
end

function M.setup()
  ddu_lsp_setup()

  map("n", ";o", function()
    return ddu.start({ name = "lsp:definition_all" })
  end)
end

return M
