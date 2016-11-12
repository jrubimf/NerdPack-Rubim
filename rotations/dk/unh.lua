local _, Rubim = ...

local exeOnLoad = function()
	Rubim.meleeSpell = 49998
	NeP.Interface:AddToggle({
		key = 'useDS',
		icon = 'Interface\\Icons\\spell_deathknight_butcher2.png',
		name = 'USE Death Strike',
		text = 'BOT will use DS.'
	})
end

local UtilOFF = {
	{ '46584' , '!pet.exists' },
}

local UtilC = {
	{ '46584' , '!pet.exists' },
	{'Blood Fury' , 'player.area(8).enemies >= 1' },
}

local Healing = {
	{ 'Death Strike' , 'player.buff(101568) & player.health <= 80' },
	{ 'Death Strike', 'player.buff(101568) & player.buff(101568).duration < 2' },
}

local AoE = {
--actions.aoe=death_and_decay,if=spell_targets.death_and_decay>=2
--actions.aoe+=/epidemic,if=spell_targets.epidemic>4
	{'Epidemic', 'player.area(8).enemies > 4'},
--actions.aoe+=/scourge_strike,if=spell_targets.scourge_strike>=2&(dot.death_and_decay.ticking|dot.defile.ticking)
  	{'Scourge Strike', 'player.buff(Death and Decay) & player.area(8).enemies >= 2' },
--actions.aoe+=/clawing_shadows,if=spell_targets.clawing_shadows>=2&(dot.death_and_decay.ticking|dot.defile.ticking)
	{'Clawing Shadows', 'player.buff(Death and Decay) & player.area(8).enemies >= 2' },
--actions.aoe+=/epidemic,if=spell_targets.epidemic>2
	{'Epidemic', 'player.area(8).enemies > 2'},
}

local Valkyr = {
--actions.valkyr=death_coil
	{ 'Death Coil' },
--actions.valkyr+=/apocalypse,if=debuff.festering_wound.stack=8
	{ 'Apocalypse' , 'target.debuff(Festering Wound).count = 8' },
--actions.valkyr+=/festering_strike,if=debuff.festering_wound.stack<8&cooldown.apocalypse.remains<5
	{ 'Festering Strike' , 'target.debuff(Festering Wound).count < 8 & player.spell(Apocalypse).cooldown < 5' },
--actions.valkyr+=/call_action_list,name=aoe,if=active_enemies>=2
	{ AoE , 'player.area(8).enemies >= 2 & toggle(AoE)' },
--actions.valkyr+=/festering_strike,if=debuff.festering_wound.stack<=3
	{'Festering Strike', 'target.debuff(Festering Wound).count <= 3'},
--actions.valkyr+=/scourge_strike,if=debuff.festering_wound.up
	{'Scourge Strike', 'target.debuff(Festering Wound)'},
--actions.valkyr+=/clawing_shadows,if=debuff.festering_wound.up
	{'Clawing Shadows', 'target.debuff(Festering Wound).count >= 1' },
}

