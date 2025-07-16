local rule = vim.fn["lexima#add_rule"]

-- 全角系設定
-- この設定は有効にならない

-- ()
rule({
  char = "(",
  input_after = ")",
})
rule({
  char = ")",
  at = [[\%#)]],
  leave = 1,
})

-- 「」
rule({
  char = "「",
  input_after = "」",
})
rule({
  char = "」",
  at = [[\%#」]],
  leave = 1,
})
