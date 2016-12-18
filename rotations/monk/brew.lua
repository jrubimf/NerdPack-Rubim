local _, Rubim = ...

local GUI = {
	{type = 'header', text = 'Keybinds:'},
	{type = 'text', text = 'Lshift: Pause\n'},
	{type = 'spacer'},{type = 'ruler'},
	{type = 'checkbox', text = 'Automated Death and Decay', key = 'aDnD', default = false},
	{type = 'checkbox', text = 'Save DS', key = 'saveDS', default = false},
	{type = 'checkbox', text = 'Bonestorm', key = 'bonestorm', default = false}
}

local exeOnLoad = function()
--	NePCR.Splash()
	Rubim.meleeSpell = 100780
	print("|cffFFFF00 ----------------------------------------------------------------------|r")
	print("|cffFFFF00 --- |rDeath Knight |cffC41F3BBlood |r")
	print("|cffFFFF00 --- |rRecommended Talents: 1/2 - 2/1 - 3/1 - 4/2 - 5/1 - 6/3 - 7/1")
	print("|cffFFFF00 --- |rPersonal use.")
	print("|cffFFFF00 ----------------------------------------------------------------------|r")
end

local UtilOFF = {
	{ '@Rubim.CastGroundSpell' }
}

local UtilC = {
	{ '@Rubim.Targeting' },
	{ '@Rubim.CastGroundSpell' },
	{ 'Blood Fury' , 'player.area(8).enemies >= 1 & target.exists' }
}

local Interrupts = {
	{'Mind Freeze'},
}

local inCombat = {
	{'%pause', 'keybind(lshift)'},
	{ '#trinket1' , 'player.buff(Death and Decay)' },
--	{ UtilOFF },
	{ UtilC },
	{Interrupts, 'target.interruptAt(50) & UI(interrupts)'},
	{ "Healing Elixir" , "player.spell(Healing Elixir).charges >= 1.5 & player.health <= 80 & player.gcddelay" },
	{ "Ironskin Brew" , "!player.buff(Ironskin Brew) & player.spell(Ironskin Brew).charges >= 3.5 & player.gcddelay & {player.debuff(Light Stagger) || player.debuff(Medium Stagger) || player.debuff(Heavy Stagger)}" },
	{ "Purifying Brew" , 'player.buff(Ironskin Brew) & player.buff(Ironskin Brew).duration <= 1 & player.gcddelay & {player.debuff(Light Stagger) || player.debuff(Medium Stagger) || player.debuff(Heavy Stagger)}'},
--	{ Cooldowns , "player.area(8).enemies >= 1" },
	{{
		{ "Keg Smash" , 'target.exists' },
		{ "Breath of Fire" , 'inmelee'},
		{ "Blackout Strike" , 'target.exists' },
		{ "Tiger Palm" , "player.energy >= 65" },
	}, 'player.area(8).enemies >= 2' },
	{{
		{ "Keg Smash" , 'target.exists' },
		{ "Blackout Strike" , 'target.exists' },
		{ "Breath of Fire" , "inmelee"},
		{ "Tiger Palm" , "player.energy >= 65" },
	}, 'player.area(8).enemies <= 1' },
}

local outCombat = {
	{ UtilOFF },
}

NeP.CR:Add(268, '[RUB] Monk - Brewmaster', inCombat, outCombat, exeOnLoad, GUI)