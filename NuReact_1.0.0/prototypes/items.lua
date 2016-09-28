data:extend({
  {
    type = "item-group",
    name = "reactions",
    order = "g",
    icon = "__NuReact__/graphics/item-group/reactions.png"
  },
  {
    type = "item-subgroup",
    name = "fission",
    group = "reactions",
    order = "a"
  },
  {
    type = "item-subgroup",
    name = "fission-products",
    group = "intermediate-products",
    order = "cc"
  },
  {
    type = "item",
    name = "nuclear-reactor",
    icon = "__NuReact__/graphics/icons/nuclear-reactor.png",
    flags = {"goes-to-quickbar"},
    subgroup = "energy",
    order = "b[steam-power]-c[nuclear-reactor]",
    place_result = "nuclear-reactor",
    stack_size = 50
  },
  {
    type = "item",
    name = "cooling-tower",
    icon = "__NuReact__/graphics/icons/cooling-tower.png",
    flags = {"goes-to-quickbar"},
    subgroup = "energy",
    order = "b[steam-power]-d[cooling-tower]",
    place_result = "cooling-tower",
    stack_size = 50
  },
  {
    type = "item",
    name = "uranium-ore",
    icon = "__NuReact__/graphics/icons/uranium-ore.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "raw-resource",
    order = "ff[uranium-ore]",
    stack_size = 50
  },
  {
    type = "item",
    name = "uranium",
    icon = "__NuReact__/graphics/icons/uranium.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "fission-products",
    order = "a[uranium]",
    stack_size = 50
  },
  {
    type = "item",
    name = "enriched-fuel",
    icon = "__NuReact__/graphics/icons/enriched-fuel.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "fission-products",
    order = "b[enriched-fuel]",
    stack_size = 50
  },
  {
    type = "item",
    name = "plutonium",
    icon = "__NuReact__/graphics/icons/plutonium.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "fission-products",
    order = "c[plutonium]",
    stack_size = 50
  },
  {
    type = "item",
    name = "spent-fuel",
    icon = "__NuReact__/graphics/icons/spent-fuel.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "fission-products",
    order = "d[spent-fuel]",
    stack_size = 50
  },
  {
    type = "item",
    name = "depleted-uranium",
    icon = "__NuReact__/graphics/icons/depleted-uranium.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "fission-products",
    order = "e[depleted-uranium]",
    stack_size = 50
  },
  {
    type = "item",
    name = "steam-turbine",
    icon = "__NuReact__/graphics/icons/steam-turbine.png",
    flags = {"goes-to-quickbar"},
    subgroup = "energy",
    place_result = "steam-turbine",
    order = "b",
    stack_size = 10
  },
})