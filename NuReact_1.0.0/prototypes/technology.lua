data:extend({
  {
    type = "technology",
    name = "nuclear-fission",
    icon = "__NuReact__/graphics/technology/fission-reaction.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "nuclear-reactor"
      },
      {
        type = "unlock-recipe",
        recipe = "cooling-tower"
      },
      {
        type = "unlock-recipe",
        recipe = "uranium"
      },
      {
        type = "unlock-recipe",
        recipe = "uranium-enrichment"
      },
      {
        type = "unlock-recipe",
        recipe = "fission-reaction"
      },
	  {
        type = "unlock-recipe",
        recipe = "steam-turbine"
      }
    },
    prerequisites = {"advanced-electronics", "sulfur-processing"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1}
      },
      time = 15
    },
    order = "a-h-d"
  },
  {
    type = "technology",
    name = "nuclear-reprocessing",
    icon = "__NuReact__/graphics/technology/reprocessing.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "fuel-reprocessing"
      }
    },
    prerequisites = {"nuclear-fission"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1}
      },
      time = 20
    },
    order = "a-h-d-a"
  },
  {
    type = "technology",
    name = "breeder-reaction",
    icon = "__NuReact__/graphics/technology/breeder-reaction.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "breeder-reaction"
      },
      {
        type = "unlock-recipe",
        recipe = "mox-fuel"
      }
    },
    prerequisites = {"nuclear-fission", "alien-technology"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1}
      },
      time = 20
    },
    order = "a-h-d-b"
  }
})