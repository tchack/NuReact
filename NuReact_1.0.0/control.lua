MOD_NAME = "NuReact"

REACTOR_ENTITY_NAME = "nuclear-reactor"
INTERFACE_ENTITY_NAME = "reactor-interface"
BOILER_ENTITY_NAME = "reactor-boiler"
TOWER_ENTITY_NAME = "cooling-tower"
STEAM_ENTITY_NAME = "cooling-tower-steam"

SIGNAL_CORE_TEMP = {type="virtual", name="signal-reactor-core-temp"}
SIGNAL_FLUID_TEMP = {type="virtual", name="signal-reactor-fluid-temp"}
SIGNAL_POWER_OUTPUT = {type="virtual", name="signal-reactor-power-output"}
SIGNAL_REACTOR_SCRAM = {type="virtual", name="signal-reactor-scram"}

TICKS_PER_UPDATE = 5 -- each reactor and cooling tower gets updated once every 5 ticks
UPDATES_PER_SECOND = 60 / TICKS_PER_UPDATE

MAX_POWER = 25500 -- kilowatts
MIN_POWER =
{
  ["fission-reaction"] = MAX_POWER * 0.2,
  ["breeder-reaction"] = MAX_POWER * 0.6
}
POWER_INCREMENT = MAX_POWER / UPDATES_PER_SECOND / 20 -- 20 seconds to max from zero
POWER_DECREMENT = MAX_POWER / UPDATES_PER_SECOND / 40 -- 40 seconds to zero from max
AMBIENT_TEMP = 15
OPERATING_TEMP = 150
SCRAM_TEMP = 250
REACTOR_MASS = 1000

CRAFTING_INCREMENT = 1 / 120 / UPDATES_PER_SECOND / MAX_POWER

function init_global()
  global = global or {}
  global.reactors = global.reactors or {}
  global.towers = global.towers or {}
end

script.on_init(init_global)

function update_global(changes)
  if changes.mod_changes[MOD_NAME] then
    for i,force in pairs(game.forces) do
      force.reset_recipes()
    end
    for i,reactor in pairs(global.reactors) do
      reactor.min_power = nil
    end    
    if changes.mod_changes[MOD_NAME].old_version == "1.0.0" then
      for i,reactor in pairs(global.reactors) do
        reactor.boiler.destructible = false
        reactor.interface.destructible = false
      end
      for i,tower in pairs(global.towers) do
        tower.steam.destructible = false
      end
    end
  end
end

script.on_configuration_changed(update_global)

function add_reactor(reactor)
  local boiler = reactor.surface.create_entity
  {
    name = BOILER_ENTITY_NAME,
    position = reactor.position,
    force = reactor.force
  }
  boiler.operable = false
  boiler.destructible = false
  local interface = reactor.surface.create_entity
  {
    name = INTERFACE_ENTITY_NAME,
    position = {reactor.position.x, reactor.position.y + 1},
    force = reactor.force
  }
  interface.operable = false
  interface.destructible = false
  table.insert(global.reactors,
  {
    id = reactor.unit_number,
    entity = reactor,
    boiler = boiler,
    interface = interface,
    control = interface.get_or_create_control_behavior(),
    signals =
    {
      parameters =
      {
        [1] = {signal=SIGNAL_CORE_TEMP, count=AMBIENT_TEMP, index=1},
        [2] = {signal=SIGNAL_FLUID_TEMP, count=AMBIENT_TEMP, index=2},
        [3] = {signal=SIGNAL_POWER_OUTPUT, count=0, index=3}
      }
    },
    core_temp = AMBIENT_TEMP,
    fluid_temp = AMBIENT_TEMP,
    power = 0,
    scram = false
  })
end

function remove_reactor(dead_reactor)
  for i,reactor in pairs(global.reactors) do
    if reactor.id == dead_reactor.unit_number then
      reactor.boiler.destroy()
      reactor.interface.destroy()
      table.remove(global.reactors, i)
    end
  end
end

function add_tower(tower)
  local steam = tower.surface.create_entity
  {
    name = STEAM_ENTITY_NAME,
    position = tower.position,
    force = tower.force
  }
  steam.operable = false
  steam.destructible = false
  steam.get_fuel_inventory().insert({name="solid-fuel", count=50}) -- at 1 watt, this is enough fuel to run for 39 years, should suffice
  steam.fluidbox[1] = {type="water", amount=1} -- water for dummy steam puff recipe
  steam.active = false
  table.insert(global.towers,
  {
    id = tower.unit_number,
    entity = tower,
    steam = steam
  })
end

function remove_tower(dead_tower)
  for i,tower in pairs(global.towers) do
    if tower.id == dead_tower.unit_number then
      tower.steam.destroy()
      table.remove(global.towers, i)
    end
  end
end

script.on_event(defines.events.on_built_entity, function(event)
  if event.created_entity.name == REACTOR_ENTITY_NAME then
    add_reactor(event.created_entity)
  elseif event.created_entity.name == TOWER_ENTITY_NAME then
    add_tower(event.created_entity)
  end
end)
script.on_event(defines.events.on_robot_built_entity, function(event)
  if event.created_entity.name == REACTOR_ENTITY_NAME then
    add_reactor(event.created_entity)
  elseif event.created_entity.name == TOWER_ENTITY_NAME then
    add_tower(event.created_entity)
  end
end)

