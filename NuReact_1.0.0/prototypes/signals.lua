SIGNAL_BACKGROUND = "__base__/graphics/icons/signal/shape_square.png"

data:extend({
  {
    type = "item-subgroup",
    name = "reactor-signals",
    group = "signals",
    order = "f"
  },
  {
    type = "virtual-signal",
    name = "signal-reactor-core-temp",
    icons =
    {
      {icon = SIGNAL_BACKGROUND},
      {icon = "__NuReact__/graphics/icons/signal/core.png"}
    },
    subgroup = "reactor-signals",
    order = "a-a"
  },
  {
    type = "virtual-signal",
    name = "signal-reactor-fluid-temp",
    icons =
    {
      {icon = SIGNAL_BACKGROUND},
      {icon = "__NuReact__/graphics/icons/signal/fluid.png"}
    },
    subgroup = "reactor-signals",
    order = "a-b"
  },
  {
    type = "virtual-signal",
    name = "signal-reactor-power-output",
    icons =
    {
      {icon = SIGNAL_BACKGROUND},
      {icon = "__NuReact__/graphics/icons/signal/power.png"}
    },
    subgroup = "reactor-signals",
    order = "a-c"
  },
  -- {
    -- type = "virtual-signal",
    -- name = "signal-reactor-power-setting",
    -- icons =
    -- {
      -- {icon = SIGNAL_BACKGROUND},
      -- {icon = "__NuReact__/graphics/icons/signal/throttle.png"}
    -- },
    -- subgroup = "reactor-signals",
    -- order = "d[throttle]"
  -- },
  -- {
    -- type = "virtual-signal",
    -- name = "signal-reactor-halt",
    -- icons =
    -- {
      -- {icon = SIGNAL_BACKGROUND},
      -- {icon = "__NuReact__/graphics/icons/signal/halt.png"}
    -- },
    -- subgroup = "reactor-signals",
    -- order = "e[halt]"
  -- },
  {
    type = "virtual-signal",
    name = "signal-reactor-scram",
    icons =
    {
      {icon = "__NuReact__/graphics/icons/signal/red-background.png"},
      {icon = "__NuReact__/graphics/icons/signal/halt.png"}
    },
    subgroup = "reactor-signals",
    order = "a-f"
  }
})