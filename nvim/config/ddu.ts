// Copyright (C) 2025 sakito <sakito@sakito.com>

// MIT License
// <https://opensource.org/license/mit>

import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~10.3.0/config";
import {
  type Params as FfParams
} from "jsr:@shougo/ddu-ui-ff@~2.0.0";

import type { Denops } from "jsr:@denops/std@~7.6.0";

import * as fn from "jsr:@denops/std@~7.6.0/function";
import * as mapping from "jsr:@denops/std@7.6.0/mapping";
import * as autocmd from "jsr:@denops/std@7.6.0/autocmd";
import * as nvim from "jsr:@denops/std@7.6.0/function/nvim";


import { logger } from "./logger.ts";

export class Config extends BaseConfig {
  override async config(args: ConfigArguments): Promise<void> {

    const denops = args.denops;

    const log = logger();
    log.info("config load ddu")

    args.contextBuilder.patchGlobal({
      ui: "ff",
      uiParams: {
        ff: {
          prompt: "> ",
          startAutoAction: true,
          autoAction: {
            delay: 0,
            name: "preview",
          },
          split: "horizontal",
          splitDirection: "bot",
          displayTree: true,
        } as FfParams,
      },
      sourceOptions: {

        _: {
          // 全体
          matchers: [ "matcher_substring" ],
        },
        help: {
          // help
          defaultAction: "open",
        },
      },
    });

    args.contextBuilder.patchLocal("help-ff", {
      sources: [
        { name: "help" },
      ],
    });

    nvim.nvim_create_user_command(
      denops,
      "Help",
      `call ddu#start(#{name: "help-ff"})`,
      {},
    );

    log.info("config load ddu done")

    return Promise.resolve();

  }
}
