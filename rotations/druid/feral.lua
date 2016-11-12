local exeOnLoad = function()
	meleeSpell = 1822
	print("melee Spell: ".. GetSpellInfo(meleeSpell) .. "(" .. meleeSpell .. ")")
end

local Shared = {

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

local FM = {
	{'Ferocious Bite', { 'target.health <= 25',	'target.buff(Rip).duration < 5' }},
	{'Rip', 'target.buff(Rip).duration < 5'},
	{'Ferocious Bite'}
}

local inCombat = {
	{ Opener , 'player.time <= 10'},
	{ 'Tiger\'s Fury' , { "player.energy <= 40" , '@Rubim.meleeRange()' }},
	{'Healing Touch' , { 'player.buff(Predatory Swiftness).duration > 0' , 'player.buff(Predatory Swiftness).duration <= 3' }},
	{'Healing Touch' , { 'player.buff(Predatory Swiftness)' , 'player.health <= 90' }},
	{FM, 'player.combopoints >= 5'},
	{'Rake', '!target.debuff(Rake).duration <= 3'},
	{'Shred'},
}

local outCombat = {
	{Shared}
}

NeP.Engine.registerRotation(103, '[|cff'..NeP.Interface.addonColor..'Rubim (WIP) Druid - Fero', {
--		{'pause', 'modifier.lat'},
		{Shared},
		{inCombat}
	}, outCombat, exeOnLoad)