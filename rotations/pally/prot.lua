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
--	{ '47528' },
}

local inCombat = {
	{ "#trinket1" , { "target.boss" , "@Rubim.meleeRange"}},
--	{ Survival , "player.health < 100"},
	{{ -- SINGLE TARGET
	--{'Demon\'s Bite'},
		{'Judgment'},
		{'Avenger\'s Shield'},
	}, "player.rarea(7).enemies <= 1" },

	{{ -- MULTI
		{'Judgment'},
		{'Avenger\'s Shield'},		
	}, "player.rarea(7).enemies >= 2" },
}

local outCombat = {
	{Shared}
}

NeP.Engine.registerRotation(66, '[|cff'..NeP.Interface.addonColor..'Rubim (WIP) Pally - Plotection', {
--		{'pause', 'modifier.lat'},
		{Shared},
		{inCombat}
	}, outCombat, exeOnLoad)