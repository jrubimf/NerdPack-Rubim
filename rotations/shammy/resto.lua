local exeOnLoad = function()
	meleeSpell = 1822
	print("melee Spell: ".. GetSpellInfo(meleeSpell) .. "(" .. meleeSpell .. ")")
end

local Shared = {
	{ 'Ghost Wolf' , { 'player.movingfor >= 2' , '!player.buff' , 'player.rarea(7).enemies <= 0' }},
	{'@Rubim.CastGroundSpell()'},
}

local Fast = {
	{ 'Riptide', { 'lowest.health < 95' , '!lowest.buff(Riptide)' }, 'lowest' },
	{ 'Riptide', 'lowest.health < 60' , 'lowest' },
	{'!Healing Surge', { 'lowest.health < 50', 'player.casting.percent <= 80' , } , 'lowest' },
	{'Healing Surge', 'lowest.health < 50' , 'lowest' },
	{'4987', 'player.dispellAll(4987)'},
}

local Tank = {
	{ 'Riptide', { 'tank.health < 95' , '!tank.buff(Riptide)' }, 'tank' },	
	{'!Healing Surge', 'tank.health < 60', 'tank'},
	{'!Healing Wave', 'tank.health < 90', 'tank'},
}

local Player = {
	{ 'Riptide', { 'player.health < 90' , '!player.buff(Riptide)' }, 'player' },	
	{ 'Healing Wave' , 'player.heatlh <= 80' },
	{ 'Healing Surge' , 'player.health < 60'},
}

local Lowest = {
	{ 'Healing Surge' , 'lowest.health <= 60' , 'lowest' },
	{ 'Healing Wave' , 'lowest.health <= 90' , 'lowest' },
	{ 'Chain Heal', 'AoEHeal(95, 3)', 'lowest'},
}

local inCombat = {
}

local outCombat = {
	{ 'Ghost Wolf' , { 'player.movingfor >= 1' , '!player.buff' }},
	{Shared},
	{Fast},
	{Tank, {'tank.exists', 'tank.health < 100'}},
	{Player, 'player.health < 100'},
	{Lowest, 'lowest.health < 100'},
}

NeP.Engine.registerRotation(264, '[|cff'..NeP.Interface.addonColor..'Rubim (WIP) Shammy - Healer', {
--		{'pause', 'modifier.lat'},
		{Shared},
		{Fast},
		{Tank, {'tank.exists', 'tank.health < 100'}},
		{Player, 'player.health < 100'},
		{Lowest, 'lowest.health < 100'},
	}, outCombat, exeOnLoad)