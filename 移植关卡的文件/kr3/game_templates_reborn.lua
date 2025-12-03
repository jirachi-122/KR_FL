-- chunkname: @./kr1/game_templates.lua

local bit = require("bit")
local bor = bit.bor
local band = bit.band
local bnot = bit.bnot
local E = require("entity_db")
local i18n = require("i18n")

require("constants")

local anchor_y = 0
local image_x = 0
local image_y, tt = nil
local scripts = require("game_scripts_reborn")

require("templates")

local IS_PHONE = KR_TARGET == "phone"
local IS_PHONE_OR_TABLET = KR_TARGET == "phone" or KR_TARGET == "tablet"
local IS_CONSOLE = KR_TARGET == "console"

local function v(v1, v2)
	return {
		x = v1,
		y = v2
	}
end

local function vv(v1)
	return {
		x = v1,
		y = v1
	}
end

local function r(x, y, w, h)
	return {
		pos = v(x, y),
		size = v(w, h)
	}
end

local function fts(v)
	return v / FPS
end

local function adx(v)
	return v - anchor_x * image_x
end

local function ady(v)
	return v - anchor_y * image_y
end

local function np(pi, spi, ni)
	return {
		dir = 1,
		pi = pi,
		spi = spi,
		ni = ni
	}
end

local function d2r(d)
	return d * math.pi / 180
end

local function RT(name, ref)
	return E:register_t(name, ref)
end

local function AC(tpl, ...)
	return E:add_comps(tpl, ...)
end

local function CC(comp_name)
	return E:clone_c(comp_name)
end

tt = RT("tower_holder_lozagon", "tower_holder")
tt.tower.terrain_style = TERRAIN_STYLE_LOZAGON
tt.render.sprites[1].name = "build_terrain_0009_1"

tt = RT("enemy_cursed_shaman", "enemy")

AC(tt, "melee", "ranged", "timed_attacks")

anchor_y = 0.2
anchor_x = 0.5
image_y = 60
image_x = 60
tt.enemy.lives_cost = 2
tt.enemy.gold = 70
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = {
	800,
	900,
	1000,
	1100
}
tt.health.magic_armor = 0.85
tt.health_bar.offset = v(0, 33)
tt.info.i18n_key = "ENEMY_CURSED_SHAMAN"
tt.info.enc_icon = 71
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0095") or "info_portraits_sc_0095"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_cursed_shaman.update
tt.melee.attacks[1].cooldown = fts(18) + 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(9)
tt.motion.max_speed = FPS*0.5
tt.ranged.attacks[1].bullet = "bolt_cursed_shaman"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 23)
}
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = fts(7)
tt.ranged.attacks[1].cooldown = fts(50)
tt.ranged.attacks[1].hold_advance = true
tt.render.sprites[1].anchor = v(0.5, 0.2)
tt.render.sprites[1].prefix = "enemy_cursed_shaman"
tt.sound_events.death = "DeathGoblin"
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "heal"
tt.timed_attacks.list[1].cast_time = fts(14)
tt.timed_attacks.list[1].cooldown = 3
tt.timed_attacks.list[1].max_count = 10
tt.timed_attacks.list[1].max_range = 100
tt.timed_attacks.list[1].mod = "mod_cursed_shaman_heal"
tt.timed_attacks.list[1].mod2 = "mod_cursed_shield"
tt.timed_attacks.list[1].sound = "EnemyHealing"
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt.timed_attacks.list[1].vis_bans = F_BOSS
tt.timed_attacks.list[1].excluded_templates = {
"enemy_cursed_shaman"
}
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = RT("enemy_hobgoblin_small", "enemy")

AC(tt, "melee")

anchor_y = 0.19
anchor_x = 0.5
image_y = 42
image_x = 58
tt.enemy.gold = 20
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0.25
tt.health.hp_max = {
	200,
	240,
	280,
	320
}
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_HOBGOBLIN"
tt.info.enc_icon = 70
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0094") or "info_portraits_sc_0094"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 50
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(6)
tt.motion.max_speed = {
    FPS*1.4*1.28,
    FPS*1.4*1.28,
    FPS*1.4*1.28,
    FPS*1.4*1.28*1.1
}
tt.render.sprites[1].anchor = v(0.5, 0.19)
tt.render.sprites[1].prefix = "enemy_hobgoblin_small"
tt.sound_events.death = "DeathGoblin"
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(30), ady(20))
tt = RT("enemy_hobgoblin_rider", "enemy")

AC(tt, "melee", "death_spawns")

anchor_y = 0.14
anchor_x = 0.5
image_y = 62
image_x = 62
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "enemy_hobgoblin_small"
tt.enemy.gold = 20
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(30, 0)
tt.health.hp_max = {
	120,
	140,
	160,
	180
}
tt.health.magic_armor = 0.2
tt.health_bar.offset = v(0, 48)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_hobgoblin_rider.update
tt.info.i18n_key = "ENEMY_HOBGOBLIN_RIDER"
tt.info.enc_icon = 73
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0094") or "info_portraits_sc_0094"
tt.melee.attacks[1].cooldown = 1e+99
tt.melee.attacks[1].damage_max = 0
tt.melee.attacks[1].damage_min = 0
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = nil
tt.motion.max_speed = {
    FPS*1.5*1.28,
    FPS*1.5*1.28,
    FPS*1.5*1.28,
    FPS*1.5*1.28*1.1
}
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_hobgoblin_rider"
tt.render.sprites[1].angles_stickiness.run = 10
tt.render.sprites[1].angles.run = {
	"runningRightLeft",
	"runningUp",
	"runningDown"
}
tt.sound_events.death = "DeathPuff"
tt.sound_events.insert = "WolfAttack"
tt.ui.click_rect.size = v(32, 38)
tt.ui.click_rect.pos = v(-16, 2)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 23)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(31), ady(29))
tt.unit.show_blood_pool = false
tt.coward_duration = 1
tt.coward_speed_factor = 1.4
tt.vis.bans = bor(F_SKELETON)
tt = E.register_t(E,"enemy_hobgoblin_shield", "enemy")

