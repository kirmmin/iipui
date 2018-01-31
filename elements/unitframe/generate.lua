

    local _, ns = ...

    local UnitSpecific = ns.UnitSpecific

	for unit, layout in next, UnitSpecific do
		oUF:RegisterStyle('iip - ' .. unit:gsub('^%l', string.upper), layout)
	end

	local spawnHelper = function(self, unit, ...)
		if  UnitSpecific[unit] then
			self:SetActiveStyle('iip - ' .. unit:gsub('^%l', string.upper))
        elseif UnitSpecific[unit:match('%D+')] then -- boss1 -> boss
            self:SetActiveStyle('iip - ' .. unit:match('%D+'):gsub('^%l', string.upper))
		end
		local object = self:Spawn(unit)
		object:SetPoint(...)
		return object
	end

	oUF:Factory(function(self)
        spawnHelper(self, 'target', 'BOTTOMLEFT', 120, 120)
		spawnHelper(self, 'player', 'BOTTOMLEFT', 120, 70)
        spawnHelper(self, 'focus', 'LEFT', UIParent, 'CENTER', 120, -10)
        spawnHelper(self, 'pet', 'TOPLEFT', oUF_iipPlayer, 'BOTTOMLEFT', -1, -8)
        spawnHelper(self, 'targettarget', 'TOPRIGHT', oUF_iipTarget, 'BOTTOMRIGHT', 0, -8)

        for _, v in pairs({'boss', 'arena'}) do
    		for i = 1, 5 do
    			spawnHelper(self, v..i, 'TOPRIGHT', -85, -10 - 60*i)
    		end
        end
	end)

    SlashCmdList['TP'] = function()
        for _,  obj in pairs(oUF.objects) do
            if  obj.unit then
                obj.oldunit = obj.unit
                obj.unit = 'player'
                obj:SetAttribute('unit', 'player')
                obj:Show()
                obj.Hide = obj.Show
            end
        end
    end
    SLASH_TP1 = '/tp'


    --