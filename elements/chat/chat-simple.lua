

    local _, ns = ...

    local FONT_REGULAR = ns.FONT_REGULAR

    local AddChat = function()
        for i, v in pairs(CHAT_FRAMES) do
            local chat   = _G[v]
            local edit   = _G[v..'EditBox']
            local header = _G[v..'EditBoxHeader']
            local suffix = _G[v..'EditBoxHeaderSuffix']

            SetChatWindowAlpha(i, 0)
            local font, size = chat:GetFont()
            chat:SetFont(FONT_REGULAR, size, "OUTLINE")
            -- chat:SetFont(font, size, "OUTLINE")

        end
    end

    -- hooksecurefunc('FCF_FadeInChatFrame',             function(self) AddBG(self, _G[self:GetName()..'Background'], true)  end)
    -- hooksecurefunc('FCF_FadeOutChatFrame',            function(self) AddBG(self, _G[self:GetName()..'Background'], false) end)
    -- hooksecurefunc('FloatingChatFrame_OnMouseScroll', UpdateBottom)
    -- hooksecurefunc('ChatFrame_OnUpdate',              UpdateBottom)
    -- hooksecurefunc('FCF_OpenTemporaryWindow',         AddChat)

    local e = CreateFrame'Frame'
    e:RegisterEvent'PLAYER_ENTERING_WORLD'
    e:SetScript('OnEvent', AddChat)

    --