E.add_comps(E, tt, "melee", "timed_attacks")

anchor_y = 0.2125
anchor_x = 0.5
image_y = 85
image_x = 104
tt.enemy.lives_cost = 3
tt.enemy.gold = 100
tt.enemy.melee_slot_offset = v(35, 0)
tt.health.armor = 0.3
tt.health.magic_armor = 0
tt.health.hp_max = {
	1600,
	2000,
	2400,
	3200
}
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, 54)
tt.info.i18n_key = "ENEMY_HOBGOBLIN_SHIELD"
tt.info.enc_icon = 72
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0096") or "info_portraits_sc_0096"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_hobgoblin_shield.update
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 3
tt.melee.attacks[1].count = 3
tt.melee.attacks[1].damage_max = 138
tt.melee.attacks[1].damage_min = 60
tt.melee.attacks[1].damage_radius = 44.800000000000004
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(22, 5)
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "cast"
tt.timed_attacks.list[1].cast_time = fts(16)
tt.timed_attacks.list[1].cooldown = 7000000000000000
tt.timed_attacks.list[1].vis_bans = bor(F_BOSS, F_DARK_ELF)
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED, F_ENEMY)
tt.timed_attacks.list[1].max_range = 125
tt.timed_attacks.list[1].mod = "mod_twilight_avenger_last_service"
tt.timed_attacks.list[1].sound = "ElvesCreepAvenger"
tt.shield_extra_armor = 0.7
tt.shield_off_armor = tt.health.armor
tt.shield_on_armor = tt.health.armor + tt.shield_extra_armor
tt.motion.max_speed = {
	FPS*0.65*1.28,
	FPS*0.65*1.28,
	FPS*0.65*1.28,
	FPS*0.65*1.28
}
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_hobgoblin_shield"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.sound_events.death = "DeathBig"
tt.ui.click_rect.size = v(30, 40)
tt.ui.click_rect.pos.x = -15
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 18)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 14)
tt.unit.size = UNIT_SIZE_MEDIUM
tt = RT("enemy_goblin_spear", "enemy")

AC(tt, "melee", "ranged")

anchor_y = 0.2
anchor_x = 0.5
image_y = 36
image_x = 54
tt.enemy.gold = 15
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = {
	120,
	130,
	145,
	160
}
tt.health.magic_armor = {
	0,
	0,
	0,
	0
}
tt.health_bar.offset = v(0, 31)
tt.info.i18n_key = "ENEMY_GOBLIN_SPEAR"
tt.info.enc_icon = 74
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0025") or "info_portraits_sc_0097"
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(4)
tt.motion.max_speed = FPS*1.4
tt.ranged.attacks[1].bullet = "spear_goblin"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-11, 12.5)
}
tt.ranged.attacks[1].cooldown = fts(18) + 1
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 215
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = fts(4)
tt.render.sprites[1].anchor = v(0.5, 0.2)
tt.render.sprites[1].prefix = "enemy_goblin_spear"
tt.sound_events.death = "DeathGoblin"
tt.unit.hit_offset = v(0, 15)
tt.unit.mod_offset = v(adx(26), ady(20))
tt.unit.marker_offset.y = 1
tt = RT("enemy_goblin_balloon", "enemy")

AC(tt, "ranged")
anchor_y = 0
anchor_x = 0.5
image_y = 88
image_x = 58
tt.enemy.lives_cost = 3
tt.enemy.gold = 80
tt.health.hp_max = {
	1050,
	1200,
	1350,
	1500
}
tt.health.armor = {
	0.3,
	0.3,
	0.3,
	0.5
}
tt.health_bar.offset = v(adx(29), ady(169))
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.i18n_key = "ENEMY_GOBLIN_BALLOON"
tt.info.enc_icon = 75
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0061") or "info_portraits_sc_0061"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.motion.max_speed = FPS*0.5
tt.ranged.attacks[1].bullet = "goblin_balloon_bomb"
tt.ranged.attacks[1].bullet_start_offset = {
	v(4, 57.5)
}
tt.ranged.attacks[1].cooldown = 2
tt.ranged.attacks[1].hold_advance = false
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 70
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_time = fts(12)
tt.ranged.attacks[1].sync_animation = true
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_goblin_balloon"
tt.render.sprites[1].offset = v(0, 40)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "BombExplosionSound"
tt.ui.click_rect = r(-14, 49, 35, 35)
tt.unit.can_explode = false
tt.unit.can_disintegrate = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, 65)
tt.unit.hide_after_death = true
tt.unit.mod_offset = v(adx(31), ady(70))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_THORN, F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_FLYING)

tt = RT("enemy_goblin_platform", "enemy")

AC(tt, "ranged")
anchor_y = 0
anchor_x = 0.5
image_y = 88
image_x = 58
tt.enemy.lives_cost = 5
tt.enemy.gold = 160
tt.health.hp_max = {
    1400,
    1600,
    1800,
    2000
}
tt.health.armor = 0
tt.health_bar.offset = v(adx(29), ady(189))
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.i18n_key = "ENEMY_GOBLIN_PLATFORM"
tt.info.enc_icon = 80
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0061") or "info_portraits_sc_0061"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.motion.max_speed = {
    FPS*0.4,
    FPS*0.4,
    FPS*0.4,
    FPS*0.4
}
tt.ranged.attacks[1].bullet = "goblin_platform_bomb"
tt.ranged.attacks[1].bullet_start_offset = {
	v(4, 57.5)
}
tt.ranged.attacks[1].cooldown = 1
tt.ranged.attacks[1].hold_advance = false
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 70
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_time = fts(12)
tt.ranged.attacks[1].sync_animation = true
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_goblin_platform"
tt.render.sprites[1].offset = v(0, 40)
tt.render.sprites[1].scale = v(1.2, 1.2)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "BombExplosionSound"
tt.ui.click_rect = r(-14, 49, 35, 35)
tt.unit.can_explode = false
tt.unit.can_disintegrate = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, 52)
tt.unit.hide_after_death = true
tt.unit.mod_offset = v(adx(31), ady(65))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_THORN, F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_FLYING)


