empty_sprite =
{
  filename = "__core__/graphics/empty.png",
  priority = "extra-high",
  frame_count = 1,
  width = 1,
  height = 1
}

interface_led =
{
  filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-decider-south.png",
  width = 12,
  height = 12,
  frame_count = 1,
  shift = {-0.28125, -0.34375}
}

interface_connection =
{
  shadow =
  {
    red = {0.796875, 0.5},
    green = {0.203125, 0.5},
  },
  wire =
  {
    red = {0.296875, 0.0625},
    green = {-0.296875, 0.0625},
  }
}

reactor =
{
  type = "assembling-machine",
  name = "nuclear-reactor",
  icon = "__NuReact__/graphics/icons/nuclear-reactor.png",
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  minable = {hardness = 0.2, mining_time = 0.5, result = "nuclear-reactor"},
  max_health = 1000,
  corpse = "big-remnants",
  dying_explosion = "massive-explosion",
  resistances =
  {
    {
      type = "fire",
      percent = 70
    }
  },
  collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
  selection_box = {{-1.5, -1.5}, {1.5, 0.5}},
  drawing_box = {{-1.5, -2}, {1.5, 1.5}},
  vehicle_impact_sound = 
  {
    filename = "__base__/sound/car-metal-impact.ogg",
    volume = 0.65
  },
  working_sound =
  {
    sound = { filename = "__base__/sound/idle1.ogg", volume = 1.5 },
    idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
    apparent_volume = 1.5
  },
  animation =
  {
    filename = "__NuReact__/graphics/entity/nuclear-reactor/nuclear-reactor.png",
    width = "140",
    height = "160",
    frame_count = 1,
    shift = {0.6875, -0.59375}
  },
  crafting_categories = {"fission"},
  crafting_speed = 1,
  energy_source =
  {
    type = "electric",
    usage_priority = "primary-input"
  },
  energy_usage = "180kW",
  ingredient_count = 2
}

reactor_interface =
{
  type = "constant-combinator",
  name = "reactor-interface",
  icon = reactor.icon,
  flags = {"not-blueprintable", "not-deconstructable"},
  max_health = reactor.max_health,
  collision_mask = {"ghost-layer"},
  collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  item_slot_count = 5,
  sprites =
  {
    north =
    {
      filename = "__NuReact__/graphics/entity/nuclear-reactor/nuclear-reactor-interface.png",
      priority = "extra-high",
      frame_count = 1,
      width = 32,
      height = 32
    },
    east =
    {
      filename = "__NuReact__/graphics/entity/nuclear-reactor/nuclear-reactor-interface.png",
      priority = "extra-high",
      frame_count = 1,
      width = 32,
      height = 32
    },
    south =
    {
      filename = "__NuReact__/graphics/entity/nuclear-reactor/nuclear-reactor-interface.png",
      priority = "extra-high",
      frame_count = 1,
      width = 32,
      height = 32
    },
    west =
    {
      filename = "__NuReact__/graphics/entity/nuclear-reactor/nuclear-reactor-interface.png",
      priority = "extra-high",
      frame_count = 1,
      width = 32,
      height = 32
    }
  },
  activity_led_sprites =
  {
    north = interface_led,
    east = interface_led,
    south = interface_led,
    west = interface_led
  },
  activity_led_light =
  {
    intensity = 0.8,
    size = 1,
  },
  activity_led_light_offsets =
  {
    interface_led.shift,
    interface_led.shift,
    interface_led.shift,
    interface_led.shift
  },
  circuit_wire_connection_points =
  {
    interface_connection,
    interface_connection,
    interface_connection,
    interface_connection
  },
  circuit_wire_max_distance = 7.5,
  order = "z"
}

reactor_boiler =
{
  type = "storage-tank",
  name = "reactor-boiler",
  icon = reactor.icon,
  flags = {"not-blueprintable", "not-deconstructable"},
  max_health = reactor.max_health,
  collision_mask = {"ghost-layer"},
  collision_box = reactor.collision_box,
  selection_box = {{-1.5,-1.5},{1.5,1.5}},
  fluid_box =
  {
    base_area = 25,
    pipe_covers = pipecoverspictures(),
    pipe_connections =
    {
      {position = {-2, -1}},
      {position = {-2, 1}},
      {position = {-1, -2}},
      {position = {-1, 2}},
      {position = {1, -2}},
      {position = {1, 2}},
      {position = {2, -1}},
      {position = {2, 1}}
    }
  },
  window_bounding_box = {{-0.1,-0.1}, {0.1,0.1}},
  pictures =
  {
    picture =
    {
      north = empty_sprite,
      east = empty_sprite,
      south = empty_sprite,
      west = empty_sprite
    },
    fluid_background = empty_sprite,
    window_background = empty_sprite,
    flow_sprite = empty_sprite
  },
  flow_length_in_ticks = 360,
  circuit_wire_connection_points = reactor_interface.circuit_wire_connection_points,
  circuit_wire_max_distance = 0,
  order = "z"
}

