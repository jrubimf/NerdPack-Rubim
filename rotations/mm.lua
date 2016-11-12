local exeOnLoad = function()
	NeP.Interface.CreateSetting('Class Settings', function() NeP.Interface.ShowGUI('RubConfDkBlood') end)
		NeP.Interface.CreateToggle(
		'saveDS',
		'Interface\\Icons\\spell_deathknight_butcher2.png',
		'Save a Death Strike',
		'Saving Runic.')
end

local Shared = {
	{{
	{{
	{ "Heroic Leap" , "@Rubim.DnD()" },
	}, "modifier.lalt" },
	}, "modifier.lcontrol" },
}

local Survival = {
	-- healthstone
	{ '#5512', 'player.health < 70'},
}

local Healing = {
	{ "Victory Rush" , { "player.health <= 90" , "player.buff(32216).duration < 31" }},
	{ "Victory Rush" , "player.buff(32216).duration < 5" },
	{ "Victory Rush", "player.health <= 50" },
}

local Interrupts = {
	-- Mind freeze
	{ '47528' },
}

local inCombat = {
	{ Healing },
	{ "Ignore Pain" , { "@Rubim.IG()" , "player.rage >= 80" , "target.ttd >= 4" }},

	{{ -- SINGLE TARGET
		{ "Shield Slam" },
		{ "Revenge, @Rubim.meleeRange" },
		{ "Devastate" },
		
		
	}, "player.rarea(10).enemies <= 2" },

	{{ -- MULTI
		{ "Revenge, @Rubim.meleeRange" },
		{ "Thunder Clap" , "@Rubim.AoERange" },
		{ "Shield Slam" },
		{ "Devastate" },
		
	}, "player.rarea(10).enemies >= 3" },
}

local outCombat = {
	{Shared}
}

NeP.Engine.registerRotation(268, '[|cff'..NeP.Interface.addonColor..'Rubim (WIP) Warrior - Prot', {
--		{'pause', 'modifier.lat'},
		{Shared},
		{inCombat}
	}, outCombat, exeOnLoad)