tt = RT("enemy_cursed_golem", "enemy")

AC(tt, "melee", "death_spawns")

anchor_y = 0.19
anchor_x = 0.5
image_y = 84
image_x = 108
tt.enemy.gold = 100
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.quantity = 4
tt.death_spawns.spread_nodes = 3
tt.death_spawns.name = "enemy_cursed_shard"
tt.death_spawns.path = 4
tt.death_spawns.spawn_animation = "raise"
tt.death_spawns.no_spawn_damage_types = DAMAGE_EXPLOSION
tt.enemy.lives_cost = 5
tt.enemy.melee_slot = v(25, 0)
tt.main_script.insert = scripts.enemy_basic.insert
tt.health.hp_max = {
	3000,
	3500,
	4000,
	4500
}
tt.health.magic_armor = {
	0.75,
	0.75,
	0.75,
	0.95
}
tt.health_bar.offset = v(0, 62)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0101") or "info_portraits_sc_0101"
tt.info.i18n_key = "ENEMY_CURSED_GOLEM"
tt.info.enc_icon = 76
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 3
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = {
	100,
	100,
	100,
	150
}
tt.melee.attacks[1].damage_min = {
	50,
	50,
	50,
	100
}
tt.melee.attacks[1].damage_radius = 50
tt.melee.attacks[1].damage_type = DAMAGE_MAGICAL
tt.melee.attacks[1].hit_decal = "decal_cg_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.motion.max_speed = {
	FPS*0.5*1.28,
	FPS*0.5*1.28,
	FPS*0.5*1.28,
	FPS*0.5*1.28
}
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_cursed_golem"
tt.sound_events.death = "RockElementalDeath"
tt.ui.click_rect.size = v(50, 56)
tt.ui.click_rect.pos.x = -25
tt.unit.blood_color = BLOOD_GREEN
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 24)
tt.unit.mod_offset = v(adx(53), ady(38))
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_POISON)

tt = RT("enemy_cursed_shard", "enemy")

AC(tt, "melee")

anchor_y = 0.3
anchor_x = 0.5
image_y = 42
image_x = 58
tt.enemy.gold = 28
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = {
	0.20,
	0.20,
	0.20,
	0.25
}
tt.health.magic_armor = {
	0,
	0,
	0,
	0.15
}
tt.health.hp_max = {
	187,
	218,
	250,
	281
}
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_CURSED_SHARD"
tt.info.enc_icon = 77
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0102") or "info_portraits_sc_0102"
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].damage_max = 22
tt.melee.attacks[1].damage_min = 8
tt.melee.attacks[1].hit_time = fts(6)
tt.motion.max_speed = FPS*1.5
tt.unit.can_explode = false
tt.render.sprites[1].anchor = v(0.5, 0.3)
tt.render.sprites[1].prefix = "enemy_cursed_shard"
tt.sound_events.death = "RockElementalDeath"
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.vis.bans = bor(F_POISON)
tt = RT("cursed_golem_spawner")

AC(tt, "main_script")

tt.main_script.update = scripts.s11_lava_spawner.update
tt.entity = "enemy_cursed_golem"
tt.cooldown = 180
tt.cooldown_after = 80
tt.pi = 4
tt.sound = "RockElementalDeath"
tt = RT("enemy_hobgoblin_miniboss", "enemy")

AC(tt, "melee")

anchor_y = 0.17532467532467533
anchor_x = 0.5
image_y = 154
image_x = 224
tt.enemy.gold = 300
tt.enemy.lives_cost = 8
tt.enemy.melee_slot = v(40, 0)
tt.health.hp_max = {
	6400,
	7200,
	8000,
	9600
}
tt.health.armor = {
	0.6,
	0.6,
	0.6,
	0.6
}
tt.health_bar.offset = v(0, 82)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.i18n_key = "ENEMY_HOBGOBLIN_MINIBOSS"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0098") or "info_portraits_sc_0098"
tt.info.enc_icon = 78
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 180
tt.melee.attacks[1].damage_min = 80
tt.melee.attacks[1].damage_radius = 45
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_hobgoblin_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_hobgoblin_ground_hit"
tt.melee.attacks[1].hit_offset = v(72, -9)
tt.melee.attacks[1].hit_time = fts(24)
tt.melee.attacks[1].sound = "AreaAttack"
tt.melee.attacks[1].sound_args = {
	delay = fts(24)
}
tt.motion.max_speed = {
	FPS*0.7*1.28,
	FPS*0.7*1.28,
	FPS*0.7*1.28,
	FPS*0.7*1.28
}
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_hobgoblin"
tt.render.sprites[1].scale = v(1.25, 1.25)
tt.render.sprites[1].angles_flip_vertical = {
	walk = true
}
tt.sound_events.death = "DeathJuggernaut"
tt.ui.click_rect = r(-30, 0, 60, 70)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 34)
tt.unit.mod_offset = v(0, 34)
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH, F_DISINTEGRATED, F_INSTAKILL)
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_MINIBOSS)
tt = RT("eb_hobgoblin", "boss")

AC(tt, "melee", "timed_attacks", "auras")

