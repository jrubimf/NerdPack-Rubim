local _, Rubim = ...

local exeOnLoad = function()
	Rubim.meleeSpell = 53595
end

local Interrupts = {
	-- Mind freeze
--	{ '47528' },
}

local inCombat = {
}

local outCombat = {
}

NeP.CR:Add(66, '[RUB] Paladin - Protection', inCombat, outCombat, ExeOnLoad, GUI)