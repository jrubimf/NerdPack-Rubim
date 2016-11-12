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

local inCombat = {
	{ UtilC },
	{'%pause', 'keybind(lshift)'},
	{Interrupts, 'target.interruptAt(50) & toggle(interrupts)'},
	{ 'Demon Spikes' , 'player.spell(Demon Spikes).charges >= 1.8 & player.area(8).enemies >= 1' },
	{'%pause', '!target.exists'},
	{ 'Soul Cleave' , 'player.health <= 90' },
	{ 'Soul Carver' },
	{ 'Soul Cleave' , 'player.energy >= 80' },
	{ 'Immolation Aura' , 'player.area(8).enemies >= 1' },
	{ '@Rubim.AutoCastGroundSIGIL' },
	{ 'Shear' },
}

local outCombat = {
	{ UtilOFF }
}

NeP.CR:Add(581, '[RUB] Demon Hunter - Havoc', inCombat, outCombat, exeOnLoad)