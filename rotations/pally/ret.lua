local exeOnLoad = function()
	NeP.Interface.CreateSetting('Class Settings', function() NeP.Interface.ShowGUI('RubConfDkBlood') end)
		NeP.Interface.CreateToggle(
		'saveDS',
		'Interface\\Icons\\spell_deathknight_butcher2.png',
		'Save a Death Strike',
		'Saving Runic.')
end

local Shared = {

}

local Survival = {
	-- healthstone

}

local Healing = {

}

local Interrupts = {
	-- Mind freeze
	{ '47528' },
}

local inCombat = {
--	{ Survival , "player.health < 100"},
	{{ -- SINGLE TARGET
		{ "Fists of Fury" },
		{ "Whirling Dragon Punch" , "@Rubim.meleeRange()" },
		{ "Tiger Palm" , { "player.chi < 4" , "player.energy >= 80"}},
		{ "Rising Sun Kick" },
		{ "Chi Wave" },
		{ "Blackout Kick" , "player.spell(Rising Sun Kick).cooldown >= 1.5" },
		{ "Tiger Palm" },		
	}, "player.rarea(7).enemies <= 1" },

	{{ -- MULTI
		{ "Whirling Dragon Punch" , "@Rubim.meleeRange()" },
		{ "Fists of Fury" , "target.ttd >= 5" },
		{ "Rising Sun Kick" , "player.spell(Fists of Fury).cooldown > 0" },
		{ "Spinning Crane Kick" , "@Rubim.meleeRange()" },
		{ "Blackout Kick" , { "player.spell(Fists of Fury).cooldown > 0" , "player.spell(Rising Sun Kick).cooldown >= 1.5" }},
		{ "Chi Wave" },
		{ "Tiger Palm" },		
		
	}, "player.rarea(7).enemies >= 2" },
}

local outCombat = {
	{Shared}
}

NeP.Engine.registerRotation(999, '[|cff'..NeP.Interface.addonColor..'Rubim (WIP) Monk - Wind', {
--		{'pause', 'modifier.lat'},
		{Shared},
		{inCombat}
	}, outCombat, exeOnLoad)