cooling_tower =
{
  type = "furnace",
  name = "cooling-tower",
  icon = "__NuReact__/graphics/icons/cooling-tower.png",
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  minable = {hardness = 0.2, mining_time = 0.5, result = "cooling-tower"},
  max_health = 500,
  corpse = "medium-remnants",
  resistances =
  {
    {
      type = "fire",
      percent = 70
    }
  },
  collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  drawing_box = {{-1.5, -3}, {1.5, 1.5}},
  fluid_boxes =
  {
    {
      production_type = "input",
      base_area = 25,
      base_level = -1,
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        {position = {-2, -1}},
        {position = {-1, -2}}
      }
    },
    {
      production_type = "output",
      base_area = 25,
      base_level = 1,
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        {position = {1, -2}},
        {position = {2, -1}}
      }
    }
  },
  source_inventory_size = 0,
  result_inventory_size = 0,
  crafting_categories = {"water-cooling"},
  energy_usage = "30kW",
  crafting_speed = 1,
  energy_source =
  {
    type = "electric",
    usage_priority = "primary-input",
    emissions = 0,
  },
  animation =
  {
    north =
    {
      filename = "__NuReact__/graphics/entity/cooling-tower/cooling-tower.png",
      width = 140,
      height = 160,
      frame_count = 1,
      shift = {0.6875, -0.59375}
    },
    east =
    {
      filename = "__NuReact__/graphics/entity/cooling-tower/cooling-tower.png",
      width = 140,
      height = 160,
      x = 140,
      frame_count = 1,
      shift = {0.6875, -0.59375}
    },
    south =
    {
      filename = "__NuReact__/graphics/entity/cooling-tower/cooling-tower.png",
      width = 140,
      height = 160,
      x = 280,
      frame_count = 1,
      shift = {0.6875, -0.59375}
    },
    west =
    {
      filename = "__NuReact__/graphics/entity/cooling-tower/cooling-tower.png",
      width = 140,
      height = 160,
      x = 420,
      frame_count = 1,
      shift = {0.6875, -0.59375}
    }
  }
}

cooling_tower_steam =
{
  type = "furnace",
  name = "cooling-tower-steam",
  icon = cooling_tower.icon,
  flags = {"not-blueprintable", "not-deconstructable"},
  max_health = cooling_tower.max_health,
  collision_mask = {"ghost-layer"},
  collision_box = {{-0.5,-0.5},{0.5,0.5}},
  selection_box = {{-0.5,-0.5},{0.5,0.5}},
  fluid_boxes =
  {
    {
      production_type = "input",
      base_area = 0.1,
      pipe_connections = { }
    },
    {
      production_type = "output",
      base_area = 0,
      pipe_connections = { }
    }
  },
  source_inventory_size = 0,
  result_inventory_size = 0,
  crafting_categories = {"steaming"},
  energy_usage = "1W",
  crafting_speed = 1,
  energy_source =
  {
    type = "burner",
    effectivity = 1,
    fuel_inventory_size = 1,
    emissions = 0,
    light_flicker =
    {
      minimum_intensity = 0,
      maximum_intensity = 0
    },
    smoke =
    {
      {
        name = "cooling-tower-steam-puff",
        deviation = {0.1, 0.1},
        frequency = 10,
        position = {0.0, -2.25},
        starting_vertical_speed = 0.00,
        starting_frame_deviation = 60
      }
    }
  },
  animation = empty_sprite
}

steam_turbine =
{
	type = "generator",
	name = "steam-turbine",
	icon = "__NuReact__/graphics/icons/steam-turbine.png",
	flags = {"placeable-neutral","player-creation"},
	minable = {mining_time = 1, result = "steam-turbine"},
	max_health = 300,
	corpse = "big-remnants",
	dying_explosion = "medium-explosion",
	effectivity = 1,
	fluid_usage_per_tick = 1.4,
	resistances =
	{
	  {
		type = "fire",
		percent = 70
	  }
	},
	collision_box = {{-1.35, -2.35}, {1.35, 2.35}},
	selection_box = {{-1.5, -2.5}, {1.5, 2.5}},
	fluid_box =
	{
	  base_area = 8,
	  pipe_covers = pipecoverspictures(),
	  pipe_connections =
	  {
		{ position = {0, 3} },
		{ position = {0, -3} },
	  },
	},
	energy_source =
	{
	  type = "electric",
	  usage_priority = "secondary-output"
	},
	horizontal_animation =
	{
	  filename = "__NuReact__/graphics/entity/steam-turbine/steam-turbine-horizontal.png",
	  width = 246,
	  height = 137,
	  frame_count = 32,
	  line_length = 8,
	  shift = {1.34, -0.06}
	},
	vertical_animation =
	{
	  filename = "__NuReact__/graphics/entity/steam-turbine/steam-turbine-vertical.png",
	  width = 155,
	  height = 186,
	  frame_count = 32,
	  line_length = 8,
	  shift = {0.812, 0.03125}
	},
	smoke =
	{
	  {
		name = "light-smoke",
		north_position = {0.9, 0.0},
		east_position = {-2.0, -2.0},
		frequency = 10 / 32,
		starting_vertical_speed = 0.08,
		slow_down_factor = 1,
		starting_frame_deviation = 60
	  }
	},
	vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	working_sound =
	{
	  sound =
	  {
		filename = "__base__/sound/steam-engine-90bpm.ogg",
		volume = 0.6
	  },
	  match_speed_to_activity = true,
	},
	min_perceived_performance = 0.25,
	performance_to_sound_speedup = 0.5
}

data:extend({
  smoke {
    name = "cooling-tower-steam-puff",
    color = {r = 0.8, g = 0.8, b = 0.8, a = 0.1},
    duration = 150,
    spread_duration = 100,
    fade_away_duration = 100,
    start_scale = 1.25,
    end_scale = 2.0,
    affected_by_wind = true
  },
  
  reactor,
  reactor_interface,
  reactor_boiler,
  cooling_tower,
  cooling_tower_steam,
  steam_turbine
})