local Standard = {
--actions.standard=festering_strike,if=debuff.festering_wound.stack<=4&runic_power.deficit>23
	{'Festering Strike' , 'target.debuff(Festering Wound).count <= 4 & player.rpdeficiet > 23'},
--actions.standard+=/death_coil,if=!buff.necrosis.up&talent.necrosis.enabled&rune<=3
	{'Death Coil' , '!player.buff(Necrosis) & talent(6, 2) & player.runes <= 3'},
--actions.standard+=/scourge_strike,if=buff.necrosis.react&debuff.festering_wound.stack>=1&runic_power.deficit>15
	{'Scourge Strike' , 'player.buff(Necrosis) & target.debuff(Festering Wound).count >= 1 & player.rpdeficiet > 15'},
--actions.standard+=/clawing_shadows,if=buff.necrosis.react&debuff.festering_wound.stack>=1&runic_power.deficit>15
	{'Clawing Shadows' , 'player.buff(Necrosis) & target.debuff(Festering Wound).count >= 1 & player.rpdeficiet > 15'},
--actions.standard+=/scourge_strike,if=buff.unholy_strength.react&debuff.festering_wound.stack>=1&runic_power.deficit>15
	{'Scourge Strike' , 'player.buff(Unholy Strength) & target.debuff(Festering Wound).count >= 1 & player.rpdeficiet > 15'},
--actions.standard+=/clawing_shadows,if=buff.unholy_strength.react&debuff.festering_wound.stack>=1&runic_power.deficit>15
	{'Clawing Shadows' , 'player.buff(Unholy Strength) & target.debuff(Festering Wound).count >= 1 & player.rpdeficiet > 15'},
--actions.standard+=/scourge_strike,if=rune>=2&debuff.festering_wound.stack>=1&runic_power.deficit>15
	{'Scourge Strike' , 'player.runes >= 2 & target.debuff(Festering Wound).count >= 1 & player.rpdeficiet > 15'},
--actions.standard+=/clawing_shadows,if=rune>=2&debuff.festering_wound.stack>=1&runic_power.deficit>15
	{'Clawing Shadows' , 'player.runes >= 2 & target.debuff(Festering Wound).count >= 1 & player.rpdeficiet > 15'},
--actions.standard+=/death_coil,if=talent.shadow_infusion.enabled&talent.dark_arbiter.enabled&!buff.dark_transformation.up&cooldown.dark_arbiter.remains>15
	{'Death Coil' , 'talent(6, 1) & talent(7, 1) & pet.buff(Dark Transformation) & player.spell(Dark Arbiter).cooldown > 15' },
--actions.standard+=/death_coil,if=talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled&!buff.dark_transformation.up
	{'Death Coil' , 'talent(6, 1) & !talent(7, 1) & !pet.buff(Dark Transformation)' },
--actions.standard+=/death_coil,if=talent.dark_arbiter.enabled&cooldown.dark_arbiter.remains>15
	{'Death Coil' , 'talent(7, 1) & player.spell(Dark Arbiter).cooldown > 15' },
--actions.standard+=/death_coil,if=!talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled
	{'Death Coil' , '!talent(6, 1) & !talent(7, 1)', },
}

local Instructors = {
--actions.instructors=festering_strike,if=debuff.festering_wound.stack<=4&runic_power.deficit>23
	{'Festering Strike' , 'target.debuff(Festering Wound).count <= 4 & player.rpdeficiet > 23'},
--actions.instructors+=/death_coil,if=!buff.necrosis.up&talent.necrosis.enabled&rune<=3
	{'Death Coil' , '!player.buff(Necrosis) & talent(6, 2) & player.runes <= 3'},
--actions.instructors+=/scourge_strike,if=buff.necrosis.react&debuff.festering_wound.stack>=5&runic_power.deficit>29
	{'Scourge Strike' , 'player.buff(Necrosis) & target.debuff(Festering Wound).count >= 5 & player.rpdeficiet > 29'},
--actions.instructors+=/clawing_shadows,if=buff.necrosis.react&debuff.festering_wound.stack>=5&runic_power.deficit>29
	{'Clawing Shadows' , 'player.buff(Necrosis) & target.debuff(Festering Wound).count >= 5 & player.rpdeficiet > 29'},
--actions.instructors+=/scourge_strike,if=buff.unholy_strength.react&debuff.festering_wound.stack>=5&runic_power.deficit>29
	{'Scourge Strike' , 'player.buff(Unholy Strength) & target.debuff(Festering Wound).count >= 5 & player.rpdeficiet > 29'},
--actions.instructors+=/clawing_shadows,if=buff.unholy_strength.react&debuff.festering_wound.stack>=5&runic_power.deficit>29
	{'Clawing Shadows' , 'player.buff(Unholy Strength) & target.debuff(Festering Wound).count >= 5 & player.rpdeficiet > 29'},
--actions.instructors+=/scourge_strike,if=rune>=2&debuff.festering_wound.stack>=5&runic_power.deficit>29
	{'Scourge Strike' , 'player.runes >= 2 & target.debuff(Festering Wound).count >= 5 & player.rpdeficiet > 29'},
--actions.instructors+=/clawing_shadows,if=rune>=2&debuff.festering_wound.stack>=5&runic_power.deficit>29
	{'Clawing Shadows' , 'player.runes >= 2 & target.debuff(Festering Wound).count >= 5 & player.rpdeficiet > 29'},
--actions.instructors+=/death_coil,if=talent.shadow_infusion.enabled&talent.dark_arbiter.enabled&!buff.dark_transformation.up&cooldown.dark_arbiter.remains>15
	{'Death Coil' , 'talent(6, 1) & talent(7, 1) & !pet.Buff(Dark Transformation) & player.spell(Dark Arbiter).cooldown > 15' },
--actions.instructors+=/death_coil,if=talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled&!buff.dark_transformation.up
	{'Death Coil' , 'talent(6, 1) & !talent(7, 1) & !pet.Buff(Dark Transformation)'},
--actions.instructors+=/death_coil,if=talent.dark_arbiter.enabled&cooldown.dark_arbiter.remains>15
	{'Death Coil' , 'talent(7, 1) & player.spell(Dark Arbiter).cooldown > 15' },
--actions.instructors+=/death_coil,if=!talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled
	{'Death Coil' , '!talent(6, 1) & !talent(7, 1)'},
}

