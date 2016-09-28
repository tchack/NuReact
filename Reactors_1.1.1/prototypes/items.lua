data:extend({
  {
    type = "item-group",
    name = "reactions",
    order = "g",
    icon = "__Reactors__/graphics/item-group/reactions.png"
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
    icon = "__Reactors__/graphics/icons/nuclear-reactor.png",
    flags = {"goes-to-quickbar"},
    subgroup = "energy",
    order = "b[steam-power]-c[nuclear-reactor]",
    place_result = "nuclear-reactor",
    stack_size = 50
  },
  {
    type = "item",
    name = "cooling-tower",
    icon = "__Reactors__/graphics/icons/cooling-tower.png",
    flags = {"goes-to-quickbar"},
    subgroup = "energy",
    order = "b[steam-power]-d[cooling-tower]",
    place_result = "cooling-tower",
    stack_size = 50
  },
  {
    type = "item",
    name = "uranium-ore",
    icon = "__Reactors__/graphics/icons/uranium-ore.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "raw-resource",
    order = "ff[uranium-ore]",
    stack_size = 50
  },
  {
    type = "item",
    name = "uranium",
    icon = "__Reactors__/graphics/icons/uranium.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "fission-products",
    order = "a[uranium]",
    stack_size = 50
  },
  {
    type = "item",
    name = "enriched-fuel",
    icon = "__Reactors__/graphics/icons/enriched-fuel.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "fission-products",
    order = "b[enriched-fuel]",
    stack_size = 50
  },
  {
    type = "item",
    name = "plutonium",
    icon = "__Reactors__/graphics/icons/plutonium.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "fission-products",
    order = "c[plutonium]",
    stack_size = 50
  },
  {
    type = "item",
    name = "spent-fuel",
    icon = "__Reactors__/graphics/icons/spent-fuel.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "fission-products",
    order = "d[spent-fuel]",
    stack_size = 50
  },
  {
    type = "item",
    name = "depleted-uranium",
    icon = "__Reactors__/graphics/icons/depleted-uranium.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "fission-products",
    order = "e[depleted-uranium]",
    stack_size = 50
  }
})