local _, Rubim = ...

local GUI = {
	{type = 'header', text = 'Keybinds:'},
	{type = 'text', text = 'Lshift: Pause\n'},
	{type = 'text', text = 'Lctrl: DPS Mode\n'},
	{type = 'spacer'},{type = 'ruler'},
	{type = 'checkbox', text = 'Automated Death and Decay (Disabled)', key = 'aDnD', default = false},
	{type = 'checkbox', text = 'Bonestorm', key = 'bonestorm', default = false}
}

local exeOnLoad = function()
--	NePCR.Splash()
	Rubim.meleeSpell = 49998
	NeP.Interface:AddToggle({
  		key = 'saveDS',
  		icon = 'Interface\\Icons\\spell_deathknight_butcher2.png',
  		name = 'Save DS',
  		text = 'Save DS.'
	})
	NeP.Interface:AddToggle({
		key = 'taunt',
		name = 'Taunt Units',
		text = 'Enable to taunt units you dont have aggro from.',
		icon = 'Interface\\Icons\\Ability_warrior_charge',
	})
	print("|cffFFFF00 ----------------------------------------------------------------------|r")
	print("|cffFFFF00 --- |rDeath Knight |cffC41F3BBlood |r")
	print("|cffFFFF00 --- |rRecommended Talents: 1/2 - 2/1 - 3/1 - 4/2 - 5/1 - 6/3 - 7/1")
	print("|cffFFFF00 --- |rRead the Github.")
	print("|cffFFFF00 ----------------------------------------------------------------------|r")
end

local Taunts = {
	--Dark Command Use to establish threat on targets not attacking you.
	{'%taunt(Dark Command)'},
}

local Cooldowns = {
	{ "Vampiric Blood" , "player.runicpower >= 35 & player.health <= 90 & player.runes <= 5.8" }, --VP with enough RP for a DS
}
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

local DRW = {
	{ "@Rubim.SetText('DRW')" },
	{"Marrowrend" , "player.buff(Bone Shield).count <= 6 || player.buff(Bone Shield).duration <= 3" },
	{"Blood Boil" , "player.spell(Blood Boil).charges >= 1.8 & player.area(8).enemies >= 1" },
	{{
	{'Death Strike' , 'lastcast(Death Strike)' },
	{'Death Strike' , 'player.runicpower >= 80'},
	{'Heart Strike' },	
	{'Death Strike' },
	}, "player.onmelee" },
}

local DPS = {
	{ "@Rubim.SetText('DPS')" },
	{{
	{"Marrowrend" , "player.buff(Bone Shield).count <= 6 || player.buff(Bone Shield).duration <= 3" },
	}, 'player.onmelee' },
	{{
	{'Death Strike' , 'player.runicpower >= 80'},
	{'Death Strike' , 'player.buff(Blood Shield).duration > 0'},
	{'Heart Strike' },
	}, 'player.onmelee' },
}

local Burst = {
  {"@Rubim.SetText('Burst')" },
	{{
	{"Marrowrend" , "player.buff(Bone Shield).count <= 6 || player.buff(Bone Shield).duration <= 3" },
	}, 'player.onmelee' },
	{{
		{{
		{'Death Strike' , 'player.health <= 70' },
		{'Death Strike' , 'player.runicpower >= 80'},
		}, "player.onmelee" },
		{'Blood Boil'},
		{{
		{'Heart Strike' },	
		}, "player.onmelee" },
	}, 'player.area(8).enemies >= 2'},
	
	{{
		{{
		{'Death Strike' , 'player.runicpower >= 80'},
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
	{ "Bonestorm" , "player.runicpower >= 90 & UI(bonestorm) & player.areattd >= 10 & !toggle(saveDS)"}, --Bonestorm with enough RP
	{ "Death Strike" , "player.health <= 90 & !toggle(saveDS) & !UI(bonestorm)" }, --DS to Heal
	{ "Death Strike" , "player.health <= 90 & !toggle(saveDS) & UI(bonestorm) & player.spell(Bonestorm).cooldown >= 2" }, --Saving RP
	{ "Death Strike" , "player.runicpower >= 80 & !UI(bonestorm)" }, --DS for RP Dump
	{ "Death Strike" , "player.spell(Bonestorm).cooldown >= 2 & player.runicpower >= 80 & UI(bonestorm) & player.areattd >= 10" }, --DS for RP Dump if Bonestorm is on CD
	}, 'player.onmelee' },
}

local Bonestormless = {
	{{
	{ "Death Strike" , "player.health <= 90 & !toggle(saveDS)" }, --DS to Heal
	{ "Death Strike" , "player.runicpower >= 80" }, --DS for RP Dump		
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
		{"Heart Strike" , "player.health <= 80 & player.buff(Bone Shield).count >= 6" },
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
		{"Heart Strike" , "player.health <= 80" },
		{"Heart Strike" , "player.movingfor >= 1" },
		{"Heart Strike" , "player.runes >= 4.8"},
		}, 'player.onmelee' },
	}, "player.area(10).enemies >= 3" },
}

local inCombat = {
	{'%pause', 'keybind(lshift)'},
	{ '#trinket1' , 'player.buff(Death and Decay) & equipped(Ravaged Seed Pod)' },
	{ UtilC },
	{ Taunts , 'toggle(taunt)'},
	{ "Bonestorm" , "player.runicpower >= 90 & UI(bonestorm) & player.areattd >= 10 & !toggle(saveDS)"}, --Bonestorm with enough RP
	{Interrupts, 'target.interruptAt(50) & UI(interrupts)'},
	{Cooldowns, 'toggle(cooldowns) & player.area(8).enemies >= 1'},
	{{
		{"Blood Boil" , "target.debuff(Blood Plague).duration < 1.5" },
		{"Blood Boil" , "player.buff(Dancing Rune Weapon).duration > 0 & player.buff(Dancing Rune Weapon).duration < 3" },
		{"Blood Boil" , "player.spell(Blood Boil).charges >= 1.8" },
	}, 'player.area(8).enemies >= 1' },
	{ Burst , "player.blood.rotation(burst)" },
	{ DRW , "player.blood.rotation(drw)" },
	{ DPS , "player.blood.rotation(dps) || keybind(lcontrol)" },
	{ General },
}

local outCombat = {
	{ UtilOFF },
}

NeP.CR:Add(250, '[RUB] Death Knight - Blood', inCombat, outCombat, exeOnLoad, GUI)