local Castigator = {
--actions.castigator=festering_strike,if=debuff.festering_wound.stack<=4&runic_power.deficit>23
	{'Festering Strike', 'target.debuff(Festering Wound).count <= 4 & player.rpdeficiet > 23'},
--actions.castigator+=/death_coil,if=!buff.necrosis.up&talent.necrosis.enabled&rune<=3
	{'Death Coil' , '!player.buff(Necrosis) & talent(6, 2) & player.runes <= 3'},
--actions.castigator+=/scourge_strike,if=buff.necrosis.react&debuff.festering_wound.stack>=3&runic_power.deficit>23
	{'Scourge Strike' , 'player.buff(Necrosis) & target.debuff(Festering Wound).count >= 3 & player.rpdeficiet > 23'},
--actions.castigator+=/scourge_strike,if=buff.unholy_strength.react&debuff.festering_wound.stack>=3&runic_power.deficit>23
	{'Scourge Strike' , 'player.buff(Unholy Strength) & target.debuff(Festering Wound).count >= 3 & player.rpdeficiet > 23'},
--actions.castigator+=/scourge_strike,if=rune>=2&debuff.festering_wound.stack>=3&runic_power.deficit>23
	{'Scourge Strike' , 'player.runes >= 2 & target.debuff(Festering Wound).count >= 5 & player.rpdeficiet > 29'},
--actions.castigator+=/death_coil,if=talent.shadow_infusion.enabled&talent.dark_arbiter.enabled&!buff.dark_transformation.up&cooldown.dark_arbiter.remains>15
	{'Death Coil' , 'talent(6, 1) & talent(7, 1) & !pet.Buff(Dark Transformation) & player.spell(Dark Arbiter).cooldown > 15' },
--actions.castigator+=/death_coil,if=talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled&!buff.dark_transformation.up
	{'Death Coil' , 'talent(6, 1) & !talent(7, 1) & !pet.Buff(Dark Transformation)'},
--actions.castigator+=/death_coil,if=talent.dark_arbiter.enabled&cooldown.dark_arbiter.remains>15
	{'Death Coil' , 'talent(7, 1) & player.spell(Dark Arbiter).cooldown > 15' },
--actions.castigator+=/death_coil,if=!talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled
	{'Death Coil' , '!talent(6, 1) & !talent(7, 1)'},
}

