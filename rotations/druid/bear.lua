local exeOnLoad = function()
	meleeSpell = 1822
	print("melee Spell: ".. GetSpellInfo(meleeSpell) .. "(" .. meleeSpell .. ")")
	NeP.Interface.CreateToggle(
		'moonfireAOE',
		'Interface\\Icons\\spell_deathknight_butcher2.png',
		'Save a Death Strike',
		'Saving Runic.')
end

local Shared = {
	{'@Rubim.CastGroundSpell()'},
}

local Survival = {
}

local Interrupts = {
}

local Util = {
	--AUTOTARGET
	{ '@Rubim.Targeting()' , '!target.alive' },
	
	--BOSS
	{ '%pause' , 'player.debuff(200904)' },
	{ '%pause' , 'player.debuff(Soul Saped)' },
}

local BearForm = {
	{{
		{'Frenzied Regeneration' , { 'player.spell(Frenzied Regeneration).charges == 2' , 'player.health <= 90'}},
		{'Ironfur' , "!player.buff"},
--		{'Maul' , "@Rubim.WarriorFR()" },
		{'Maul','player.rage >= 80'},
		{'Mangle'},
		{'Thrash','player.rubimarea(7).enemies >= 1'},
		{'Swipe', {'@Rubim.AggroCheck','player.rubimarea(7).enemies >= 1'}},
		{'Moonfire','player.buff(Galactic Guardian).duration > 0'},
		{'@Rubim.MoonfireAOE()' , '!toggle.moonfireAOE' },
		{'Swipe','player.rubimarea(7).enemies >= 1'},
	},'player.rubimarea(7).enemies <= 2'},
	
	{{
		{'Maul','player.rage >= 80'},
		{'Thrash','player.rubimarea(7).enemies >= 1'},
		{'Mangle'},
		{'Moonfire','player.buff(Galactic Guardian).duration >= 1'},
		{'@Rubim.MoonfireAOE()' , '!toggle.moonfireAOE'},
		{'Swipe', {'@Rubim.AggroCheck','player.rubimarea(7).enemies >= 1'}},	
		{'Swipe','player.rubimarea(7).enemies >= 1'},
	},'player.rubimarea(7).enemies >= 3'},
}

local CatForm = {
	{'Thrash','player.rubimarea(7).enemies >= 1'},
	{'Mangle'},
}

local inCombatss = {
	{'Moonfire','@Rubim.MoonfireAOE()'},
}

local inCombat = {
	{ Utils },
	{ BearForm ,'player.form == 1'},
	{ CatForm ,'player.form == 2'},
}

local outCombat = {
	{Shared}
}

NeP.Engine.registerRotation(104,'[|cff'..NeP.Interface.addonColor..'Rubim (WIP) Druid - Bear', {
--		{'pause','modifier.lat'},
		{Shared},
		{inCombat}
	}, outCombat, exeOnLoad)