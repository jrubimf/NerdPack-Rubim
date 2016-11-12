local _, Rubim = ...

local exeOnLoad = function()
--	NePCR.Splash()
	Rubim.meleeSpell = 23881
	print("|cffFFFF00 ----------------------------------------------------------------------|r")
	print("|cffFFFF00 --- |rWR |cffC41F3Fury |r")
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


local Cooldowns = {
	--actions+=/use_item,name=faulty_countermeasure,if=(spell_targets.whirlwind>1||!raid_event.adds.exists)&((talent.bladestorm.enabled&cooldown.bladestorm.duration=0)||buff.battle_cry.up||target.time_to_die<25)
	--actions+=/potion,name=old_war,if=(target.health.pct<20&buff.battle_cry.up)||target.time_to_die<30
	--actions+=/battle_cry,if=(cooldown.odyns_fury.duration=0&(cooldown.bloodthirst.duration=0||(buff.enrage.duration>cooldown.bloodthirst.duration)))
	{'Battle Cry', '{spell(Odyn\'s Fury).cooldown=0&{spell(Bloodthirst).cooldown=0||{player.buff(Enrage).duration>spell(Bloodthirst).cooldown}}}'},
	--actions+=/avatar,if=buff.battle_cry.up||(target.time_to_die<(cooldown.battle_cry.duration+10))
	{'Avatar', 'player.buff(Battle Cry)'}, --todo: TTD<{spell(Battle Cry).cooldown+10}
	--actions+=/bloodbath,if=buff.dragon_roar.up||(!talent.dragon_roar.enabled&(buff.battle_cry.up||cooldown.battle_cry.duration>10))
	{'Bloodbath', 'player.buff(Dragon Roar)||{!talent(7,3)&{player.buff(Battle Cry)||spell(Battle Cry).cooldown>10}}'},
	--actions+=/blood_fury,if=buff.battle_cry.up
	{'Blood Fury', 'player.buff(Battle Cry)'},
	--actions+=/berserking,if=buff.battle_cry.up
	{'Berserking', 'player.buff(Battle Cry)'},
}

local Bladestorm = {
	--actions.bladestorm=bladestorm,if=buff.enrage.duration>2&(raid_event.adds.in>90||!raid_event.adds.exists||spell_targets.bladestorm_mh>desired_targets)
	{'Bladestorm', 'talent(7,1)&player.buff(Enrage).duration>2'}, --raid_event not supported
}

local AoE = {
	--actions.aoe=bloodthirst,if=buff.enrage.down||player.rage<50
	{'Bloodthirst', '!player.buff(Enrage)||player.rage<50'},
	--actions.aoe+=/call_action_list,name=bladestorm
	{Bladestorm},
	--actions.aoe+=/whirlwind,if=buff.enrage.up
	{'Whirlwind', 'player.buff(Enrage)'},
	--actions.aoe+=/dragon_roar
	{'Dragon Roar', 'talent(7,3)'},
	--actions.aoe+=/rampage,if=buff.meat_cleaver.up
	{'Rampage', 'player.buff(Meat Cleaver)'},
	--actions.aoe+=/bloodthirst
	{'Bloodthirst'},
	--actions.aoe+=/whirlwind
	{'Whirlwind'},
}


