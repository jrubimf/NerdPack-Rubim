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
	{ '@Rubim.CastGroundSpell' }
}

local UtilC = {
	{ '@Rubim.Targeting' },
	{ '@Rubim.CastGroundSpell' },
	{ 'Blood Fury' , 'player.area(8).enemies >= 1 & target.exists' }
}

local Healing = {
	{ 'Death Strike' , 'player.buff(101568)&player.health <= 80' },
	{ 'Death Strike', 'player.buff(101568)&player.buff(101568).duration < 2' },
}

local Cooldowns = {
	{ 'Pillar of Frost' },
	{ 'Blood Fury' },
}

local Interrupts = {
	-- Mind freeze
	{ '47528' },
}

local Core = {
	--actions.core=frost_strike,if=buff.obliteration.up&!buff.killing_machine.react
	{ 'Frost Strike' , 'player.buff(Obliteration) & !player.buff(Killing Machine)' },
	--actions.core+=/remorseless_winter,if=(spell_targets.remorseless_winter>=2|talent.gathering_storm.enabled)&!talent.frozen_pulse.enabled
	{ 'Remorseless Winter' , '{player.area(8).enemies >= 2 || player.talent(6,3)} & !player.talent(2,2)' },
	--actions.core+=/frostscythe,if=!talent.breath_of_sindragosa.enabled&(buff.killing_machine.react|spell_targets.frostscythe>=4)
	{ 'Frostscythe' , '{player.buff(Killing Machine) || player.area(8).enemies >= 4} & player.onmelee' },
	--actions.core+=/glacial_advance
	{ 'Glacial Advance' , 'player.area(8).enemies >= 1' },
	--actions.core+=/obliterate,if=buff.killing_machine.react   
	{ 'Obliterate', 'player.buff(Killing Machine)' },
	--actions.core+=/obliterate
	{ 'Obliterate' },

	--actions.core=glacial_advance
	{ 'Glacial Advance' , 'player.area(8).enemies >= 1' },
	--actions.core+=/frost_strike,if=buff.obliteration.up&!buff.killing_machine.react
	
	--actions.core+=/remorseless_winter,if=spell_targets.remorseless_winter>=2
	{ 'Remorseless Winter' , 'player.area(8).enemies >= 2' },
--actions.core+=/frostscythe,if=!talent.breath_of_sindragosa.enabled&(buff.killing_machine.react|spell_targets.frostscythe>=4)
	--actions.core+=/obliterate,if=buff.killing_machine.react
	{ 'Obliterate' , 'player.buff(Killing Machine)', },
	--actions.core+=/obliterate
	{ 'Obliterate' },
	--actions.core+=/frostscythe,if=talent.frozen_pulse.enabled
	--actions.core+=/howling_blast,if=talent.frozen_pulse.enabled
}

local Generic = {
	--actions.generic=howling_blast,target_if=!dot.frost_fever.ticking
	{ 'Howling Blast' , 'player.buff(Rime)' },
	--actions.generic+=/howling_blast,if=buff.rime.react
	{ 'Howling Blast' , 'player.buff(Rime)' },
	--actions.generic+=/frost_strike,if=runic_power>=80
	{ 'Frost Strike' , 'player.runicpower >= 80' },
	--actions.generic+=/call_action_list,name=core
	{ Core },
--actions.generic+=/horn_of_winter,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
--actions.generic+=/horn_of_winter,if=!talent.breath_of_sindragosa.enabled
	{ 'Horn of Winter' , '!talent(7,1) & player.runes <= 2' },
--actions.generic+=/frost_strike,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
--actions.generic+=/frost_strike,if=!talent.breath_of_sindragosa.enabled
	{ 'Frost Strike' },
--actions.generic+=/empower_rune_weapon,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
--actions.generic+=/hungering_rune_weapon,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
--actions.generic+=/empower_rune_weapon,if=!talent.breath_of_sindragosa.enabled
--actions.generic+=/hungering_rune_weapon,if=!talent.breath_of_sindragosa.enabled
}

local inCombat = {
	{ UtilC },
	{ Healing , 'toggle(useDS)' },
--actions+=/arcane_torrent,if=runic_power.deficit>20
	--actions+=/blood_fury,if=!talent.breath_of_sindragosa.enabled|dot.breath_of_sindragosa.ticking
	{ 'Blood Fury' ,  '!talent(7,2) & player.area(8).enemies >= 1' },
--actions+=/berserking
--actions+=/use_item,slot=finger2
--actions+=/use_item,slot=trinket1
--actions+=/potion,name=deadly_grace
	--actions+=/pillar_of_frost
	{ 'Pillar of Frost' , 'player.area(8).enemies >= 1' },
--actions+=/sindragosas_fury
--actions+=/obliteration
	{ 'Obliteration' , 'player.area(8).enemies >= 1' },
--actions+=/breath_of_sindragosa,if=runic_power>=50
--actions+=/run_action_list,name=bos,if=dot.breath_of_sindragosa.ticking
--actions+=/call_action_list,name=generic
	{ Generic },
}

local outCombat = {
	{ UtilOFF },
}

NeP.CR:Add(251, '[RUB] Death Knight - Frost', inCombat, outCombat, exeOnLoad)