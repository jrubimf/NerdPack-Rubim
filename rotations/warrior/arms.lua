local _, Rubim = ...

local exeOnLoad = function()
--	NePCR.Splash()
	Rubim.meleeSpell = 23881
	print("|cffFFFF00 ----------------------------------------------------------------------|r")
	print("|cffFFFF00 --- |rWR |cffC41F3Arms |r")
	print("|cffFFFF00 --- |rPersonal use.")
	print("|cffFFFF00 ----------------------------------------------------------------------|r")
end

local UtilOFF = {
	{ '@Rubim.CastGroundSpell'},
}

local UtilC = {
	{ '@Rubim.CastGroundSpell'},
	{ '@Rubim.Targeting' },
}


local Cooldowns = {
	--actions+=/potion,name=old_war,if=(target.health.pct<20&buff.battle_cry.up)||target.time_to_die<=26
	--actions+=/blood_fury,if=buff.battle_cry.up||target.time_to_die<=16
	{'Blood Fury', 'player.buff(Battle Cry)'},
	--actions+=/berserking,if=buff.battle_cry.up||target.time_to_die<=11
	{'Berserking', 'player.buff(Battle Cry)'},
	--actions+=/arcane_torrent,if=buff.battle_cry_deadly_calm.down&rage.deficit>40
	--{'Arcane Torrent', 'player.buff(Battle Cry)&talent(6,1)&rage.deficit>40'},
	--actions+=/battle_cry,if=(buff.bloodlust.up||time>=1)&!gcd.duration&(buff.shattered_defenses.up||(cooldown.colossus_smash.duration&cooldown.warbreaker.duration))||target.time_to_die<=10
	{'Battle Cry', '{player.buff(Bloodlust)||player.combat.time>=1}&{player.buff(Shattered Defenses)||{spell(Colossus Smash).cooldown>gcd&spell(Warbreaker).cooldown>gcd}}'},
	--actions+=/avatar,if=(buff.bloodlust.up||time>=1)
	{'Avatar', 'talent(3,3)&{player.buff(Bloodlust)||player.combat.time>=1}'},
	--actions+=/use_item,name=gift_of_radiance
	--trinket...
}


local Util = {
	{Cooldowns, 'toggle(cooldowns)'},
	--actions+=/hamstring,if=buff.battle_cry_deadly_calm.duration>cooldown.hamstring.duration
	--{'Hamstring', 'player.buff(Battle Cry)&talent(6,1)&!target.debuff(Hamstring)'},	--waste of player.rage i would say unless ... it's PvP, maybe?
	--actions+=/heroic_leap,if=debuff.colossus_smash.up
	--manual usage of leap via ctrl keybind...
	--actions+=/rend,if=duration<gcd
	{'Rend', 'talent(3,2)&target.debuff(Rend).duration<gcd'},
	--# The tl;dr of this line is to spam focused player.rage inside battle cry, the added nonsense is to help modeling the difficulty of timing focused player.rage immediately after mortal strike.
	--# In game, if focused player.rage is used the same instant as mortal strike, player.rage will be deducted for focused player.rage, the buff is immediately consumed, but it does not buff the damage of mortal strike.
	--actions+=/focused_rage,if=buff.battle_cry_deadly_calm.duration>cooldown.focused_rage.duration&(buff.focused_rage.count<3||!cooldown.mortal_strike.up)&((!buff.focused_rage.react&prev_gcd.mortal_strike)||!prev_gcd.mortal_strike)
	{'Focused Rage', 'player.buff(Battle Cry)&talent(6,1)&player.buff(Focused Rage).count<3'},
	--actions+=/colossus_smash,if=debuff.colossus_smash.down
	{'Colossus Smash', '!target.debuff(Colossus Smash)'},
	--actions+=/warbreaker,if=debuff.colossus_smash.down
	{'Warbreaker', 'artifact(Warbreaker).equipped&!target.debuff(Colossus Smash)'},
	--actions+=/ravager
	{'Ravager', 'talent(7,3)'},
	--actions+=/overpower,if=buff.overpower.react
	{'Overpower', 'player.buff(Overpower)'}
}

