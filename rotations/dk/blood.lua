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
	Rubim.meleeSpell = 49998
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
	{ '@Rubim.CastGroundSpell' },
	{ 'Blood Fury' , 'player.area(8).enemies >= 1 & target.exists' }
}

local Interrupts = {
	{'Mind Freeze'},
}

local DRW = {
--	{ "@Rubim.SetText('DRW')" },
	{"Marrowrend" , "player.buff(Bone Shield).count <= 6 || player.buff(Bone Shield).duration <= 3" },
	{"Blood Boil" , "player.spell(Blood Boil).charges >= 1.8 & player.area(8).enemies >= 1" },
	{{
	{'Death Strike' , 'player.runicpower >= 75'},
	{'Heart Strike' },	
	{'Death Strike' },
	}, "player.onmelee" },
}

local DPS = {
--	{ "@Rubim.SetText('DPS')" },
	{{
	{"Marrowrend" , "player.buff(Bone Shield).count <= 6 || player.buff(Bone Shield).duration <= 3" },
	}, 'player.onmelee' },
	{{
	{'Death Strike' , 'player.runicpower >= 75'},
	{'Death Strike' , 'player.buff(Blood Shield)'},
	{'Heart Strike' },
	}, 'player.onmelee' },
}

local Burst = {
--  {"@Rubim.SetText('Burst')" },
	{{
	{"Marrowrend" , "player.buff(Bone Shield).count <= 6 || player.buff(Bone Shield).duration <= 3" },
	}, 'player.onmelee' },
	{{
		{{
		{'Death Strike' , 'player.health <= 70' },
		{'Death Strike' , 'player.runicpower >= 75'},
		}, "player.onmelee" },
		{'Blood Boil'},
		{{
		{'Heart Strike' },	
		}, "player.onmelee" },
	}, 'player.area(8).enemies >= 2'},
	
	{{
		{{
		{'Death Strike' , 'player.runicpower >= 75'},
		{"Marrowrend" , "player.buff(Bone Shield).count <= 6 || player.buff(Bone Shield).duration <= 3" },
		{"Heart Strike"},
		{'Death Strike'},
		}, "player.onmelee" },
		{'Blood Boil'},
	}, 'player.area(8).enemies <= 1'},
}

local Bonestorm = {
	{{
	{ "Death Strike" , "player.health <= 65 & !toggle(saveDS)" }, --DS Emergency		
	{ "Bonestorm" , "player.runicpower >= 90 & toggle(bonestorm) & player.areattd >= 10 & !toggle(saveDS)"}, --Bonestorm with enough RP
	{ "Death Strike" , "player.health <= 90 & !toggle(saveDS) & !toggle(bonestorm)" }, --DS to Heal
	{ "Death Strike" , "player.health <= 90 & !toggle(saveDS) & toggle(bonestorm) & player.spell(Bonestorm).cooldown >= 2" }, --Saving RP
	{ "Death Strike" , "player.runicpower >= 75 & !toggle(bonestorm)" }, --DS for RP Dump
	{ "Death Strike" , "player.spell(Bonestorm).cooldown >= 2 & player.runicpower >= 75 & toggle(bonestorm) & player.areattd >= 10" }, --DS for RP Dump if Bonestorm is on CD
	}, 'player.onmelee' },
}

local Bonestormless = {
	{{
	{ "Death Strike" , "player.health <= 90 & !toggle(saveDS)" }, --DS to Heal
	{ "Death Strike" , "player.runicpower >= 75" }, --DS for RP Dump		
	}, 'player.onmelee' },
}

local General = {
	{{
		{{
		{"Marrowrend" , "player.buff(Bone Shield).count <= 6 || player.buff(Bone Shield).duration <= 3" },
		}, 'player.onmelee' },
		{ Bonestorm , 'talent(7,1)' },
		{ Bonestormless , '!talent(7,1)' },
		{{
		{"Heart Strike" , "player.spell(Death and Decay).cooldown >= 4 & player.buff(Bone Shield).count >= 6" },
		{"Heart Strike" , "player.movingfor >= 1 & player.buff(Bone Shield).count >= 6" },
		{"Heart Strike" , "player.health <= 75 & player.buff(Bone Shield).count >= 6" },
		{"Heart Strike" , "player.runes >= 4.8 & player.buff(Bone Shield).count >= 6"},
		}, 'player.onmelee' },
	}, "player.area(10).enemies <= 2" },
	
	{{
		{{
		{"Marrowrend" , "player.buff(Bone Shield).count <= 6 || player.buff(Bone Shield).duration <= 3" },
		}, 'player.onmelee' },
		{ Bonestorm , 'talent(7,1)' },
		{ Bonestormless , '!talent(7,1)' },
		{"Blood Boil" , "player.area(8).enemies >= 1"},
		{{
		{"Heart Strike" , "player.spell(Death and Decay).cooldown >= 4"},
		{"Heart Strike" , "player.health <= 75" },
		{"Heart Strike" , "player.movingfor >= 1" },
		{"Heart Strike" , "player.runes >= 4.8"},
		}, 'player.onmelee' },
	}, "player.area(10).enemies >= 3" },
}

local inCombat = {
	{'%pause', 'keybind(lshift)'},
--	{ UtilOFF },
	{ UtilC },
	{ "Bonestorm" , "player.runicpower >= 90 & toggle(bonestorm) & player.areattd >= 10 & !toggle(saveDS)"}, --Bonestorm with enough RP
	{Interrupts, 'target.interruptAt(50) & toggle(interrupts)'},
--	{ Cooldowns , "player.area(8).enemies >= 1" },
	{{
		{"Blood Boil" , "target.debuff(Blood Plague).duration < 1.5" },
		{"Blood Boil" , "player.buff(Dancing Rune Weapon).duration > 0 & player.buff(Dancing Rune Weapon).duration < 3" },
		{"Blood Boil" , "player.spell(Blood Boil).charges >= 1.8" },
		{ "Vampiric Blood"  , "player.runicpower >= 35 & player.health <= 90 & player.runes <= 5.8" }, --VP with enough RP for a DS
	}, 'player.area(8).enemies >= 1' },
	{ Burst , "player.blood.rotation(burst)" },
	{ DRW , "player.blood.rotation(drw)" },
	{ DPS , "player.blood.rotation(dps)" },
	{ General },
}

local outCombat = {
	{ UtilOFF },
}

NeP.CR:Add(250, '[RUB] Death Knight - Blood', inCombat, outCombat, exeOnLoad, GUI)