anchor_y = 0.08
anchor_x = 0.5
image_y = 128
image_x = 144
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "hobgoblin_spawner_aura"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(40, 0)
tt.health.dead_lifetime = 3
tt.health.hp_max = {
12000,
15000,
18000,
21000
}
tt.health.magic_armor = {
0.2,
0.40,
0.65,
0.95
}
tt.health.armor = 0
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.health_bar.offset = v(0, ady(75))
tt.info.fn = scripts.eb_juggernaut.get_info
tt.info.i18n_key = "EB_HOBGOBLIN"
tt.info.enc_icon = 79
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0099") or "info_portraits_sc_0099"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_hobgob.update
tt.motion.max_speed = FPS*0.4
tt.render.sprites[1].anchor = v(0.5, 0.08)
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[1].prefix = "eb_hobgoblin"
tt.sound_events.death = "HobgobBossDeath1"
tt.sound_events.insert = "MusicBossFight"
tt.ui.click_rect = r(-35, 0, 70, 80)
tt.unit.blood_color = BLOOD_RED
tt.unit.hit_offset = v(0, ady(35))
tt.unit.mod_offset = v(adx(65), ady(35))
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.melee.attacks[1].cooldown = 3
tt.melee.attacks[1].damage_type = bor(DAMAGE_NO_DODGE, DAMAGE_INSTAKILL, DAMAGE_DISINTEGRATE_BOSS)
tt.melee.attacks[1].damage_max = 500
tt.melee.attacks[1].damage_min = 300
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].hit_offset = tt.enemy.melee_slot
tt.melee.attacks[1].hit_fx = nil
tt.melee.attacks[1].sound_hit = "VeznanAttack"
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].animation = "shoot"
tt.timed_attacks.list[1].bullet = "missile_hobgob"
tt.timed_attacks.list[1].bullet_start_offset = v(-30, 82)
tt.timed_attacks.list[1].cooldown = 8
tt.timed_attacks.list[1].launch_vector = v(12, 170)
tt.timed_attacks.list[1].max_range = 600
tt.timed_attacks.list[1].min_range = 100
tt.timed_attacks.list[1].shoot_time = 0.2
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].vis_bans = F_HERO
tt.timed_attacks.list[1].sound = "VeznanPortalSummon"
tt.timed_attacks.list[2] = table.deepclone(tt.timed_attacks.list[1])
tt.timed_attacks.list[2].bullet = "bomb_hobbgoblin"
tt.timed_attacks.list[2].cooldown = 5
tt.timed_attacks.list[2].sound = "VeznanPortalSummon"
tt = RT("enemy_hobboss_swap", "enemy")

anchor_y = 0.19
anchor_x = 0.5
image_y = 42
image_x = 58
tt.health.dead_lifetime = 3.95
tt.ui.click_rect = r(0, 0, 0, 0)
tt.enemy.gold = 0
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.enemy.melee_slot = v(18, 0)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_passive.update
tt.health.armor = 0
tt.health.hp_max = 0
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_BOSS_SWAP"
tt.info.enc_icon = 70
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0094") or "info_portraits_sc_0094"
tt.motion.max_speed = 0
tt.unit.can_explode = false
tt.sound_events.death = "HobgobBossSpawn"
tt.unit.show_blood_pool = false
tt.render.sprites[1].anchor = v(0.5, 0.08)
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[1].prefix = "eb_hobtransform"
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.vis.bans = bor(F_FRIEND, F_BLOCK, F_RANGED, F_MOD, F_STUN, F_TELEPORT, F_THORN, F_POLYMORPH, F_DISINTEGRATED, F_INSTAKILL, F_SKELETON)
tt = RT("enemy_tp_aura", "enemy")

AC(tt, "auras")

anchor_y = 0.19
anchor_x = 0.5
image_y = 42
image_x = 58
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_teleport_hobgoblin"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 0
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.enemy.melee_slot = v(18, 0)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_passive.update
tt.health.armor = 0
tt.health.hp_max = 0
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_TP_AURA"
tt.info.enc_icon = 70
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0094") or "info_portraits_sc_0094"
tt.motion.max_speed = 0
tt.unit.can_explode = false
tt.sound_events.death = nil
tt.unit.show_blood_pool = false
tt.render.sprites[1].prefix = "totem_violet"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0.5, 0.11)
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.vis.bans = bor(F_FRIEND, F_BLOCK, F_RANGED, F_MOD, F_STUN, F_TELEPORT, F_THORN, F_POLYMORPH, F_DISINTEGRATED, F_INSTAKILL, F_SKELETON)
tt = RT("enemy_curse_aura", "enemy")

AC(tt, "auras")

anchor_y = 0.19
anchor_x = 0.5
image_y = 42
image_x = 58
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_curse_hobgoblin"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 0
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.enemy.melee_slot = v(18, 0)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_passive.update
tt.health.armor = 0
tt.health.hp_max = 0
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_CURSE_AURA"
tt.info.enc_icon = 70
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0094") or "info_portraits_sc_0094"
tt.motion.max_speed = 0
tt.unit.can_explode = false
tt.sound_events.death = nil
tt.unit.show_blood_pool = false
tt.render.sprites[1].prefix = "totem_violet"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0.5, 0.11)
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.vis.bans = bor(F_FRIEND, F_BLOCK, F_RANGED, F_MOD, F_STUN, F_TELEPORT, F_THORN, F_POLYMORPH, F_DISINTEGRATED, F_INSTAKILL, F_SKELETON)
tt = E.register_t(E, "missile_hobgob", "bullet")
tt.bullet.mod = "mod_hobgob_poison"
tt.render.sprites[1].prefix = "missile_hobgoblin"
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.min_speed = 300
tt.bullet.max_speed = 400
tt.bullet.turn_speed = (math.pi*10)/180*30
tt.bullet.acceleration_factor = 0.1
tt.bullet.hit_fx = "fx_fireball_dracolich_ground"
tt.bullet.hit_fx_air = "fx_fireball_dracolich_ground"
tt.bullet.hit_fx_water = "fx_fireball_dracolich_ground"
tt.bullet.damage_min = 1
tt.bullet.damage_max = 1
tt.bullet.damage_radius = 80
tt.bullet.vis_flags = F_RANGED
tt.bullet.damage_flags = F_AREA
tt.bullet.retarget_range = 0
tt.main_script.update = scripts.enemy_missile.update
tt.bullet.vis_bans = bor(F_ENEMY, F_HERO, F_SKELETON)
tt.bullet.damage_bans = bor(F_ENEMY, F_HERO, F_SKELETON)
tt.bullet.particles_name = "ps_missile_hobgoblin"
tt.sound_events.insert = "ElvesHeroVeznanArcaneNova"
tt.sound_events.hit = "ElvesHeroVeznanDemonFireballHit"