local ST = {
	--actions.single_target=bloodthirst,if=buff.fujiedas_fury.up&buff.fujiedas_fury.duration<2
	{'Bloodthirst', 'player.buff(Fujieda\'s Fury)&player.buff(Fujieda\'s Fury).stack<2'},
	--actions.single_target+=/execute,if=(artifact.juggernaut.enabled&(!buff.juggernaut.up||buff.juggernaut.duration<2))||buff.stone_heart
	{'Execute', '{artifact(Juggernaut).enabled&{!player.buff(Juggernaut)||player.buff(Juggernaut).duration<2}}||player.buff(Stone Heart)'},
	--actions.single_target+=/rampage,if=player.rage=100&(target.health.pct>20||target.health.pct<20&!talent.massacre.enabled)||buff.massacre&buff.enrage.duration<1
	{'Rampage', 'player.rage=100&{target.health>20||{target.health<20&!talent(5,1)}||{player.buff(Massacre)&player.buff(Enrage).duration<1}}'},
	--actions.single_target+=/berserker_rage,if=talent.outburst.enabled&cooldown.odyns_fury.duration=0&buff.enrage.down
	{'Berserker Rage', 'talent(3,2)&spell(Odyn\'s Fury).cooldown=0&!player.buff(Enrage)'},
	--actions.single_target+=/dragon_roar,if=!cooldown.odyns_fury.duration<=10||cooldown.odyns_fury.duration<3
	{'Dragon Roar', '!spell(Odyn\'s Fury).cooldown<=10||spell(Odyn\'s Fury).cooldown<3'},
	--actions.single_target+=/odyns_fury,if=buff.battle_cry.up&buff.enrage.up
	{'Odyn\'s Fury', 'player.buff(Battle Cry)&player.buff(Enrage)'},
	--actions.single_target+=/rampage,if=buff.enrage.down&buff.juggernaut.down
	{'Rampage', '!player.buff(Enrage)&!player.buff(Juggernaut)'},
	--actions.single_target+=/furious_slash,if=talent.frenzy.enabled&(buff.frenzy.down||buff.frenzy.duration<=3)
	{'Furious Slash', 'talent(6,2)&{!player.buff(Frenzy)||player.buff(Frenzy).stack<=3}'},
	--actions.single_target+=/raging_blow,if=buff.juggernaut.down&buff.enrage.up
	{'Raging Blow', '!player.buff(Juggernaut)&player.buff(Enrage)'},
	--actions.single_target+=/whirlwind,if=buff.wrecking_ball&buff.enrage.up
	{'Whirlwind', 'talent(3,1)&player.buff(Wrecking Ball)&player.buff(Enrage)'},
	--actions.single_target+=/execute,if=talent.inner_rage.enabled||!talent.inner_rage.enabled&player.rage>50
	{'Execute', 'talent(6,3)||{!talent(6,3)&player.rage>50}'},
	--actions.single_target+=/bloodthirst,if=buff.enrage.down
	{'Bloodthirst', '!player.buff(Enrage)'},
	--actions.single_target+=/raging_blow,if=buff.enrage.down
	{'Raging Blow', '!player.buff(Enrage)'},
	--actions.single_target+=/execute,if=artifact.juggernaut.enabled
	--{'Execute', ''}, --not possible now ...?, because dont have artifact traits check function
	--actions.single_target+=/raging_blow
	{'Raging Blow'},
	--actions.single_target+=/bloodthirst
	{'Bloodthirst'},
	--actions.single_target+=/furious_slash
	{'Furious Slash'},
	--actions.single_target+=/call_action_list,name=bladestorm
	{Bladestorm},
	--actions.single_target+=/bloodbath,if=buff.frothing_berserker.up||(player.rage>80&!talent.frothing_berserker.enabled)
	{'Bloodbath', 'player.buff(Frothing Berserker)||{player.rage>80&!talent(5,2)}'}
}

local TwoTargets = {
	--actions.two_targets=whirlwind,if=buff.meat_cleaver.down
	{'Whirlwind', '!player.buff(Meat Cleaver)'},
	--actions.two_targets+=/call_action_list,name=bladestorm
	{Bladestorm},
	--actions.two_targets+=/rampage,if=buff.enrage.down||(player.rage=100&buff.juggernaut.down)||buff.massacre.up
	{'Rampage', '!player.buff(Enrage)||{player.rage=100&!player.buff(Juggernaut)}||player.buff(Massacre)'},
	--actions.two_targets+=/bloodthirst,if=buff.enrage.down
	{'Bloodthirst', '!player.buff(Enrage)'},
	--actions.two_targets+=/raging_blow,if=talent.inner_rage.enabled&spell_targets.whirlwind=2
	{'Raging Blow', 'talent(6,3)&player.area(8).enemies=2'},
	--actions.two_targets+=/whirlwind,if=spell_targets.whirlwind>2
	{'Whirlwind', 'player.area(8).enemies>2'},
	--actions.two_targets+=/dragon_roar
	{'Dragon Roar'},
	--actions.two_targets+=/bloodthirst
	{'Bloodthirst'},
	--actions.two_targets+=/whirlwind
	{'Whirlwind'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
	--actions.movement=heroic_leap
	{'Heroic Leap', 'keybind(lcontrol)' , 'mouseover.ground'}
}

local Interrupts = {
	{'Pummel'},
	{'Arcane Torrent', 'target.range<=8&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)'},
}

local inCombat = {
	{UtilC},
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=8'},
	--{_Xeer},
	--{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)&target.range<8'},
	--actions+=/call_action_list,name=two_targets,if=spell_targets.whirlwind=2||spell_targets.whirlwind=3
	{TwoTargets, 'toggle(aoe)&player.area(8).enemies=2||player.area(8).enemies=3'},
	--actions+=/call_action_list,name=aoe,if=spell_targets.whirlwind>3
	{AoE, 'toggle(aoe)&player.area(8).enemies>3'},
	--actions+=/call_action_list,name=single_target
	{ST, 'target.range<8&target.infront'}
}

local outCombat = {
	{ UtilOFF },
}

NeP.CR:Add(72, '[RUB] Warrior - Prot', inCombat, outCombat, exeOnLoad)