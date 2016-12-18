--/dump NeP.DSL:Get['resourcedeficit']('player')
--/dump NeP.DSL:Get('talent')(_,'3,2')
--/dump NeP.DSL:Get['rprint']('Hi')
--/dump NeP.DSL:Get('area.enemies')('player',8)
--/dump NeP.DSL:Get('areattd')('player')
--/dump NeP.DSL:Get('area')('player')
--/dump NeP.DSL:Get('lastmoved')('player')
--/dump NeP.DSL:Get('allstacked')('player')
--/dump NeP.DSL:Get('blood.rotation')('player')
--incdmg
--/dump NeP.DSL:Get('incdmg')('player')
--/dump NeP.DSL:Get('onmelee')('player')
----actions+=/hamstring,if=buff.battle_cry_deadly_calm.remains>cooldown.hamstring.remains
--/dump NeP.DSL:Get('groundself')
--/dump NeP.DSL:Get('gcddelay')('player')
--/dump NeP.DSL:Get('tanking')('player')
--/dump NeP.DSL:Get('lastcombo')('player','Blackout Kick')
--/dump NeP.DSL:Get('lastcombo')('player','Blackout Kick')
--/dump NeP.DSL:Get('threat')('target')
--/dump NeP.DSL:Get('id')('target')
--LASTGCD
NeP.DSL:Register("lastcombo", function(Unit, Spell)
	if NeP.Library:Fetch('Rubim').MonkCombo() == Spell then return false else return true end
end)

--TANKING
NeP.DSL:Register('tanking', function(target)
	if UnitThreatSituation("player") == nil then return false
	elseif UnitThreatSituation("player") >= 2 then return true end
end)

--GCD DELAY
NeP.DSL:Register('gcddelay', function(target)
	if firstTime == nil then
		ctime = GetTime()
		firstTime = true
	end
	
	if GetTime() - ctime >= 0.25 then
		firstTime = nil
		return true
	else
		return false
	end
end)

---DEMON HUNTER
NeP.DSL:Register('bladedance', function(target)
	if NeP.DSL:Get('talent')(_,'3,2') == true
	or (NeP.DSL:Get('area.enemies')('player',8) >= 2 and NeP.DSL:Get('talent')(_,'1,2') == false)
	or (NeP.DSL:Get('area.enemies')('player',8) >= 3 and NeP.DSL:Get('talent')(_,'1,2') == true)
	then return true else return false end	
end)

NeP.DSL:Register('groundself', function()
	local spell = "Death and Decay"
	if NeP.DSL:Get('allstacked')('player') == true
	and NeP.DSL:Get('spell.cooldown')("player", spell) == 0
	and NeP.DSL:Get('lastmoved')('player') ~= false
	and UnitExists("target") == true
	and NeP.DSL:Get("distance")('target') <= tonumber(8)
	then
		RunMacroText("/cast [@player] " .. spell)
	end
	return false
end)

NeP.DSL:Register('groundselfsigil', function()
	local spell = "Sigil of Flame"
	if NeP.DSL:Get('allstacked')('player') == true
	and NeP.DSL:Get('spell.cooldown')("player", spell) == 0
	and NeP.DSL:Get('lastmoved')('player') ~= false
	and UnitExists("target") == true
	and NeP.DSL:Get("distance")('target') <= tonumber(8)
	then
		RunMacroText("/cast [@player] " .. spell)
	end
	return false
end)

NeP.DSL:Register('customfunction', function()
	NeP.Library:Fetch('Rubim').Targeting()
	NeP.Library:Fetch('Rubim').CastGroundSpell()
	return false
end)

NeP.DSL:Register('rotation', function(rotation)
	if rotation == NeP.Library:Fetch('Rubim').BloodMaster() then return true end
	return false
end)

NeP.DSL:Register('onmelee', function()
	local isitokay = NeP.Library:Fetch('Rubim').meleeRange()
	return isitokay
end)

NeP.DSL:Register('blood.rotation', function(target, rotation)
	if rotation == NeP.Library:Fetch('Rubim').BloodMaster() then return true end
	return false
end)

NeP.DSL:Register('resource.deficit', function(target)
	return (UnitPowerMax(target)) - (UnitPower(target))
end)

NeP.DSL:Register('energydeficit', function(target)
	return (UnitPowerMax(target, SPELL_POWER_ENERGY)) - (UnitPower(target, SPELL_POWER_ENERGY))
end)

NeP.DSL:Register('combodeficit', function(target)
	return (UnitPowerMax(target, SPELL_POWER_COMBO_POINTS)) - (UnitPower(target, SPELL_POWER_COMBO_POINTS))
end)

NeP.DSL:Register('rpdeficiet', function(target)
	return (UnitPowerMax(target, SPELL_POWER_RUNIC_POWER)) - (UnitPower(target, SPELL_POWER_RUNIC_POWER))
end)

--/dump NeP.DSL:Get('rage.deficit')()
NeP.DSL:Register('rage.deficit', function()
	return (UnitPowerMax('player')) - (UnitPower('player'))
end)

NeP.DSL:Register('rprint', function(text)
	print(text)
end)

NeP.DSL:Register("areattd", function(target)
	local ttd = 0
	local total = 0
	for _, Obj in pairs(NeP.OM:Get('Enemy')) do
		if NeP.DSL:Get("distance")(Obj.key) ~= nil and NeP.DSL:Get('combat')(Obj.key) and NeP.DSL:Get("distance")(Obj.key) <= tonumber(8) then
			if NeP.DSL:Get("deathin")(Obj.key) < 8 then
				total = total+1
				ttd = NeP.DSL:Get("deathin")(Obj.key) + ttd
			end
		end
	end
	if ttd > 0 then
		return ttd/total
	else
		return 9999999999
	end
end)

NeP.DSL:Register("allstacked", function(target)
	local arethey = false
	local allenemies = 0
	local closeenemies = 0
	local total = 0
	for _, Obj in pairs(NeP.OM:Get('Enemy')) do
		if NeP.DSL:Get('combat')(Obj.key) and NeP.DSL:Get("distance")(Obj.key) <= tonumber(30) then
			allenemies = allenemies +1
		end
		
		if NeP.DSL:Get('combat')(Obj.key) and NeP.DSL:Get("distance")(Obj.key) <= tonumber(8) then
			closeenemies = closeenemies+1
		end
	end
	if allenemies > 0 and allenemies == closeenemies then arethey = true end
	return arethey
end)