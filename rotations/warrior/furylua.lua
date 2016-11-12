--Outside rotation test
local function enemiesRange(range)
	print(range)
	if range == nil then return false end
	return NeP.DSL.Conditions['rarea.enemies']("player", range)
end

local CastSpell = NeP.Engine.Cast_Queue

NeP.Engine.registerRotation(72, 'Warrior - Fury out of lua', 
	{(function()
		NeP.Engine.Cast("Dragon Roar", "player")
		
	end)}, 
    {(function()
		NeP.Engine.Cast("Dragon Roar", "player")
	end)}, lib)