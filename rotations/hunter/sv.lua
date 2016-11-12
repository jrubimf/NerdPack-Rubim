local exeOnLoad = function()
	meleeSpell = 23881
	print("melee Spell: ".. GetSpellInfo(meleeSpell) .. "(" .. meleeSpell .. ")")
end

local Shared = {
	{'@Rubim.CastGroundSpell()'},
}

local Survival = {
	-- healthstone
--	{ '#5512', 'player.health < 70'},
	{"Bloodthirst" , { "player.heatlh <= 85" , "player.buff(Enraged Regeneration).duration > 0" , "player.rage <= 90"}},
}

local Interrupts = {
	-- Mind freeze
	{ 'Pummel' },
}

local Opener = {
	{ "Dragon Roar" , "@Rubim.meleeRange()" },
	{ "Avatar" , "@Rubim.meleeRange()" },
	{ "Battle Cry" , "@Rubim.meleeRange()" },
	{ "Bloodthirst" },
	
}

local inCombat = {
--	{ "#trinket1" , { "target.boss" , "@Rubim.meleeRange"}},
	{ Interrupts, "target.interruptAt(10)" }, -- Interrupt when 40% into the cast time
	{"Bloodthirst" , { "player.heatlh <= 85" , "player.buff(Enraged Regeneration).duration > 0" , "player.rage <= 90"}},
	{ Opener , "player.time <= 20" },
	{ "Avatar" , "@Rubim.meleeRange()" },
	{ "Battle Cry" , "@Rubim.meleeRange()" },
	{{ -- SINGLE TARGET
		{ "Rampage" , "player.buff(Enrage).duration <= 0" },
		{ "Rampage" , "player.rage >= 100" },
		{ "Whirlwind" , { "player.buff(Wrecking Ball).duration >= 1" , "@Rubim.meleeRange()" }},
		{ "Execute" , "player.buff(Enrage).duration >= w" },
		{ "Raging Blow" , "talent(6, 3)" },
		{ "Raging Blow" , { "!talent(6, 3)" , "player.buff(Enrage).duration <= 0" }},
		{ "Bloodthirst" },
		{ "Furious Slash" },		
	}, "player.rarea(7).enemies <= 1" },

	{{ -- MULTI
		{ "Dragon Roar" , "@Rubim.meleeRange()" },
		{ "Whirlwind" , { "player.buff(Meat Cleaver).duration <= 0" ,  "@Rubim.meleeRange()" }},
		{ "Rampage" , "player.buff(Enrage).duration <= 0" },
		{ "Rampage" , "player.rage >= 100" },
		{ "Bloodthirst" , "player.buff(Enrage).duration <= 0"},
		{ "Whirlwind" ,  { "@Rubim.meleeRange()" , "player.buff(Wrecking Ball).duration >= 1" }},
		{ "Raging Blow" , "player.rarea(7).enemies <= 3"},
		{ "Bloodthirst" , "player.buff(Enrage).duration >= 1"},
		{ "Whirlwind" , "@Rubim.meleeRange()" },
		
	}, "player.rarea(7).enemies >= 2" },
	
	
}

local outCombat = {
	{Shared}
}

NeP.Engine.registerRotation(266, '[|cff'..NeP.Interface.addonColor..'Rubim (WIP) Warlock - Demo', {
--		{'pause', 'modifier.lat'},
		{Shared},
		{inCombat}
	}, outCombat, exeOnLoad)