local AoE = {
	--actions.aoe=mortal_strike
	{'Mortal Strike'},
	--actions.aoe+=/execute,if=buff.stone_heart.react
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'},
	--actions.aoe+=/colossus_smash,if=buff.shattered_defenses.down&buff.precise_strikes.down
	{'Colossus Smash', '!player.buff(Shattered Defenses)&!player.buff(Precise Strikes)'},
	--actions.aoe+=/warbreaker,if=buff.shattered_defenses.down
	{'Warbreaker', 'artifact(Warbreaker).equipped&!player.buff(Shattered Defenses)'},
	--actions.aoe+=/whirlwind,if=talent.fervor_of_battle.enabled&(debuff.colossus_smash.up||rage.deficit<50)&(!talent.focused_rage.enabled||buff.battle_cry_deadly_calm.up||buff.cleave.up)
	{'Whirlwind', 'talent(3,1)&{target.debuff(Colossus Smash)||rage.deficit<50}&{!talent(5,3)||{player.buff(Battle Cry)&talent(6,1)}||player.buff(Cleave)}'},
	--actions.aoe+=/rend,if=duration<=duration*0.3
	{'Rend', 'talent(3,2)&target.debuff(Rend).duration<=4.5'},
	--actions.aoe+=/bladestorm
	{'Bladestorm'},
	--actions.aoe+=/cleave
	{'Cleave'},
	--actions.aoe+=/whirlwind,if=player.rage>=60
	{'Whirlwind', 'player.rage>=60'},
	--actions.aoe+=/shockwave
	{'Shockwave', 'talent(2,1)'},
	--actions.aoe+=/storm_bolt
	{'Storm Bolt', 'talent(2,2)'}
}

local Cleave = {
	--actions.cleave=mortal_strike
	{'Mortal Strike'},
	--actions.cleave+=/execute,if=buff.stone_heart.react
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'},
	--actions.cleave+=/colossus_smash,if=buff.shattered_defenses.down&buff.precise_strikes.down
	{'Colossus Smash', '!player.buff(Shattered Defenses)&!player.buff(Precise Strikes)'},
	--actions.cleave+=/warbreaker,if=buff.shattered_defenses.down
	{'Warbreaker', 'artifact(Warbreaker).equipped&!player.buff(Shattered Defenses)'},
	--actions.cleave+=/focused_rage,if=buff.shattered_defenses.down
	{'Focused Rage', '!player.buff(Shattered Defenses)'},
	--actions.cleave+=/whirlwind,if=talent.fervor_of_battle.enabled&(debuff.colossus_smash.up||rage.deficit<50)&(!talent.focused_rage.enabled||buff.battle_cry_deadly_calm.up||buff.cleave.up)
	{'Whirlwind', 'talent(3,1)&{target.debuff(Colossus Smash)||rage.deficit<50}&{!talent(5,3)||{player.buff(Battle Cry)&talent(6,1)}||player.buff(Cleave)}'},
	--actions.cleave+=/rend,if=duration<=duration*0.3
	{'Rend', 'talent(3,2)&target.debuff(Rend).duration<=4.5'},
	--actions.cleave+=/bladestorm
	{'Bladestorm'},
	--actions.cleave+=/cleave
	{'Cleave'},
	--actions.cleave+=/whirlwind,if=player.rage>=100||buff.focused_rage.count=3
	{'Whirlwind', 'player.rage>=100||player.buff(Focused Rage).count=3'},
	--actions.cleave+=/shockwave
	{'Shockwave', 'talent(2,1)'},
	--actions.cleave+=/storm_bolt
	{'Storm Bolt', 'talent(2,2)'}
}

local Execute = {
	--actions.execute=mortal_strike,if=buff.battle_cry.up&buff.focused_rage.count=3
	{'Mortal Strike', 'player.buff(Battle Cry)&player.buff(Focused Rage).count=3'},
	--actions.execute+=/execute,if=buff.battle_cry_deadly_calm.up
	{'Execute', 'player.buff(Battle Cry)&talent(6,1)'},
	--actions.execute+=/colossus_smash,if=buff.shattered_defenses.down
	{'Colossus Smash', '!player.buff(Shattered Defenses)'},
	--actions.execute+=/warbreaker,if=buff.shattered_defenses.down&player.rage<=30
	{'Warbreaker', 'artifact(Warbreaker).equipped&!player.buff(Shattered Defenses)&player.rage<=30'},
	--actions.execute+=/execute,if=buff.shattered_defenses.up&player.rage>22||buff.shattered_defenses.down
	{'Execute', '{player.buff(Shattered Defenses)&player.rage>22}||!player.buff(Shattered Defenses)'}
}

