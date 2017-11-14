local function feigning()
	local i, buff = 1, nil
	repeat
		buff = UnitBuff('target', i)
		if buff == [[Interface\Icons\Ability_Rogue_FeignDeath]] then
			return true
		end
		i = i + 1
	until not buff
	return UnitCanAttack('player', 'target')
end
local unit, retarget
CreateFrame'Frame':SetScript('OnUpdate', function()
	local target = UnitName'target'
	if target then
		unit, retarget = not UnitIsDead'target' and target, false
	elseif unit then
		TargetByName(unit, true)
		if UnitName'target' then
			if not (retarget or UnitIsDead'target' and feigning()) then
				ClearTarget()
				unit, retarget = nil, false
			end
		else
			retarget = true
		end
	end
end)