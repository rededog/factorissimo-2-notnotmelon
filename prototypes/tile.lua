local tile_trigger_effects = require("__base__.prototypes.tile.tile-trigger-effects")
local sounds = require("__base__.prototypes.entity.sounds")

local concrete_vehicle_speed_modifier = data.raw["tile"]["concrete"].vehicle_friction_modifier
local concrete_driving_sound = table.deepcopy(data.raw["tile"]["concrete"].driving_sound)
local concrete_tile_build_sounds = table.deepcopy(data.raw["tile"]["concrete"].build_sound)

local F = "__factorissimo-2-notnotmelon__"
local alt_graphics = settings.startup["Factorissimo2-alt-graphics"].value

local function make_tile(tinfo)
	data:extend {{
		type = "tile",
		name = tinfo.name,
		needs_correction = false,
		collision_mask = tinfo.collision_mask,
		layer = tinfo.layer or 50,
		variants = {
			main = tinfo.pictures,
			empty_transitions = true
		},
		walking_speed_modifier = 1.4,
		layer_group = "ground-artificial",
		mined_sound = sounds.deconstruct_bricks(0.8),
		driving_sound = concrete_driving_sound,
		build_sound = concrete_tile_build_sounds,
		scorch_mark_color = {r = 0.373, g = 0.307, b = 0.243, a = 1.000},
		vehicle_friction_modifier = concrete_vehicle_speed_modifier,
		trigger_effect = tile_trigger_effects.concrete_trigger_effect(),
		map_color = tinfo.map_color or {r = 1},
		absorption_per_second = 0.0006
	}}
end

local function wall_mask()
	return {
		layers = {
			ground_tile = true,
			water_tile = true,
			resource = true,
			floor = true,
			item = true,
			object = true,
			player = true,
			doodad = true,
		}
	}
end

local function edge_mask()
	return {
		layers = {
			ground_tile = true,
			water_tile = true,
			resource = true,
			floor = true,
			item = true,
			object = true,
			doodad = true,
		}
	}
end

local function floor_mask()
	return {
		layers = {
			ground_tile = true,
		}
	}
end

local function pictures_ff(i)
	return {
		{
			picture = F .. "/graphics/tile/ff_1.png",
			count = 16,
			size = 1
		},
		{
			picture = F .. "/graphics/tile/ff_2.png",
			count = 4,
			size = 2,
			probability = 0.39
		},
		{
			picture = F .. "/graphics/tile/ff_4.png",
			count = 4,
			size = 4,
			probability = 1
		},
	}
end

local function pictures_fp(i)
	return {
		{
			picture = F .. "/graphics/tile/fw" .. i .. "_1.png",
			count = 16,
			size = 1
		},
	}
end

local function pictures_fw(i)
	return {
		{
			picture = F .. "/graphics/tile/fw" .. i .. "_1.png",
			count = 16,
			size = 1
		},
	}
end

local function f1fc() return {r = 130, g = 110, b = 100} end
local function f1wc() return {r = 190, g = 125, b = 80} end
local function f2fc() return {r = 100, g = 120, b = 140} end
local function f2wc() return {r = 80, g = 140, b = 200} end
local function f3fc() return {r = 120, g = 120, b = 100} end
local function f3wc() return {r = 190, g = 190, b = 80} end

make_tile {
	name = "factory-entrance",
	collision_mask = edge_mask(),
	layer = 30,
	pictures = pictures_ff(1),
	map_color = f1fc(),
}

make_tile {
	name = "factory-floor",
	collision_mask = floor_mask(),
	layer = 30,
	pictures = pictures_ff(1),
	map_color = f1fc(),
}

-- Factory 1

make_tile {
	name = "factory-wall-1",
	collision_mask = edge_mask(),
	layer = 30,
	pictures = pictures_fw(1),
	map_color = f1wc(),
}

make_tile {
	name = "factory-pattern-1",
	collision_mask = floor_mask(),
	layer = 30,
	pictures = alt_graphics and pictures_ff(1) or pictures_fw(1),
	map_color = f1wc(),
}

-- Factory 2

make_tile {
	name = "factory-wall-2",
	collision_mask = edge_mask(),
	layer = 70,
	pictures = pictures_fw(2),
	map_color = f2wc(),
}

make_tile {
	name = "factory-pattern-2",
	collision_mask = floor_mask(),
	layer = 70,
	pictures = alt_graphics and pictures_ff(1) or pictures_fw(2),
	map_color = f2wc(),
}

-- Factory 3

make_tile {
	name = "factory-wall-3",
	collision_mask = edge_mask(),
	layer = 70,
	pictures = pictures_fw(3),
	map_color = f3wc(),
}

make_tile {
	name = "factory-pattern-3",
	collision_mask = floor_mask(),
	layer = 70,
	pictures = alt_graphics and pictures_ff(1) or pictures_fw(3),
	map_color = f3wc(),
}
