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
}

local Interrupts = {
	{'Mind Freeze'},
}

local cd = {
	--actions.cd=invoke_xuen
	{ 'Invoke Xuen' , 'player.onmelee' },
	--actions.cd+=/use_item,name=tirathons_betrayal
	--actions.cd+=/blood_fury
	{ 'Blood Fury' , 'player.area(8).enemies >= 1 & target.exists' },
	--actions.cd+=/berserking
	--actions.cd+=/touch_of_death,cycle_targets=1,max_cycle_targets=2,if=!artifact.gale_burst.enabled&equipped.137057&!prev_ggcd.touch_of_death
	--actions.cd+=/touch_of_death,if=!artifact.gale_burst.enabled&!equipped.137057
	{ 'Touch of Death' , 'player.area(8).enemies >= 1 & target.exists' },--actions.cd+=/touch_of_death,cycle_targets=1,max_cycle_targets=2,if=artifact.gale_burst.enabled&equipped.137057&cooldown.strike_of_the_windlord.remains<8&cooldown.fists_of_fury.remains<=4&cooldown.rising_sun_kick.remains<7&!prev_ggcd.touch_of_death
	--actions.cd+=/touch_of_death,if=artifact.gale_burst.enabled&!equipped.137057&cooldown.strike_of_the_windlord.remains<8&cooldown.fists_of_fury.remains<=4&cooldown.rising_sun_kick.remains<7
}

local st = {
	--actions.st=call_action_list,name=cd
	{ cd },
	--actions.st+=/arcane_torrent,if=chi.max-chi>=1&energy.time_to_max>=0.5
	--actions.st+=/energizing_elixir,if=energy<energy.max&chi<=1
	{ 'Energizing Elixir' , 'player.energy<100&chi<=1&player.onmelee'},
	--actions.st+=/strike_of_the_windlord,if=talent.serenity.enabled|active_enemies<6
--	{ 'Strike of the Wind Lord' , }
	--actions.st+=/fists_of_fury
	{ 'Fists of Fury' , 'player.onmelee' },
	--actions.st+=/rising_sun_kick,cycle_targets=1
	{ 'Rising Sun Kick' },
	--actions.st+=/whirling_dragon_punch
	{ 'Whirling Dragon Punch' , 'player.onmelee' },
	--actions.st+=/spinning_crane_kick,if=active_enemies>=3&!prev_ggcd.spinning_crane_kick
	{ 'Spinning Crane Kick' , 'player.area(8).enemies >= 3 & player.lastcombo(Spinning Crane Kick)' },
	--actions.st+=/rushing_jade_wind,if=chi.max-chi>1&!prev_ggcd.rushing_jade_wind
	--actions.st+=/blackout_kick,cycle_targets=1,if=(chi>1|buff.bok_proc.up)&!prev_ggcd.blackout_kick
	{ 'Blackout Kick' , '{player.chi>1||player.buff(Blackout Kick!)}&player.lastcombo(Blackout Kick)' },
	--actions.st+=/chi_wave,if=energy.time_to_max>=2.25
--	{ 'Chi Wave' , 'player.timetomax >= 2.25' },
	--actions.st+=/chi_burst,if=energy.time_to_max>=2.25
--	{ 'Chi Burst' , 'player.timetomax >= 2.25' },
	--actions.st+=/tiger_palm,cycle_targets=1,if=!prev_ggcd.tiger_palm
	{ 'Tiger Palm' , 'player.lastcombo(Tiger Palm)' },
}

local sef = {
	--actions.sef=energizing_elixir
	{ 'Energizing Elixir' , 'player.onmelee'},
	--actions.sef+=/arcane_torrent,if=chi.max-chi>=1&energy.time_to_max>=0.5
	--actions.sef+=/call_action_list,name=cd
	{ cd },
	--actions.sef+=/storm_earth_and_fire
	{ 'Storm, Earth, and Fire' , 'player.onmelee' },
	--actions.sef+=/call_action_list,name=st
	{ st },
}

local inCombat = {
	{'%pause', 'keybind(lshift)'},
	{ '#trinket1' , 'player.buff(Death and Decay)' },
	{ UtilC },
	--actions=auto_attack
	--actions+=/spear_hand_strike,if=target.debuff.casting.react
	{Interrupts, 'target.interruptAt(50) & UI(interrupts)'},
	{ 'Tiger Palm' , 'player.chi < 1 & player.energy > 90' },
	--actions+=/potion,name=old_war,if=buff.serenity.up|buff.storm_earth_and_fire.up|(!talent.serenity.enabled&trinket.proc.agility.react)|buff.bloodlust.react|target.time_to_die<=60	--actions+=/call_action_list,name=serenity,if=(talent.serenity.enabled&cooldown.serenity.remains<=0)&((artifact.strike_of_the_windlord.enabled&cooldown.strike_of_the_windlord.remains<=14&cooldown.rising_sun_kick.remains<=4)|buff.serenity.up)	--actions+=/call_action_list,name=sef,if=!talent.serenity.enabled&((artifact.strike_of_the_windlord.enabled&cooldown.strike_of_the_windlord.remains<=14&cooldown.fists_of_fury.remains<=6&cooldown.rising_sun_kick.remains<=6)|buff.storm_earth_and_fire.up)	--actions+=/call_action_list,name=serenity,if=(talent.serenity.enabled&cooldown.serenity.remains<=0)&(!artifact.strike_of_the_windlord.enabled&cooldown.strike_of_the_windlord.remains<14&cooldown.fists_of_fury.remains<=15&cooldown.rising_sun_kick.remains<7)|buff.serenity.up
	--actions+=/call_action_list,name=sef,if=!talent.serenity.enabled&((!artifact.strike_of_the_windlord.enabled&cooldown.fists_of_fury.remains<=9&cooldown.rising_sun_kick.remains<=5)|buff.storm_earth_and_fire.up)
	{ sef , '{player.spell(Fists of Fury).cooldown <= 9 & player.spell(Rising Sun Kick).cooldown <= 5} || player.buff(Storm, Earth, and Fire'},
	--actions+=/call_action_list,name=st
	{ st },

}

local outCombat = {
	{ UtilOFF },
}

NeP.CR:Add(269, '[RUB] Monk - Windwalker', inCombat, outCombat, exeOnLoad)