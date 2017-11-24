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
		local _PlaySound, _UIErrorsFrame_OnEvent = PlaySound, UIErrorsFrame_OnEvent
		PlaySound, UIErrorsFrame_OnEvent = retarget and PlaySound or pass, pass
		TargetByName(unit, true)
		PlaySound, UIErrorsFrame_OnEvent = _PlaySound, _UIErrorsFrame_OnEvent
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