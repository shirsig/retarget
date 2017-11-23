local error = true
do
	local orig = UIErrorsFrame_OnEvent
	function UIErrorsFrame_OnEvent(event, msg)
	    if error or msg ~= ERR_UNIT_NOT_FOUND then
	        return orig(event, msg)
	    end
	end
end
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
		unit, dead, retarget = target, UnitIsDead'target', false
	elseif unit then
		error = false
		TargetByName(unit, true)
		error = true
		if UnitExists'target' then
			if not (retarget or (not dead and UnitIsDead'target' and feigning())) then
				ClearTarget()
				unit, retarget = nil, false
			end
		else
			retarget = true
		end
	end
end)