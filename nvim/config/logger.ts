// Copyright (C) 2025 sakito <sakito@sakito.com>

// MIT License
// <https://opensource.org/license/mit>

import * as fn from "jsr:@denops/std@^7.6.0/function";

import * as log from "jsr:@std/log@^0.224.14";

export function logger() {

  log.setup({
    handlers: {
      default: new log.ConsoleHandler("DEBUG", {
        formatter: log.formatters.jsonFormatter,
        useColors: false,
      }),
    },
  });

  return log.getLogger();

}