script.on_event(defines.events.on_preplayer_mined_item, function(event)
  if event.entity.name == REACTOR_ENTITY_NAME then
    remove_reactor(event.entity)
  elseif event.entity.name == TOWER_ENTITY_NAME then
    remove_tower(event.entity)
  end
end)
script.on_event(defines.events.on_robot_pre_mined, function(event)
  if event.entity.name == REACTOR_ENTITY_NAME then
    remove_reactor(event.entity)
  elseif event.entity.name == TOWER_ENTITY_NAME then
    remove_tower(event.entity)
  end
end)
script.on_event(defines.events.on_entity_died, function(event)
  if event.entity.name == REACTOR_ENTITY_NAME then
    remove_reactor(event.entity)
  elseif event.entity.name == TOWER_ENTITY_NAME then
    remove_tower(event.entity)
  end
end)

function round(double)
  return math.floor(double + 0.5)
end

function update_signals(index)
  local reactor = global.reactors[index]
  local control = reactor.control
  reactor.signals.parameters[1].count = round(reactor.core_temp)
  reactor.signals.parameters[2].count = round(reactor.fluid_temp)
  reactor.signals.parameters[3].count = round(reactor.power / MAX_POWER * 100)
  control.parameters = reactor.signals
end

function clamp(val, min, max)
  if val > max then
    return max
  elseif val < min then
    return min
  else
    return val
  end
end

function update_reactor(index, tick)
  local reactor = global.reactors[index]
  if reactor then
    local fluid = reactor.boiler.fluidbox[1]
    if tick % TICKS_PER_UPDATE == 0 then -- perform full update
      if reactor.scram then -- no output until cooled to ambient
        reactor.power = 0
        reactor.signals.parameters[5] = reactor.signals.parameters[5] or {signal=SIGNAL_REACTOR_SCRAM, count=1, index=5}
        if reactor.core_temp < AMBIENT_TEMP + 1 then -- reached ambient temp
          reactor.scram = false
          reactor.signals.parameters[5] = nil
        end
      else
        if reactor.entity.is_crafting() then -- crafting, produce power
          if reactor.entity.crafting_progress < 1 then -- don't produce power if crafting waiting for output to clear
            reactor.min_power = reactor.min_power or MIN_POWER[reactor.entity.recipe.name]
            if reactor.power < reactor.min_power then -- power up to at least minimum throttle
              reactor.power = reactor.power + POWER_INCREMENT
            else
              if reactor.core_temp < OPERATING_TEMP then
                reactor.power = math.min(reactor.power + POWER_INCREMENT, MAX_POWER)
              else
                reactor.power = reactor.power - POWER_DECREMENT
              end
            end
            -- reactor.entity.crafting_progress = reactor.entity.crafting_progress + (CRAFTING_INCREMENT * reactor.power) -- consume fuel faster based on power output
            reactor.entity.crafting_progress = math.max(reactor.entity.crafting_progress - (CRAFTING_INCREMENT * (MAX_POWER - reactor.power)), 0) -- consume fuel slower at low throttle
            reactor.core_temp = reactor.core_temp + (reactor.power / REACTOR_MASS / UPDATES_PER_SECOND)
          end
          reactor.scram = reactor.core_temp > SCRAM_TEMP -- emergency shutdown if overheated
        else -- not crafting, no power
          reactor.min_power = nil
          reactor.power = 0
        end
      end
      local power_delta = 0
      if fluid then -- equalise heat between fluid and reactor core, with fluid capped at 100 degrees
        local total_mass = REACTOR_MASS + fluid.amount
        local sum_energy = (REACTOR_MASS * reactor.core_temp) + (fluid.amount * fluid.temperature)
        local avg_energy = sum_energy / total_mass
        reactor.fluid_temp = math.min(avg_energy, 100)
        power_delta = (reactor.fluid_temp - fluid.temperature) * fluid.amount -- this can be negative if fluid is warmer than core
        fluid.temperature = reactor.fluid_temp
        reactor.boiler.fluidbox[1] = fluid -- apply fluid changes
        reactor.signals.parameters[4] = reactor.signals.parameters[4] or {signal={type="fluid", name=fluid.type}, index=4}
        reactor.signals.parameters[4].count = round(fluid.amount)
      else
        reactor.signals.parameters[4] = nil
      end
      reactor.core_temp = reactor.core_temp - (power_delta / REACTOR_MASS * TICKS_PER_UPDATE)
      update_signals(index)
    else -- not full update, update water temp only
      if fluid then
        fluid.temperature = reactor.fluid_temp
        reactor.boiler.fluidbox[1] = fluid
      end
    end
  end
end

function update_tower(index)
  local tower = global.towers[index]
  if tower and tower.entity.valid then
    tower.steam.active = tower.entity.is_crafting() and tower.entity.crafting_progress < 1 -- only show steam puffs if cooling tower is actively working and not backed up
    tower.steam.crafting_progress = 0.1 -- reset steam puff crafting progress so it never actually finishes
  end
end

script.on_event(defines.events.on_tick, function(event)
  local index = 1
  while index <= #global.reactors do
    update_reactor(index, event.tick)
    index = index + 1
  end
  index = (event.tick % #global.towers) + 1
  while index <= #global.towers do
    update_tower(index)
    index = index + TICKS_PER_UPDATE
  end
end)