local Generic = {
--actions.generic=dark_arbiter,if=!equipped.137075&runic_power.deficit<30
	{ 'Dark Arbiter' , '!player.equipped(137075) & player.rpdeficiet < 30 & toggle(cooldowns)'},
--actions.generic+=/dark_arbiter,if=equipped.137075&runic_power.deficit<30&cooldown.dark_transformation.remains<2
	{ 'Dark Arbiter' , 'player.equipped(137075) & player.rpdeficiet < 30 & player.spell(Dark Transformation).cooldown < 2 & toggle(cooldowns)'},
--actions.generic+=/summon_gargoyle,if=!equipped.137075,if=rune<=3
	{'Summon Gargoyle' , '!player.equipped(137075) & player.runes <= 3 & toggle(cooldowns)'},
--actions.generic+=/summon_gargoyle,if=equipped.137075&cooldown.dark_transformation.remains<10&rune<=3
	{'Summon Gargoyle' , 'player.equipped(137075) & player.spell(Dark Transformation).cooldown < 10 & player.runes <= 3 & toggle(cooldowns)'},
--actions.generic+=/soul_reaper,if=debuff.festering_wound.stack>=7&cooldown.apocalypse.remains<2
	{'130736' , 'target.debuff(Festering Wound).count >= 7 & player.spell(Apocalypse).cooldown < 2'},
--actions.generic+=/apocalypse,if=debuff.festering_wound.stack>=7
	{'Apocalypse', 'target.debuff(Festering Wound).count >= 7' },
--actions.generic+=/death_coil,if=runic_power.deficit<30
	{ 'Death Coil' , 'player.rpdeficiet < 30' },
--actions.generic+=/death_coil,if=!talent.dark_arbiter.enabled&buff.sudden_doom.up&!buff.necrosis.up&rune<=3
	{'Death Coil' , '!talent(7, 1) & player.buff(Sudden Doom) & !player.buff(Necrosis) & player.runes <= 3'},
--actions.generic+=/death_coil,if=talent.dark_arbiter.enabled&buff.sudden_doom.up&cooldown.dark_arbiter.remains>5&rune<=3
	{'Death Coil' , 'player.talent (7, 1) & player.buff(Sudden Doom) & player.spell(Dark Arbiter).cooldown > 5 & player.runes <= 3'},
--actions.generic+=/festering_strike,if=debuff.festering_wound.stack<7&cooldown.apocalypse.remains<5
	{'Festering Strike' , 'target.debuff(Festering Wound).count < 7 & player.spell(Apocalypse).cooldown < 5'},
--actions.generic+=/wait,sec=cooldown.apocalypse.remains,if=cooldown.apocalypse.remains<=1&cooldown.apocalypse.remains
--	TESTING WITHOUT THIS
--actions.generic+=/soul_reaper,if=debuff.festering_wound.stack>=3
	{'130736', 'target.debuff(Festering Wound).count >= 3'},
--actions.generic+=/festering_strike,if=debuff.soul_reaper.up&!debuff.festering_wound.up
	{'Festering Strike' , '!target.debuff(Festering Wound) & !target.debuff(Soul Reaper)'},
--actions.generic+=/scourge_strike,if=debuff.soul_reaper.up&debuff.festering_wound.stack>=1
	{'Scourge Strike' , 'target.debuff(Festering Wound).count >= 1 & target.debuff(Soul Reaper)'},
--actions.generic+=/clawing_shadows,if=debuff.soul_reaper.up&debuff.festering_wound.stack>=1 *-The SimC rotation never uses clawing shadows
	{'Clawing Shadows' , 'target.debuff(Festering Wound).count >= 1 & target.debuff(Soul Reaper)'},
--actions.generic+=/defile
	{'Defile'},
--actions.generic+=/call_action_list,name=aoe,if=active_enemies>=2
	{ AoE , 'player.area(8).enemies >= 2 & toggle(aoe)'},
--actions.generic+=/call_action_list,name=instructors,if=equipped.132448 *-Need the equipped function
	{ Instructors , 'player.equipped(132448)'},
--actions.generic+=/call_action_list,name=standard,if=!talent.castigator.enabled&!equipped.132448
	{ Standard , '!talent(3, 2) & !player.equipped(132448)' },
--actions.generic+=/call_action_list,name=castigator,if=talent.castigator.enabled&!equipped.132448
	{ Castigator , 'talent(3, 2) & !player.equipped(132448)' },
}


--DEFAULT
local inCombat = {
	{ UtilC , 'autocastfunction' },
	{ UtilC },
	{ Healing , 'toggle(useDS)' },
	{ 'Outbreak', '!target.debuff(Virulent Plague)' },
	{ 'Dark Transformation' , 'player.runes <= 3' },
	{ Valkyr , 'player.spell(Dark Arbiter).cooldown > 165' },
	{ Generic }
}

local outCombat = {
	{ UtilOFF , 'autocastfunction' },
}

NeP.CR:Add(252, '[RUB] Death Knight - Unholy', inCombat, outCombat, exeOnLoad)