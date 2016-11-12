local exeOnLoad = function()
	meleeSpell = 100780
	print("melee Spell: ".. GetSpellInfo(meleeSpell) .. "(" .. meleeSpell .. ")")
end

local Shared = {

}

local Survival = {
	{ "Chi Wave" , "player.health <= 90"},

}

local Healing = {

}

local Interrupts = {
	-- Mind freeze
	{ '47528' },
}

local inCombat = {
	{ "/targetenemy [noexists]", "!target.exists" },
	{ "/targetenemy [dead]", { "target.exists", "target.dead" } },
	{ Survival , "player.health < 100"},
	{{ -- MULTI
		{ "Whirling Dragon Punch" , "player.rarea(7).enemies >= 1" },
		{ "Fists of Fury" , "target.ttd >= 5" },
		{ "Rising Sun Kick" , "player.spell(Fists of Fury).cooldown > 0" },
		{ "Spinning Crane Kick" , "player.rarea(7).enemies >= 1" },
		{ "Blackout Kick" , { "player.spell(Fists of Fury).cooldown > 0" , "player.spell(Rising Sun Kick).cooldown >= 1.5" }},
		{ "Tiger Palm" },		
		
	}, "player.rarea(7).enemies >= 2"},
	
	{{ -- SINGLE TARGET
		{ "Fists of Fury" },
		{ "Whirling Dragon Punch" , "player.rarea(7).enemies >= 1" },
		{ "Tiger Palm" , { "player.chi < 4" , "player.energy >= 80"}},
		{ "Rising Sun Kick" },
		{ "Chi Wave" },
		{ "Blackout Kick" , "player.spell(Rising Sun Kick).cooldown >= 1.5" },
		{ "Tiger Palm" },		
	}, "player.rarea(7).enemies <= 1" },
}

local outCombat = {
	{Shared}
}

NeP.Engine.registerRotation(269, '[|cff'..NeP.Interface.addonColor..'Rubim (WIP) Monk - Wind', {
--		{'pause', 'modifier.lat'},
		{Shared},
		{inCombat}
	}, outCombat, exeOnLoad)