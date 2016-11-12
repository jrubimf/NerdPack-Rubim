local exeOnLoad = function()
	meleeSpell = 1822
	print("melee Spell: ".. GetSpellInfo(meleeSpell) .. "(" .. meleeSpell .. ")")
end

local Shared = {
	{'@Rubim.CastGroundSpell()'},
}

local Fast = {
	{'!Swiftmend', 'lowest.health < 50', 'lowest'},
}

local Tank = {
	{'!Swiftmend', 'tank.health < 60', 'tank'},
--	{'Efflorescence', 'tank.buff(Efflorescence ).duration < 1', 'tank'},
	{ 'Life Bloom', { 'tank.health < 80' , '!tank.buff(Life Bloom)' }, 'tank' },	
	{ 'Rejuvenation', { 'tank.health < 90' , '!tank.buff(Rejuvenation)' }, 'tank' },	
	{ 'Healing Touch' , 'tank.health < 79' , 'tank' },
}

local Player = {
	{ 'Rejuvenation', { 'player.health < 90' , '!player.buff(Rejuvenation)' }, 'player' },	
	{ 'Life Bloom', { 'player.health < 80' , '!player.buff(Life Bloom)' }, 'player' },	
	{ 'Healing Touch' , 'player.health < 79'},
}

local Lowest = {
	{ 'Regrowth', 'AoEHeal(90, 2)', 'lowest'},
	{ 'Wild Growth', 'AoEHeal(75, 6)', 'lowest'},
	{ 'Rejuvenation', { 'lowest.health < 90' , '!lowest.buff(Rejuvenation)' }, 'lowest' },	
	{ 'Life Bloom', { 'lowest.health < 80' , '!lowest.buff(Life Bloom)' }, 'lowest' },	
	{ 'Healing Touch' , 'lowest.health < 79'},
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

NeP.Engine.registerRotation(105, '[|cff'..NeP.Interface.addonColor..'Rubim (WIP) Druid - Balanço', {
--		{'pause', 'modifier.lat'},
		{Fast},
		{Tank, {'tank.exists', 'tank.health < 100'}},
		{Player, 'player.health < 100'},
		{Lowest, 'lowest.health < 100'},
	}, outCombat, exeOnLoad)