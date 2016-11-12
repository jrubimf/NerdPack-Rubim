local exeOnLoad = function()
	meleeSpell = 17364
	print("melee Spell: ".. GetSpellInfo(meleeSpell) .. "(" .. meleeSpell .. ")")

	NeP.Interface.CreateToggle(
		'selfHealing',
		'Interface\\Icons\\spell_deathknight_butcher2.png',
		'Save a Death Strike',
		'Saving Runic.')
		
	NeP.Interface.CreateToggle(
		'partyHealing',
		'Interface\\Icons\\spell_deathknight_butcher2.png',
		'Heal Party',
		'Heal Self.')
		
end

local Shared = {
	{ 'Ghost Wolf' , { 'player.movingfor >= 2' , '!player.buff' , 'player.rarea(7).enemies <= 0' }},
	{'@Rubim.CastGroundSpell()'},
}

local Survival = {

}

local Healing = {
	{{
		{ 'Healing Surge' , { 'player.maelstrom >= 20' , 'player.health <= 65' }},
	}, "toggle.selfHealing" },
	{{
		{ 'Healing Surge' , { 'player.maelstrom >= 20' , 'lowest.health <= 65' } , 'lowest' },
	}, "toggle.partyHealing" },
}

local Interrupts = {
}

local inCombat = {
	{ "/targetenemy [noexists]", "!target.exists" },
	{ "/targetenemy [dead]", { "target.exists", "target.dead" } },
	{ Healing },
	{ 'Boulderfist' , 'player.buff(Boulderfist).duration <= 3' },
	{ 'Frostbrand' , { 'player.buff(Frostbrand).duration <= 3' , 'talent(4, 3)' }},
	{ 'Boulderfist' , { 'player.maelstrom <= 130' , 'player.spell(Boulderfist).charges == 2' }},
	{ 'Flametongue' , 'player.buff(Flametongue),duration <= 3' },
	{ 'Crash Lightning' , 'player.rarea(7).enemies >= 3' },
	{ 'Stormstrike' },
	{ 'Crash Lightning' , { 'talent(6, 1)' , "player.rarea(7).enemies >= 3" }},
	{ 'Lava Lash' , 'player.maelstrom >= 110' },
	{ 'Boulderfist' },
	{ 'Flametonge' },
}

local outCombat = {
	{ 'Ghost Wolf' , { 'player.movingfor >= 1' , '!player.buff' }},
	{Shared}
}

NeP.Engine.registerRotation(263, '[|cff'..NeP.Interface.addonColor..'Rubim (WIP) Shaman - Enhancement', {
--		{'pause', 'modifier.lat'},
		{Shared},
		{inCombat}
	}, outCombat, exeOnLoad)