tt = E.register_t(E, "ps_missile_hobgoblin")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "missile_hobgoblin_trail"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.track_rotation = true
tt.particle_system.particle_lifetime = {
	0.1,
	0.1
}
tt.particle_system.emission_rate = 50

tt = RT("eb_hobgoblin_two", "boss")

AC(tt, "melee", "timed_attacks", "auras")

anchor_y = 0.1402439024390244
anchor_x = 0.5
image_y = 232
image_x = 244
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "hobgoblin_two_spawner_aura"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(40, 0)
tt.health.dead_lifetime = 6
tt.health.hp_max = {
15000,
20000,
25000,
30000
}
tt.health.armor = {
0.4,
0.4,
0.4,
0.95
}
tt.health_bar.offset = v(0, 60)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.fn = scripts.eb_hobgob2.get_info
tt.info.i18n_key = "EB_HOBGOBLIN_TWO"
tt.info.enc_icon = 45
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0100") or "info_portraits_sc_0100"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_hobgob2.update
tt.motion.max_speed = {
	FPS*0.3,
	FPS*0.3,
	FPS*0.3,
	FPS*0.25
}
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "eb_hobgoblin2"
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[1].scale = v(1.25, 1.25)
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.sound_events.death = "HobgobBossDeath2"
tt.sound_events.shoot = "ElvesHeroVeznanArcaneNova"
tt.ui.click_rect = r(-30, -5, 60, 60)
tt.unit.blood_color = BLOOD_GREEN
tt.unit.fade_time_after_death = 100
tt.unit.hit_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.marker_hidden = true
tt.unit.mod_offset = v(0, 20)
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH, F_POISON)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 200
tt.melee.attacks[1].damage_min = 100
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].hit_offset = tt.enemy.melee_slot
tt.melee.attacks[1].sound_hit = "HobgobBossAttack"
tt.melee.attacks[1].hit_fx = nil
tt.melee.attacks[2] = CC("area_attack")
tt.melee.attacks[2].cooldown = 9
tt.melee.attacks[2].animation = "attack3"
tt.melee.attacks[2].hit_decal = "decal_cg_ground_hit"
tt.melee.attacks[2].damage_max = 1
tt.melee.attacks[2].damage_min = 1
tt.melee.attacks[2].damage_radius = 60
tt.melee.attacks[2].count = 10
tt.melee.attacks[2].hit_time = fts(10)
tt.melee.attacks[2].mod = "mod_curse_two_hobgoblin"
tt.melee.attacks[2].hit_offset = tt.enemy.melee_slot
tt.melee.attacks[2].sound_hit = "HobgobBossAttack"
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].animation = "shoot"
tt.timed_attacks.list[1].bullet = "bomb_hobgoblin_two"
tt.timed_attacks.list[1].count = 2
tt.timed_attacks.list[1].bullet_start_offset = v(0, 500)
tt.timed_attacks.list[1].cooldown = 15
tt.timed_attacks.list[1].shoot_time = fts(13)
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].vis_bans = F_ENEMY
tt.timed_attacks.list[1].max_range = 50
tt.timed_attacks.list[1].min_range = 50
tt.timed_attacks.list[1].sound = "ElvesHeroVeznanArcaneNova"
tt = RT("mod_hobgob_poison", "modifier")

AC(tt, "render", "dps")

tt.explode_fx = "fx_unit_explode"
tt.modifier.duration = 3
tt.modifier.vis_flags = bor(F_MOD, F_BURN)
tt.nodes_limit = 0
tt.modifier.excluded_templates = {
	"soldier_elemental",
	"soldier_skeleton",
	"soldier_skeleton_knight",
	"soldier_frankenstein",
	"soldier_ingvar_ancestor",
	"soldier_magnus_illusion",
	"soldier_gargoyle",
	"soldier_spectral_knight_pos",
	"soldier_skeleton_knight_pos",
	"soldier_skeleton_pos",
	"soldier_bone_golem",
	"soldier_flingers_skeleton",
	"soldier_flingers_skeleton_warrior",
	"soldier_death_rider",
	"soldier_mecha"
}
tt.spawn_entity = "enemy_cursed_shard"
tt.render.sprites[1].name = "mod_dark_spitters"
tt.render.sprites[1].draw_order = 10
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dark_spitters.update
tt.dps.damage_every = 1
tt.dps.damage_max = 100
tt.dps.damage_min = 100
tt.dps.damage_type = DAMAGE_POISON
tt = RT("mod_curse_two_hobgoblin", "modifier")

AC(tt, "render", "dps")

