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
	
}

local Interrupts = {
	-- Mind freeze
	
}

local Opener = {
	{ "Dragon Roar" , "@Rubim.meleeRange()" },
	{ "Avatar" , "@Rubim.meleeRange()" },
	{ "Battle Cry" , "@Rubim.meleeRange()" },
	{ "Bloodthirst" },
	
}

local inCombat = {
	{"Marked Shot"},
	{"Barrage"},
	{"Multi-Shot" , "target.area(6).enemies >= 3"},
	{"Aimed Shot" , "target.area(6).enemies <= 2"},
	{"Sidewinders"},
	{"Arcane Shot"}
}

local outCombat = {
	{Shared}
}

NeP.Engine.registerRotation(254, '[|cff'..NeP.Interface.addonColor..'Rubim (WIP) Warlock - Demo', {
--		{'pause', 'modifier.lat'},
		{Shared},
		{inCombat}
	}, outCombat, exeOnLoad)