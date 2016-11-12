local exeOnLoad = function()
	meleeSpell = 100780
	print("melee Spell: ".. GetSpellInfo(meleeSpell) .. "(" .. meleeSpell .. ")")
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
	{ "Expel Harm" , { "player.health <= 75" , "player.spell(Expel Harm).charges >= 3" }},
	{ "Purifying Brew", { "@Rubim.DelayStagger()" , "@Rubim.DrinkStagger()" }},
	{ "Healing Elixir" , { "player.health <= 85" , "@Rubim.DelayHealing()" }},
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
	{ Survival , "player.health < 100"},
--	{ "Ignore Pain" , { "@Rubim.IG()" , "player.rage >= 80" , "target.ttd >= 4" }},

	{{ -- SINGLE TARGET
		{ "Blackout Strike" },
		{ "Keg Smash", { "@Rubim.meleeRange()" , "player.buff(Blackout Combo)" }},
		{ "Tiger Palm" , "player.energy >= 65" },
		{ "Breath of Fire" , { "target.debuff(Keg Smash) >= 1" , "@Rubim.meleeRange" }},
		
		
	}, "player.rarea(10).enemies <= 2" },

	{{ -- MULTI
		{ "Blackout Strike" },
		{ "Keg Smash", { "@Rubim.meleeRange()" , "player.buff(Blackout Combo)" }},
		{ "Breath of Fire" , { "target.debuff(Keg Smash) >= 1" , "@Rubim.meleeRange()" }},
		{ "Tiger Palm" , "player.energy >= 65" },
		{ "Blackout Strike" },
		
	}, "player.rarea(10).enemies >= 3" },
}

local outCombat = {
	{Shared}
}

NeP.Engine.registerRotation(268, '[|cff'..NeP.Interface.addonColor..'Rubim (WIP) Monk - Brewshit', {
--		{'pause', 'modifier.lat'},
		{Shared},
		{inCombat}
	}, outCombat, exeOnLoad)