tt.explode_fx = "fx_unit_explode"
tt.modifier.duration = 0.1
tt.modifier.vis_flags = bor(F_MOD, F_BURN)
tt.nodes_limit = 0
tt.modifier.excluded_templates = {
	"soldier_elemental",
	"soldier_skeleton",
	"soldier_skeleton_knight",
	"soldier_frankenstein",
	"soldier_ingvar_ancestor",
	"soldier_magnus_illusion",
	"soldier_gargoyle",
	"soldier_spectral_knight_pos",
	"soldier_skeleton_knight_pos",
	"soldier_skeleton_pos",
	"soldier_bone_golem",
	"soldier_flingers_skeleton",
	"soldier_flingers_skeleton_warrior",
	"soldier_death_rider",
	"soldier_mecha"
}
tt.spawn_entity = "enemy_cursed_shard"
tt.render.sprites[1].name = "mod_dark_spitters"
tt.render.sprites[1].draw_order = 10
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dark_spitters.update
tt.dps.damage_every = 0.3
tt.dps.damage_max = 250
tt.dps.damage_min = 150
tt.dps.damage_type = DAMAGE_POISON
tt = RT("bomb_hobbgoblin", "bomb")
tt.bullet.damage_bans = F_ALL
tt.bullet.damage_flags = 0
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 1
tt.bullet.flight_time_base = 0
tt.bullet.flight_time_factor = 0
tt.bullet.pop = nil
tt.bullet.hit_payload = "hobgoblin_bomb_spawner"
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt.bullet.hit_fx = nil
tt.render.sprites[1].name = "bossJuggernaut_bomb_"
tt.sound_events.insert = "VeznanPortalSummon"
tt.sound_events.hit = nil
tt = RT("bomb_hobgoblin_two", "bomb")
tt.bullet.particles_name = "ps_hobgoblin_meteor"
tt.bullet.damage_bans = F_ALL
tt.bullet.damage_flags = 0
tt.bullet.damage_max = 100
tt.bullet.damage_min = 100
tt.bullet.damage_radius = 1
tt.bullet.flight_time_base = fts(25)
tt.bullet.flight_time_factor = fts(0.07142857142857142)
tt.bullet.pop = nil
tt.bullet.hit_payload = "hobgoblin_meteor_spawner"
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt.bullet.hit_fx = "fx_giant_boulder_explosion"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.render.sprites[1].name = "hero_giant_proy_0001"
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.sound_events.hit = "HeroGiantExplosionRock"
tt = E.register_t(E, "ps_hobgoblin_meteor")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "dracolich_fireball_particle_1"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(16)
}
tt.particle_system.scale_var = {
	1.78,
	2.43
}
tt.particle_system.scales_x = {
	2,
	2.25
}
tt.particle_system.scales_y = {
	2,
	2.25
}
tt.particle_system.emission_rate = 20
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.alphas = {
	255,
	0
}
tt = RT("hobgoblin_bomb_spawner", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "tween")

tt.main_script.update = scripts.enemies_spawner.update
tt.render.sprites[1].anchor.y = 0.22
tt.render.sprites[1].prefix = "bomb_hobgoblin_spawner"
tt.render.sprites[1].loop = false
tt.spawner.animation_concurrent = "open"
tt.spawner.count = 1
tt.spawner.cycle_time = fts(6)
tt.spawner.entity = "enemy_tp_aura"
tt.spawner.keep_gold = true
tt.spawner.node_offset = 2
tt.spawner.pos_offset = v(0, 0)
tt.spawner.allowed_subpaths = {
	1,
	2,
	3
}
tt.spawner.random_subpath = false
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		4,
		0
	}
}
tt.tween.remove = true
tt = RT("hobgoblin_meteor_spawner", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "tween")

tt.main_script.update = scripts.enemies_spawner.update
tt.render.sprites[1].anchor.y = 0.22
tt.render.sprites[1].prefix = "enemy_cursed_golem_death"
tt.render.sprites[1].loop = false
tt.spawner.animation_concurrent = "death"
tt.spawner.count = 1
tt.spawner.cycle_time = fts(6)
tt.spawner.entity = "enemy_cursed_golem"
tt.spawner.keep_gold = true
tt.spawner.node_offset = 2
tt.spawner.pos_offset = v(0, 0)
tt.spawner.allowed_subpaths = {
	1,
	2,
	3
}
tt.spawner.random_subpath = false
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		4,
		0
	}
}
tt.tween.remove = true
tt = E.register_t(E, "aura_teleport_hobgoblin", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.cycle_time = 0.2
tt.aura.duration = 20
tt.aura.mods = { "mod_teleport_hobgoblin"}
tt.aura.radius = 70
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.render.sprites[1].name = "hobgoblin_teleport"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].scale = v(1.25, 1.25)
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
{
0,
vv(0)
},
{
0.5,
vv(1.25)
},
{
"this.aura.duration-0.5",
vv(1.25)
},
{
"this.aura.duration",
vv(0)
}
}
tt = E.register_t(E, "aura_curse_hobgoblin", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.cycle_time = 0.2
tt.aura.duration = 1
tt.aura.mods = { "mod_curse_hobgoblin"}
tt.aura.radius = 9999
tt.aura.vis_bans = bor(F_ENEMY)
tt.aura.vis_flags = bor(F_MOD)
tt.aura.excluded_templates = {
	"soldier_elemental",
	"soldier_skeleton",
	"soldier_skeleton_knight",
	"soldier_frankenstein",
	"soldier_ingvar_ancestor",
	"soldier_magnus_illusion",
	"soldier_gargoyle",
	"soldier_spectral_knight_pos",
	"soldier_skeleton_knight_pos",
	"soldier_skeleton_pos",
	"soldier_bone_golem",
	"soldier_flingers_skeleton",
	"soldier_flingers_skeleton_warrior",
	"soldier_death_rider",
	"soldier_mecha"
}
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		"this.aura.duration-1",
		255
	},
	{
		"this.aura.duration",
		0
	}
}
tt = RT("mod_curse_hobgoblin", "modifier")

AC(tt, "render", "dps")

