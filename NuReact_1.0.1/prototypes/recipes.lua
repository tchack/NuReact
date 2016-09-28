data:extend({
  {
    type = "recipe-category",
    name = "fission"
  },
  {
    type = "recipe-category",
    name = "steaming"
  },
  {
    type = "recipe-category",
    name = "water-cooling"
  },
  -- Building recipes
  {
    type = "recipe",
    name = "nuclear-reactor",
    category = "advanced-crafting",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
      {"concrete", 50},
      {"steel-plate", 20},
      {"pipe", 25},
      {"small-pump", 10},
      {"advanced-circuit", 10}
    },
    result = "nuclear-reactor"
  },
  {
    type = "recipe",
    name = "cooling-tower",
    category = "advanced-crafting",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
      {"concrete", 20},
      {"steel-plate", 10},
      {"pipe", 10},
      {"small-pump", 5}
    },
    result = "cooling-tower"
  },
  
  -- Cooling tower water cooling recipe
  {
    type = "recipe",
    name = "water-cooling",
    category = "water-cooling",
    enabled = true,
    hidden = true,
    energy_required = 0.2,
    ingredients =
    {
      {type="fluid", name="water", amount=30}
    },
    results =
    {
      {type="fluid", name="water", amount=25}
    },
    icon = "__base__/graphics/icons/fluid/water.png",
    subgroup = "fluid-recipes",
    order = "z"
  },
  -- Cooling tower steam dummy recipe
  {
    type = "recipe",
    name = "cooling-tower-steam",
    category = "steaming",
    enabled = true,
    hidden = true,
    energy_required = 600,
    ingredients =
    {
      {type="fluid", name="water", amount=0.1}
    },
    results =
    {
      {type="fluid", name="water", amount=0}
    },
    icon = "__base__/graphics/icons/fluid/water.png",
    subgroup = "fluid-recipes",
    order = "z"
  },
  
  -- Fuel processing
  {
    type = "recipe",
    name = "uranium",
    icon = "__NuReact__/graphics/icons/uranium.png",
    subgroup = "fission-products",
    order = "a[uranium]",
    category = "chemistry",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="fluid", name="sulfuric-acid", amount=0.5},
      {"uranium-ore", 8}
    },
    results =
    {
      {"uranium", 8}
    }
  },
  {
    type = "recipe",
    name = "uranium-enrichment",
    icon = "__NuReact__/graphics/icons/uranium-enrichment.png",
    subgroup = "fission-products",
    order = "b[uranium-enrichment]",
    category = "chemistry",
    enabled = false,
    energy_required = 15,
    ingredients =
    {
      {"uranium", 8}
    },
    results =
    {
      {"enriched-fuel", 1},
      {"depleted-uranium", 7}
    }
  },
  {
    type = "recipe",
    name = "fuel-reprocessing",
    icon = "__NuReact__/graphics/icons/fuel-reprocessing.png",
    subgroup = "fission-products",
    order = "c[fuel-reprocessing]",
    category = "advanced-crafting",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
      {"spent-fuel", 4}
    },
    results =
    {
      {"uranium", 1},
      {"depleted-uranium", 2}
    }
  },
  {
    type = "recipe",
    name = "mox-fuel",
    icon = "__NuReact__/graphics/icons/mox.png",
    subgroup = "fission-products",
    order = "d[mox]",
    category = "advanced-crafting",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {"uranium", 1},
      {"plutonium", 1}
    },
    results =
    {
      {"enriched-fuel", 2}
    }
  },
  
  -- Reactor fuel cycles
  {
    type = "recipe",
    name = "fission-reaction",
    icon = "__NuReact__/graphics/icons/fission-reaction.png",
    order = "a",
    subgroup = "fission",
    category = "fission",
    enabled = false,
    energy_required = 120,
    ingredients =
    {
      {"enriched-fuel", 2}
    },
    results =
    {
      {"spent-fuel", 2}
    }
  },
  {
    type = "recipe",
    name = "breeder-reaction",
    icon = "__NuReact__/graphics/icons/breeder-reaction.png",
    order = "b",
    subgroup = "fission",
    category = "fission",
    enabled = false,
    energy_required = 120,
    ingredients =
    {
      {"enriched-fuel", 2},
      {"depleted-uranium", 2}
    },
    results =
    {
      {"spent-fuel", 3},
      {"plutonium", 1}
    }
  },
  {
      enabled = false,
      type = "recipe",
      name = "steam-turbine",
      ingredients = {
        {"pipe", 20},
        {"electric-engine-unit", 20},
        {"steel-plate", 40}
      },
      result="steam-turbine"
    },
  -- Ammo
  -- {
    -- type = "recipe",
    -- name = "du-magazine",
    -- enabled = true,
    -- energy_required = 5,
    -- ingredients =
    -- {
      -- {"depleted-uranium", 1},
      -- {"steel-plate", 1}
    -- },
    -- result = "du-magazine"
  -- }
})