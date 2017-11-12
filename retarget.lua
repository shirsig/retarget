local hunter, rogue, vanished
CreateFrame'Frame':SetScript('OnUpdate', function()
	local target = UnitName'target'
	if target then
		local _, class = UnitClass'target'
		if UnitIsEnemy('player', 'target') then
			hunter, rogue = class == 'HUNTER' and target, class == 'ROGUE' and target
		else
			hunter, rogue = nil, nil
		end
	elseif hunter then
		TargetByName(hunter)
		if not UnitIsDead'target' or not UnitCanAttack('player', 'target') then
			ClearTarget()
			hunter = nil
		end
	elseif rogue then
		TargetByName(rogue)
		if UnitExists'target' then
			if not vanished then
				ClearTarget()
				rogue = nil
			end
		else
			vanished = true
		end
	end
end)