tt.explode_fx = "fx_unit_explode"
tt.modifier.duration = 5
tt.modifier.vis_flags = bor(F_MOD, F_BURN)
tt.modifier.excluded_templates = {
	"soldier_elemental",
	"soldier_skeleton",
	"soldier_skeleton_knight",
	"soldier_frankenstein",
	"soldier_ingvar_ancestor",
	"soldier_magnus_illusion",
	"soldier_gargoyle",
	"soldier_spectral_knight_pos",
	"soldier_skeleton_knight_pos",
	"soldier_skeleton_pos",
	"soldier_bone_golem",
	"soldier_flingers_skeleton",
	"soldier_flingers_skeleton_warrior",
	"soldier_death_rider",
	"soldier_mecha"
}
tt.nodes_limit = 0
tt.spawn_entity = "enemy_cursed_shard"
tt.render.sprites[1].name = "mod_dark_spitters"
tt.render.sprites[1].draw_order = 10
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dark_spitters.update
tt.dps.damage_every = 1
tt.dps.damage_max = 55
tt.dps.damage_min = 55
tt.dps.damage_type = DAMAGE_POISON
tt = RT("fx_teleport_hobgoblin", "fx")
tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].prefix = "fx_teleport_hobgoblin"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt = RT("hobgoblin_spawner_aura", "aura")
tt.main_script.update = scripts.hobgoblin_spawner_aura.update
tt.aura.track_source = true
tt.spawn_data = {
	{
		{
			"enemy_hobgoblin_rider",
			8,
			5,
			2
		},
		{
			"enemy_goblin_spear",
			4,
			5,
			6
		},
		{
			"enemy_cursed_shaman",
			20,
			0,
			5
		},
		{
			"enemy_hobgoblin_small",
			4,
			5,
			1
		},
		{
			"enemy_hobgoblin_shield",
			20,
			0,
			3
		}
	},
	{
		{
			"enemy_hobgoblin_rider",
			8,
			5,
			2
		},
		{
			"enemy_goblin_spear",
			4,
			5,
			6
		},
		{
			"enemy_cursed_shaman",
			15,
			0,
			5
		},
		{
			"enemy_hobgoblin_small",
			4,
			5,
			1
		},
		{
			"enemy_hobgoblin_shield",
			15,
			0,
			3
		}
	},
	{
		{
			"enemy_hobgoblin_rider",
			6,
			5,
			2
		},
		{
			"enemy_goblin_spear",
			4,
			5,
			6
		},
		{
			"enemy_cursed_shaman",
			15,
			0,
			5
		},
		{
			"enemy_hobgoblin_small",
			4,
			5,
			1
		},
		{
			"enemy_hobgoblin_shield",
			15,
			0,
			3
		}
	},
	{
		{
			"enemy_hobgoblin_rider",
			6,
			5,
			2
		},
		{
			"enemy_goblin_spear",
			4,
			5,
			6
		},
		{
			"enemy_cursed_shaman",
			10,
			0,
			5
		},
		{
			"enemy_hobgoblin_small",
			4,
			5,
			1
		},
		{
			"enemy_hobgoblin_shield",
			10,
			0,
			3
		}
	}
}
tt = RT("hobgoblin_two_spawner_aura", "aura")
tt.main_script.update = scripts.hobgoblin_spawner_aura.update
tt.aura.track_source = true
tt.spawn_data = {
	{
		{
			"enemy_cursed_shard",
			8,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			9,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			10,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			7,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			8,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			9,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			10,
			0,
			5
		},
		{
			"enemy_goblin_balloon",
			20,
			0,
			6
		},
	},
	{
		{
			"enemy_cursed_shard",
			7,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			8,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			9,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			7,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			7,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			8,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			9,
			0,
			5
		},
		{
			"enemy_goblin_balloon",
			15,
			0,
			6
		},
	},
	{
		{
			"enemy_cursed_shard",
			5,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			7,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			5,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			5,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			7,
			0,
			5
		},
		{
			"enemy_goblin_balloon",
			13,
			0,
			6
		},
	},
	{
		{
			"enemy_cursed_shard",
			5,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			4,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			4,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			5,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			4,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			5,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			5
		},
		{
			"enemy_goblin_balloon",
			10,
			0,
			6
		},
	},
}
tt = E.register_t(E, "mod_teleport_hobgoblin", "mod_teleport")
tt.modifier.vis_flags = bor(F_MOD, F_TELEPORT)
tt.modifier.vis_bans = bor(F_BOSS)
tt.fx_end = "fx_teleport_hobgoblin"
tt.fx_start = "fx_teleport_hobgoblin"
tt.max_times_applied = 100
tt.nodes_offset = 20
tt.nodeslimit = 7
tt.delay_start = fts(2)
tt.hold_time = 0.34
tt.delay_end = fts(2)

tt = E.register_t(E, "goblin_balloon_bomb", "bomb")
tt.bullet.damage_bans = F_ENEMY
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_max = 160
tt.bullet.damage_min = 100
tt.bullet.damage_radius = 67.5
tt.bullet.rotation_speed = 0
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.flight_time = fts(10)
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.bullet.pop = {
	"pop_kboom"
}
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt.render.sprites[1].name = "pirateTower_bomb"
tt.sound_events.insert = nil
tt.sound_events.hit = "BombExplosionSound"

tt = E.register_t(E, "goblin_platform_bomb", "bomb")
tt.bullet.damage_bans = F_ENEMY
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_max = 300
tt.bullet.damage_min = 200
tt.bullet.damage_radius = 2000
tt.bullet.rotation_speed = 0
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.flight_time = fts(10)
tt.bullet.hit_decal = "decal_atomic_bomb_crater"
tt.bullet.hit_fx = "fx_explosion_big"
tt.bullet.align_with_trajectory = true
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.platform_bomb.update
tt.render.sprites[1].name = "bombs_0003"
tt.render.sprites[1].scale = v(1.2, 1.2)
tt.sound_events.insert = nil
tt.sound_events.hit = "BombExplosionSound"

tt = RT("spear_goblin", "arrow")
tt.bullet.damage_min = 60
tt.bullet.damage_max = 80
tt.bullet.flight_time = fts(20)
tt.bullet.hit_distance = 9e+99
tt.bullet.miss_decal = "decal_spear_goblin"
tt.render.sprites[1].name = "spear_goblin"
tt.sound_events.insert = "AxeSound"

tt = RT("fx_bolt_cursed_shaman_hit", "fx")
tt.render.sprites[1].name = "bolt_cursed_shaman_hit"

tt = RT("bolt_cursed_shaman", "bolt_enemy")
tt.bullet.align_with_trajectory = true
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.damage_max = 70
tt.bullet.damage_min = 40
tt.bullet.hit_fx = "fx_bolt_cursed_shaman_hit"
tt.bullet.max_speed = 350
tt.render.sprites[1].prefix = "bolt_cursed_shaman"
tt.bullet.acceleration_factor = 0.1

tt = RT("mod_cursed_shield", "modifier")

AC(tt, "render")

