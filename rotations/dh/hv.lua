local _, Rubim = ...

local exeOnLoad = function()
--	NePCR.Splash()
	Rubim.meleeSpell = 203782
end

local UtilOFF = {
	{ '@Rubim.CastGroundSpell' }
}

local UtilC = {
	{ '@Rubim.CastGroundSpell' },
	{ '@Rubim.Targeting'},
	{ 'Blood Fury' , 'player.area(8).enemies >= 1 & target.exists' }
}
local Survival = {
	-- healthstone

}

local Healing = {

}

local Interrupts = {
	{'Consume Magic'},
}

local AoE = {
	{ 'Death Sweep' , 'player.area(8).enemies >= 1' },
	{ 'Eye Beam' , 'player.area(8).enemies >= 1' },
	{ 'Blade Dance' , 'player.spell.cooldown(Eye Beam) > 0 & player.area(8).enemies >= 1' },
	{ 'Throw Glaive' },
	{ 'Annihilation' , 'talent(1,2)' },
	{ 'Chaos Strike' , 'talent(1,2)' },
}

local ST = {
	{ 'Fel Eruption' },
	{ 'Death Sweep' , 'talent(3,2)' },
	{ 'Annihilation' },
	{ 'Blade Dance' , 'talent(3,2) & player.area(8).enemies >= 1' },
	{ 'Chaos Strike' },
	{ "Demon's Bite" },
}

local inCombat = {
	{ 'Vengeful Retreat' , 'lastgcd(Fel Rush)' },
	{ UtilC },
	{'%pause', 'keybind(lshift)'},
	{Interrupts, 'target.interruptAt(50) & toggle(interrupts)'},
	
	
	
	
	{ "Fury of the Illidari" , 'player.area(8).enemies >= 1' }, -- Fury of the Illidari
	{ AoE , 'player.area(8).enemies >= 2' },
	{ ST },
}

local outCombat = {
	{ UtilOFF }
}

NeP.CR:Add(577, '[RUB] Demon Hunter - Havoc', inCombat, outCombat, exeOnLoad)