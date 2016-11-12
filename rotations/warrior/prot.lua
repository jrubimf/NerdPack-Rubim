local _, Rubim = ...

local exeOnLoad = function()
--	NePCR.Splash()
	Rubim.meleeSpell = 6552
	print("|cffFFFF00 ----------------------------------------------------------------------|r")
	print("|cffFFFF00 --- |rWR |cffC41F3BBlood |r")
	print("|cffFFFF00 --- |rRecommended Talents: 1/2 - 2/1 - 3/1 - 4/2 - 5/1 - 6/3 - 7/1")
	print("|cffFFFF00 --- |rPersonal use.")
	print("|cffFFFF00 ----------------------------------------------------------------------|r")

	NeP.Interface:AddToggle({
		key = 'saveDS',
		icon = 'Interface\\Icons\\spell_deathknight_butcher2.png',
		name = 'Save Death Strike',
		text = 'BOT will Only Death Strike when RP is Capped, useful on fights were you need to cast an active mitigation.'
	})
		
	NeP.Interface:AddToggle({
		key = 'bonestorm',
		icon = 'Interface\\Icons\\Ability_deathknight_boneshield.png',
		name = 'Use 194844',
		text = 'This will pool RP to use 194844.'
	})
	
	NeP.Interface:AddToggle({
		key = 'aoetaunt',
		icon = 'Interface\\Icons\\spell_nature_shamanrage.png',
		name = 'Aoe Taunt',
		text = 'Experimental AoE Taunt.'
	 })		
	
end

local UtilOFF = {
	{ '@Rubim.CastGroundSpell'},
}

local UtilC = {
	{ '@Rubim.CastGroundSpell'},
	{ '@Rubim.Targeting' },
}


local Survival = {
	{{
	{'!Ignore Pain','{player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage>=13}||{!player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage>=20}||{player.rage>=60&!talent(6,1)}||{player.buff(Vengeance: Ignore Pain)&player.buff(Ultimatum)}||{player.buff(Vengeance: Ignore Pain)&player.rage>=30}||{talent(6,1)&!player.buff(Ultimatum)&!player.buff(Vengeance: Ignore Pain)&!player.buff(Vengeance: Focused Rage)&player.rage<30}'},
	{ "Shield Block" , "player.buff(Ignore Pain).duration <= 0 & target.ttd >= 4 & !player.buff(Shield Block) & player.rarea(10).enemies >= 2" },
	{ "Shield Block" , "player.rage <= 40 & !player.buff(Shield Block) & player.spell(Shield Block).charges >= 1.8" },
	{ "Ignore Pain" , "player.buff(Shield Block).duration <= 0 & player.rage <= 30 & player.buff(Ignore Pain).duration <= 0" },
	}, "player.area(7).enemies >= 1" },
	{ "Battle Cry" , "player.area(7).enemies >= 1 & player.areattd >= 10" },
	{ "Avatar" , "player.area(7).enemies >= 1 & player.areattd >= 10" },
}

local Healing = {
	{ "Victory Rush" , "player.health <= 90 & player.buff(32216).duration < 31" },
	{ "Victory Rush" , "player.buff(32216).duration < 5" },
	{ "Victory Rush", "player.health <= 50" },
	{ "Impending Victory", "player.health <= 90" },
}

local Interrupts = {
	{ 'Pummel' },
}

local inCombat = {
	{ UtilC , 'customfunction' },
	{{
	{ "Focused Rage" , "player.buff(Vengeance: Ignore Pain)" },
	{ "Ignore Pain" , "player.buff(Vengeance: Focused Rage)" },
	}, "player.area(7).enemies >= 1"},
	{ Healing },
	{ Survival },
--	{ "Focused Rage" , "@Rubim.WarriorFR" },
	{{ -- SINGLE TARGET
		{'Shield Slam', '!{spell(Shield Block).cooldown<=gcd&!player.buff(Shield Block)&talent(7,2)}||{player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage<13}||{!player.buff(Vengeance: Ignore 	Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage<20}||'},
		{'Shield Slam', '!talent(7,2)'},
	--actions.prot+=/revenge,if=cooldown.shield_slam.remains<=gcd.max*2
		{'Revenge', 'spell(Shield Slam).cooldown<=gcd*2||player.rage<=5'},
	--actions.prot+=/devastate
		{'Devastate'}
	}, "player.area(10).enemies <= 2" },

	{{ -- MULTI
		{ "Revenge" , "player.area(7).enemies >= 1" },
		{ "Thunder Clap" , "player.area(7).enemies >= 1" },
		{ "Shield Slam" },
		{ "Devastate" },
		
	}, "player.area(10).enemies >= 3" },
}

local outCombat = {
	{ UtilOFF , 'customfunction' },
}

NeP.CR:Add(73, '[RUB] Warrior - Prot', inCombat, outCombat, exeOnLoad)