tt.modifier.bans = {
	"mod_sorcerer_curse_dps",
	"mod_ranger_poison",
	"mod_sandstormtw",
	"mod_viper_poison",
	"mod_fiery_nut",
	"mod_pestilence",
	"mod_lava",
	"mod_blood_elves",
	"mod_blood",
	"mod_forest_eerie_dps",
	"mod_pixie_poison",
	"mod_slow_baby_ashbite",
	"mod_lava_furnace",
	"mod_honey_bees",
	"mod_pirate_burn",
	"mod_legion_burn"
}
tt.modifier.excluded_templates = {
"enemy_cursed_shaman"
}
tt.modifier.remove_banned = true
tt.modifier.duration = 1e+99
tt.modifier.vis_flags = bor(F_MOD)
tt.shield_ignore_hits = 1
tt.main_script.insert = scripts.mod_demon_shield.insert
tt.main_script.remove = scripts.mod_demon_shield.remove
tt.main_script.update = scripts.mod_track_target.update
tt.render.sprites[1].name = "cursed_shield"
tt = E.register_t(E, "mod_cursed_shaman_heal", "modifier")

E.add_comps(E, tt, "hps", "render")

tt.hps.heal_min = 150
tt.hps.heal_max = 150
tt.hps.heal_every = 9e+99
tt.modifier.excluded_templates = {
"enemy_cursed_shaman"
}
tt.render.sprites[1].prefix = "cursed"
tt.render.sprites[1].size_names = {
	"heal",
	"heal",
	"heal"
}
tt.render.sprites[1].name = "heal"
tt.render.sprites[1].loop = false
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt.modifier.duration = fts(24)
tt.modifier.allows_duplicates = true

tt = E:register_t("decal_cg_ground_hit", "decal_timed")
tt.render.sprites[1].name = "cursed_golem_slam"
tt.render.sprites[1].z = Z_DECALS
tt = RT("decal_water_fall", "decal_loop")
tt.render.sprites[1].name = "decal_water_fall_idle"
tt = RT("decal_bush1_bl", "decal_loop")
tt.render.sprites[1].name = "decal_bush1_bl"
tt.render.sprites[1].offset = v(0, 40)
tt = RT("decal_bush2_bl", "decal_loop")
tt.render.sprites[1].name = "decal_bush2_bl"
tt.render.sprites[1].offset = v(0, 40)
tt = RT("decal_bush3_bl", "decal_loop")
tt.render.sprites[1].name = "decal_bush3_bl"
tt.render.sprites[1].offset = v(0, 40)
tt = RT("decal_bridge_bl", "decal")
tt.render.sprites[1].prefix = "decal_bridge_bl"
tt.render.sprites[1].loop = false
tt.render.sprites[1].animated = true
tt.render.sprites[1].name = "open"
tt.render.sprites[1].z = 1399
tt = RT("decal_spikewall_bl", "decal")
tt.render.sprites[1].name = "decal_spikewall_bl"
tt = RT("decal_cavewall_bl", "decal")
tt.render.sprites[1].name = "decal_cavewall_bl"
tt = RT("decal_trashcan_bl", "decal")
tt.render.sprites[1].name = "decal_trashcan_bl"
tt = RT("decal_tape_bl", "decal")
tt.render.sprites[1].name = "decal_tape_bl"
tt = RT("decal_mark_bl", "decal")
tt.render.sprites[1].name = "decal_mark_bl"
tt = RT("decal_dwarf_bl", "decal")
tt.render.sprites[1].name = "decal_dwarf_bl"
tt = RT("decal_knight_bl", "decal")
tt.render.sprites[1].name = "decal_knight_bl"
tt = E:register_t("button_steal_goblin_gold")

E:add_comps(tt, "pos", "main_script", "ui")

tt.main_script.update = scripts.button_steal_bag_gold.update
tt.ui.can_click = true
tt.ui.click_rect = r(0, 0, 20, 20)
tt.gold_to_steal = 10000000
tt.fx = "fx_coin_jump"
tt.delay = fts(15)
tt.gold = 1

tt = E:register_t("button_steal_goblin_gold_iron")

E:add_comps(tt, "pos", "main_script", "ui")

tt.main_script.update = scripts.button_steal_bag_gold_iron.update
tt.ui.can_click = true
tt.ui.click_rect = r(0, 0, 20, 20)
tt.gold_to_steal = 10000000
tt.fx = "fx_coin_jump"
tt.delay = 10
tt.gold = 0
tt.gold_inc = 5
tt.gold_inc_boosted = 10
tt.gold_every = fts(30)
tt.duration = 3

tt = RT("decal_gold_bag_iron_count", "decal_tween")

AC(tt, "texts")

tt.render.sprites[1].hidden = true
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_BULLETS
tt.render.sprites[2].offset = v(0, -9)
tt.texts.list[1].text = "Hello world"
tt.texts.list[1].size = v(152, 62)
tt.texts.list[1].font_name = "TOONISH"
tt.texts.list[1].font_size = 20
tt.texts.list[1].color = {
	255,
	200,
	114
}
tt.texts.list[1].line_height = 0.8
tt.texts.list[1].sprite_id = 2
tt.texts.list[1].fit_height = true
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(1.26, 1.26)
	},
	{
		0.4,
		v(1.24, 1.24)
	},
	{
		0.8,
		v(1.26, 1.26)
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].loop = true
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].sprite_id = 2
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].keys = {
	{
		0,
		0
	},
	{
		1,
		255
	}
}
tt.tween.props[3].sprite_id = 1
tt.tween.props[4] = table.deepclone(tt.tween.props[3])
tt.tween.props[4].sprite_id = 2
tt.tween.remove = false

tt = RT("decal_goldbag_bl", "decal")
tt.render.sprites[1].prefix = "decal_goldbag_bl"
tt.render.sprites[1].loop = false
tt.render.sprites[1].animated = true
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].z = 2001
tt = RT("decal_spark_bl", "decal")
tt.render.sprites[1].name = "stun_small_loop"
