-- ya pkg add yazi-rs/plugins:full-border 
-- ya pkg add yazi-rs/plugins:smart-enter

local border = {
    plain = ui.Border.PLAIN,
    rounded = ui.Border.ROUNDED,
}

require("full-border"):setup {
  -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
  type = border.rounded,
}

require("smart-enter"):setup {
}
