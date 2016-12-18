local _, Rubim = ...

local exeOnLoad = function()
	Rubim.meleeSpell = 53595
end

local Interrupts = {
	-- Mind freeze
--	{ '47528' },
}

local inCombat = {
	{ '@Rubim.Targeting' },
	{ '@Rubim.CastGroundSpell' },
	
--	{ "#trinket1" , { "target.boss" , "@Rubim.meleeRange"}},
--	{ Survival , "player.health < 100"},
	{'Avenger\'s Shield' , 'target.range > 7' },
	{'Judgment' , 'target.range > 7' },
	{{ -- SINGLE TARGET
		{'Hammer of the Righteous' , 'player.spell(Hammer of the Righteous).charges >= 1.8'},
		{'Avenger\'s Shield'},
		{'Judgment'},
		{'Hammer of the Righteous'},
	}, "player.area(7).enemies <= 1" },

	{{ -- MULTI
		{'Avenger\'s Shield'},
		{'Consecration'},
		{'Hammer of the Righteous' , 'player.spell(Hammer of the Righteous).charges >= 1.8'},
		{'Judgment'},
		{'Hammer of the Righteous'},
	}, "player.area(7).enemies >= 2" },
}

local outCombat = {
	{ '@Rubim.CastGroundSpell' }
}

NeP.CR:Add(66, '[RUB] Paladin - Protection', inCombat, outCombat, ExeOnLoad, GUI)