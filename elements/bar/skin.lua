

	local _, ns = ...

	local function IsButton(self, name)
        if self:GetName():match(name) then return true else return false end
    end

	local Zone = function(self)
		if  ZoneAbilityFrame then
			UIPARENT_MANAGED_FRAME_POSITIONS.ZoneAbilityFrame = nil
			ZoneAbilityFrame:SetScale(.7)
			ZoneAbilityFrame:ClearAllPoints()
			ns.DELEGATE_FRAMES_TO_POSITION[ZoneAbilityFrame] = {'BOTTOM', 0, 63}
		end
	end

	local pet = function(self)
		for _, name in pairs({
            'PetActionButton',
            'PossessButton',
            'StanceButton',
        }) do
            for i = 1, 12 do
                local bu = _G[name..i]
				local ic = _G[name..i..'Icon']
				local bg = _G[name..i..'FloatingBG']
				local bo = _G[name..i..'Border']
				local no = _G[name..i..'NormalTexture'] or _G[name..i..'NormalTexture2']

				if bu then
					if not bu.style then
						ns.BUElements(bu)
						--ns.BDStone(bu, 5)
						if name ~= 'StanceButton' then
							bu:SetSize(25, 25)
						else
							bu:SetSize(32, 32)
						end

						bu:GetCheckedTexture():SetTexture''

						--ic:SetTexCoord(.1, .9, .3, .7)

						local mask = bu:CreateMaskTexture()
						mask:SetTexture[[Interface\ARCHEOLOGY\Arch-Keystone-Mask]]
						mask:SetAllPoints()

						local mask2 = bu:CreateMaskTexture()
						mask2:SetTexture[[Interface\ARCHEOLOGY\Arch-Keystone-Mask]]
						mask2:SetPoint('TOPLEFT', -5, 5)
						mask2:SetPoint('BOTTOMRIGHT', 5, -5)

						ic:AddMaskTexture(mask)

						if  not bu.bg then
							bu.bg = bu:CreateTexture(nil, 'BACKGROUND', nil, -4)
							bu.bg:SetPoint('TOPLEFT', -3, 3)
							bu.bg:SetPoint('BOTTOMRIGHT', 3, -3)
							bu.bg:SetTexture[[Interface\ARCHEOLOGY\Arch-Keystone-Mask]]
							bu.bg:SetVertexColor(0, 0, 0)

							bu.bo = bu:CreateTexture(nil, 'BACKGROUND', nil, -5)
							bu.bo:SetPoint('TOPLEFT', -5, 5)
							bu.bo:SetPoint('BOTTOMRIGHT', 5, -5)
							bu.bo:SetTexture[[Interface\Stationery\StationeryTest1]]
							bu.bo:AddMaskTexture(mask2)
							bu.bo:SetVertexColor(.9, .9, .9)

							bu.stone = bu:CreateTexture(nil, 'BACKGROUND', nil, -6)
							bu.stone:SetPoint('TOPLEFT', -12, 12)
							bu.stone:SetPoint('BOTTOMRIGHT', 12, -12)
							bu.stone:SetTexture[[Interface\ARCHEOLOGY\ArchaeologyParts]]
							bu.stone:SetTexCoord(.115, .205, .5775, .765)

						end

						bu.style = true
					end

					for _, v in pairs({bg, bo, no}) do
						if v then v:SetAlpha(0) end
					end

					if  name == 'PetActionButton' then
	                    local shine = _G[name..i..'Shine']
	                    local auto  = _G[name..i..'AutoCastable']

	                    if  shine then
	                        shine:ClearAllPoints()
	                        shine:SetPoint('TOPLEFT', bu, -3, 4)
	                        shine:SetPoint('BOTTOMRIGHT', bu, 3, -4)
	                        shine:SetFrameStrata'BACKGROUND'
	                    end

	                    if  auto then
	                        auto:SetSize(44, 33)
	                        auto:SetDrawLayer('OVERLAY', 7)
	                    end
	                end
				end
			end
		end
	end

	local skin = function(self)
		local name = self:GetName()
		local bu   = _G[name]
		local bg   = _G[name..'FloatingBG']
		local bo   = _G[name..'Border']
		local fly  = _G[name..'FlyoutBorder']
		local flys = _G[name..'FlyoutBorderShadow']

		if not bu.bo then
			ns.BU(bu, .75, true)
			ns.BUElements(bu)
			ns.BUBorder(bu)
		end

		if IsEquippedAction(self.action) then
			bu.HotKey:SetParent(bu.bo)	-- draw over border
			bu.bo:SetBackdropBorderColor(0, .6, 0)
		end

		for _, v in pairs({fly, flys}) do
			if v then v:SetTexture'' end
		end
		for _, v in pairs({bg, bo}) do
			if v then v:SetAlpha(0) end
		end

		if IsButton(self, 'ExtraActionButton') or IsButton(self, 'ZoneActionBarFrameButton') then
			Zone(bu)
			if not InCombatLockdown() then bu:SetSize(30, 30) end
		end
	end

	local AddFlyoutSkin = function(self)
		local i = 1
		while _G['SpellFlyoutButton'..i] do
			local bu = _G['SpellFlyoutButton'..i]
			local ic = _G['SpellFlyoutButton'..i..'Icon']
			ns.BU(bu)
			ns.BUElements(bu)
			for _, v in pairs({
				SpellFlyoutBackgroundEnd,
				SpellFlyoutHorizontalBackground, SpellFlyoutVerticalBackground
			}) do
				v:SetTexture''
			end
			i = i + 1
		end
	end

	SpellFlyout:HookScript('OnShow', AddFlyoutSkin)

	hooksecurefunc('PetActionBar_Update',	 pet)
    hooksecurefunc('StanceBar_UpdateState',	 pet)
    securecall'PetActionBar_Update'
	hooksecurefunc('ActionButton_Update', 	skin)


	--