local ST = {
	--actions.single=mortal_strike,if=buff.battle_cry.up&buff.focused_rage.count>=1&buff.battle_cry.duration<gcd
	{'Mortal Strike', 'player.buff(Battle Cry)&player.buff(Focused Rage).count>=1&spell(Battle Cry).cooldown<gcd'},
	--actions.single+=/colossus_smash,if=buff.shattered_defenses.down
	{'Colossus Smash', '!player.buff(Shattered Defenses)'},
	--actions.single+=/warbreaker,if=buff.shattered_defenses.down&cooldown.mortal_strike.duration<gcd
	{'Warbreaker', 'artifact(Warbreaker).equipped&!player.buff(Shattered Defenses)&spell(Mortal Strike).cooldown<gcd'},
	--actions.single+=/focused_rage,if=(((!buff.focused_rage.react&prev_gcd.mortal_strike)|!prev_gcd.mortal_strike)&buff.focused_rage.count<3&(buff.shattered_defenses.up|cooldown.colossus_smash.duration))&player.rage>60
	{'Focused Rage', '{{{!player.buff(Focused Rage)&prev_gcd(Mortal Strike)}||!prev_gcd(Mortal Strike)}&player.buff(Focused Rage).count<3&{player.buff(Shattered Defenses)||cooldown(Colossus Smash).duration>gcd}}&player.rage>60'},
	--actions.single+=/mortal_strike
	{'Mortal Strike'},
	--actions.single+=/execute,if=buff.stone_heart.react
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'},
	--actions.single+=/slam,if=buff.battle_cry_deadly_calm.up||buff.focused_rage.count=3||rage.deficit<=30
	{'Slam', '!talent(3,1)&{{player.buff(Battle Cry)&talent(6,1)}||player.buff(Focused Rage).count=3||rage.deficit<=30}'},
	--actions.single+=/slam
	--{'Slam'},
	--Whirlwind instead Slam if "Fevor of Battle" is picked
	{'Whirlwind', 'talent(3,1)&{{player.buff(Battle Cry)&talent(6,1)}||player.buff(Focused Rage).count=3||rage.deficit<=30}'},
	--actions.single+=/execute,if=equipped.archavons_heavy_hand
	{'Execute', 'equipped(137060)'},
	--actions.single+=/focused_rage,if=equipped.archavons_heavy_hand
	{'Focused Rage', 'equipped(137060)'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
	{'Heroic Leap', 'keybind(lcontrol)' , 'mouseover.ground'}
}

local Interrupts = {
	{'Pummel'},
	{'Arcane Torrent', 'target.range<=8&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.range<=8'},
	--{XeerX},
	--{Survival, 'player.health < 100'},
	--{Cooldowns, 'toggle(cooldowns)&target.range<8'},
	{Util, 'target.range<8'},
	--actions+=/run_action_list,name=cleave,if=spell_targets.whirlwind>=2&talent.sweeping_strikes.enabled
	{Cleave, 'toggle(aoe)&player.area(8).enemies>=2&talent(1,3)'},
	--actions+=/run_action_list,name=aoe,if=spell_targets.whirlwind>=2&!talent.sweeping_strikes.enabled
	{AoE, 'toggle(aoe)&player.area(8).enemies>=2&!talent(1,3)'},
	--actions+=/run_action_list,name=execute,if=target.health.pct<=20
	{Execute, 'target.range<8&target.health<=20'},
	--actions+=/run_action_list,name=single,if=target.health.pct>20
	{ST, 'target.range<8&target.health>20'}
}

local outCombat = {
	{ UtilOFF },
}

NeP.CR:Add(71, '[RUB] Warrior - Prot', inCombat, outCombat, exeOnLoad)