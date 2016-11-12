local exeOnLoad = function()
	meleeSpell = 1822
	print("melee Spell: ".. GetSpellInfo(meleeSpell) .. "(" .. meleeSpell .. ")")
end

local Shared = {
	{'@Rubim.CastGroundSpell()'},
}

local Survival = {

}

local Healing = {
	{'Healing Touch' , { 'player.buff(Predatory Swiftness)' , 'player.heatlh <= 90' }},
}

local Interrupts = {
}

local Opener = {
	{'Rip' , 'player.combopoints >= 5'},
	{'Tiger\'s Fury','@Rubim.meleeRange()'},
	{'Shred'},
}

local moving = {
	{'Starsurge'},
	{'Sunfire', '!lastcast(Sunfire)'},
	{'Moonfire', '!lastcast(Moonfire)'},
}

local inCombat = {
	{ moving , 'player.moving' },
	{'Sunfire', 'target.debuff(Sunfire).duration <= 3'},
	{'Moonfire', 'target.debuff(Moonfire).duration <= 3'},
	{'Starsurge', 'player.energy >= 65'},
	{'Lunar Strike', 'player.buff(Luna Strike).charges >= 2'},
	{'Solar Wrath' , 'player.buff(Luna Strike).charges >= 2'},
	{'Solar Wrath' ,  "player.rarea(15).enemies <= 1" },
	{'Lunar Strike' ,  "player.rarea(15).enemies >= 2" },
}

local outCombat = {
	{Shared}
}

NeP.Engine.registerRotation(102, '[|cff'..NeP.Interface.addonColor..'Rubim (WIP) Druid - Balanço', {
--		{'pause', 'modifier.lat'},
		{Shared},
		{inCombat}
	}, outCombat, exeOnLoad)