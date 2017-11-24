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
local pass = function() end
CreateFrame'Frame':SetScript('OnUpdate', function()
	local target = UnitName'target'
	if target then
		unit, dead, retarget = target, UnitIsDead'target', false
	elseif unit then
		local orig = UIErrorsFrame_OnEvent
		UIErrorsFrame_OnEvent = pass
		TargetByName(unit, true)
		UIErrorsFrame_OnEvent = orig
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