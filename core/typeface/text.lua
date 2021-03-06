

	local _, ns = ...

	local FONT_REGULAR 	   	= 'Interface\\AddOns\\iipui\\customise\\type\\NotoSans-Regular.ttf'
	local FONT_BOLD		   	= 'Interface\\AddOns\\iipui\\customise\\type\\NotoSans-Bold.ttf'

	ns.FONT_REGULAR     	= FONT_REGULAR
	ns.FONT_BOLD        	= FONT_BOLD

	local strings = {
		['warnings'] = {
							RaidWarningFrameSlot1,
							RaidWarningFrameSlot2,
							RaidBossEmoteFrameSlot1,
							RaidBossEmoteFrameSlot2
						},
		['zone']	 = {
							ZoneTextString,
							SubZoneTextString,
							PVPInfoTextString,
							PVPArenaTextString
						},
		['map']		 = {
							WorldMapFrameAreaLabel,
							WorldMapFrameAreaDescription,
							WorldMapFrameAreaPetLevels
						},
		['toast']	 = {
							BNToastFrameTopLine,
							BNToastFrameMiddleLine,
							BNToastFrameBottomLine,
							BNToastFrameDoubleLine
						},
		['tooltip']	 = {
							GameTooltipTextLeft1
						},
	}

	local iterate = function(v, callback)
		local i, j = next(v, nil)
		while i do
			callback(j)
			i, j = next(v, i)
		end
	end

	for n, v in pairs(strings) do
		if n == 'zone' or n == 'warnings' then
			iterate(v, function(t)
				t:SetFont([[Fonts\skurri.ttf]], 14)
				t:SetShadowOffset(1, -1.25)
				t:SetShadowColor(0, 0, 0, 1)
			end)
		elseif n == 'map' then
			iterate(v, function(t)
				t:SetFont(FONT_BOLD, 30)
				t:SetShadowOffset(1, -1.25)
				t:SetShadowColor(0, 0, 0, 1)
			end)
		elseif n == 'toast' then
			iterate(v, function(t)
				if t == BNToastFrameTopLine then t:SetJustifyH'CENTER' end
				t:SetFont(t == BNToastFrameTopLine and FONT_BOLD or FONT_REGULAR,
						  t == BNToastFrameTopLine and 13 or 10)
				t:SetShadowOffset(1, -1.25)
				t:SetShadowColor(0, 0, 0, 1)
			end)
		elseif n == 'tooltip' then
			iterate(v, function(t)
				t:SetFont([[Fonts\skurri.ttf]], 13)
				t:SetShadowOffset(1, -1.25)
				t:SetShadowColor(0, 0, 0, 1)
			end)
		elseif n == 'common' then
			iterate(v, function(t)
				t:SetFont(FONT_REGULAR, 13)
			end)
		end
	end

	-- font objects
	local t = CreateFont'iipMenuFont'
	t:SetFont(STANDARD_TEXT_FONT, 12)

	local t = CreateFont'iipNameFont'
	t:SetFont([[Fonts\skurri.ttf]], 14)
	t:SetShadowOffset(1, -1)
	t:SetShadowColor(0, 0, 0)

	local t = CreateFont'iipNameFontSmall'
	t:SetFont([[Fonts\skurri.ttf]], 10)
	t:SetShadowOffset(1, -1)
	t:SetShadowColor(0, 0, 0)

	local t = CreateFont'iipAuraFont'
	t:SetFont([[Fonts\skurri.ttf]], 14, 'THICKOUTLINE')
	t:SetShadowOffset(0, 0)


	--
