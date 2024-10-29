---@type Axolotl.components.ribbonmenu
Axolotl.components.ribbonmenu = {}
---@class Axolotl.components.ribbonmenu
local exports = Axolotl.components.ribbonmenu
---@class Axolotl.components.ribbonmenu._
local _ = {}

local spellbookTooltipTitle;
if PlayerHasSpells() then
    spellbookTooltipTitle = SPELLBOOK_ABILITIES_BUTTON;
else
    spellbookTooltipTitle = ABILITYBOOK_BUTTON;
end

---@type ButtonInfo[]
exports.ButtonDefinitions = {
    {
        icon = "img:ico\\MenuBag",
        action = OpenAllBags,
        tooltipTitle = "Backpack",
        tooltipAction = "OPENALLBAGS"
    },
    {
        icon = "special:portrait",
        action = function()
            ToggleCharacter("PaperDollFrame")
        end,
        tooltipTitle = CHARACTER_BUTTON,
        tooltipAction = "TOGGLECHARACTER0",
        tooltipDescription = NEWBIE_TOOLTIP_CHARACTER,
    },
    {
        icon = "img:ico\\MenuSpells",
        action = function()
            ToggleSpellBook(BOOKTYPE_SPELL)
        end,
        tooltipTitle = spellbookTooltipTitle,
        tooltipAction = "TOGGLESPELLBOOK",
        tooltipDescription = NEWBIE_TOOLTIP_SPELLBOOK,
    },
    {
        icon = "img:ico\\MenuTalents",
        action = ToggleTalentFrame,
        tooltipTitle = TALENTS_BUTTON,
        tooltipAction = "TOGGLETALENTS",
        tooltipDescription = NEWBIE_TOOLTIP_TALENTS,
    },
    {
        icon = "img:ico\\MenuQuests",
        action = ToggleQuestLog,
        tooltipTitle = QUESTLOG_BUTTON,
        tooltipAction = "TOGGLEQUESTLOG",
        tooltipDescription = NEWBIE_TOOLTIP_QUESTLOG,
    },
    {
        icon = "img:ico\\MenuSocial",
        action = ToggleFriendsFrame,
        tooltipTitle = SOCIAL_BUTTON,
        tooltipAction = "TOGGLESOCIAL",
        tooltipDescription = NEWBIE_TOOLTIP_SOCIAL,
    },
    {
        icon = "img:ico\\MenuMap",
        action = ToggleWorldMap,
        tooltipTitle = WORLDMAP_BUTTON,
        tooltipAction = "TOGGLEWORLDMAP",
        tooltipDescription = NEWBIE_TOOLTIP_WORLDMAP,
    },
    {
        icon = "img:ico\\MenuSettings",
        action = ToggleGameMenu,
        tooltipTitle = MAINMENU_BUTTON,
        tooltipAction = "TOGGLEGAMEMENU",
        tooltipDescription = NEWBIE_TOOLTIP_MAINMENU,
    },
    {
        icon = "img:ico\\MenuAddons",
        action = Axolotl.ToggleAddonsFrame,
        tooltipTitle = "Addon Settings",
    },
    {
        icon = "img:ico\\MenuHelp",
        action = ToggleHelpFrame,
        tooltipTitle = HELP_BUTTON,
        tooltipDescription = NEWBIE_TOOLTIP_HELP,
    }
}

---@return AxolotlButton button
exports.Create = function()
    exports.CreateRibbonToggleButton()
    exports.CreateRibbonButtons()

    return button
end

---@return AxolotlButton button
exports.CreateRibbonToggleButton = function()
    -- Button
    local button = CreateFrame("Button", nil, UIParent)
    Axolotl.ui.RibbonMenuToggleButton = button;

    ---@cast button AxolotlButton
    button:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)
    button:SetHeight(88)
    button:SetWidth(88)
    button:Show()

    local texCoords = { 0, 88 / 128, 0, 88 / 128 }

    local background = button:CreateTexture("Texture", "Overlay")
    background:SetTexture(Axolotl.Media("img:FoldingMenu_Overlay"))
    background:SetTexCoord(unpack(texCoords))
    background:SetAllPoints(button)

    -- Glow effects
    local glow1 = button:CreateTexture("Texture", "Highlight")
    glow1:SetTexture(Axolotl.Media("img:FoldingMenu_Overlay"))
    glow1:SetTexCoord(unpack(texCoords))
    glow1:SetAlpha(0.3)
    glow1:SetBlendMode("ADD")
    glow1:SetAllPoints(button)
    local glow2 = button:CreateTexture("Glow", "Highlight")
    glow2:SetTexture(Axolotl.Media("img:FoldingMenu_Glow"))
    glow2:SetTexCoord(unpack(texCoords))
    glow2:SetBlendMode("ADD")
    glow2:SetAllPoints(button)

    -- Anchor
    local tooltipAnchor = CreateFrame("Frame", nil, button)
    tooltipAnchor:SetPoint("BOTTOM", button, "RIGHT", 1, 0)
    tooltipAnchor:SetHeight(1)
    tooltipAnchor:SetWidth(1)
    tooltipAnchor:Show()

    button.tooltipAnchor = tooltipAnchor
    button.tooltipTitle = "Ribbon Menu"


    button:SetScript("OnEnter", _.RibbonToggleButton_OnEnter)
    button:SetScript("OnLeave", _.RibbonToggleButton_OnLeave)
    button:SetScript("OnClick", exports.ToggleRibbonMenu)

    return button
end

_.RibbonToggleButton_OnEnter = function()
    local button = this
    Axolotl.util.tooltip.ShowTooltip(button)
end
_.RibbonToggleButton_OnLeave = function()
    GameTooltip:Hide()
end

exports.CreateRibbonButtons = function()
    -- Create ribbon
    local parent = Axolotl.ui.RibbonMenuToggleButton
    local ribbon = CreateFrame("Frame", nil, parent)
    Axolotl.ui.Ribbon = ribbon
    ribbon:SetFrameStrata("BACKGROUND")
    ribbon:SetPoint("TOPLEFT", parent, "TOPRIGHT", -4, -27)
    local width = 3 + 36 * getn(exports.ButtonDefinitions)
    ribbon:SetWidth(width)
    ribbon:SetHeight(32)
    ribbon:SetBackdrop({
        bgFile = Axolotl.Media("img:Ribbon"),
        tile = true,
        tileSize = 32,
    });
    ribbon:Hide()
    -- Ribbon Tip
    local ribbonTip = CreateFrame("Button", nil, ribbon)
    ---@cast ribbonTip Button
    ribbonTip:SetPoint("LEFT", ribbon, "RIGHT")
    ribbonTip:SetWidth(32)
    ribbonTip:SetHeight(32)
    local tipTexture = ribbonTip:CreateTexture("Texture", "BACKGROUND")
    tipTexture:SetTexture(Axolotl.Media("img:RibbonEnd"))
    tipTexture:SetTexCoord(0, 1, 11 / 64, 54 / 64)
    tipTexture:SetAllPoints(ribbonTip)
    ribbonTip:SetNormalTexture(tipTexture)
    ribbonTip:SetScript("OnClick", exports.ToggleRibbonMenu)

    -- Create buttons
    for index, info in ipairs(exports.ButtonDefinitions) do
        local button = _.CreateSingleRibbonButton(info)
        local offset = (index - 1) * 36 + 6;
        button:SetPoint("LEFT", ribbon, "LEFT", offset, 0)
        button:SetParent(ribbon)
    end
end

---Create a single menu button.
---@param button_info ButtonInfo
_.CreateSingleRibbonButton = function(button_info)
    local img_border = Axolotl.Media("img:MenuItem_Border");
    local img_glow = Axolotl.Media("img:MenuItem_Glow");
    -- Button
    local button = CreateFrame("Button", nil, UIParent)
    ---@cast button AxolotlButton
    button:SetWidth(34)
    button:SetHeight(42)
    button:Show()
    button:SetScript("OnClick", button_info.action);

    local texCoords = { 0, 34 / 64, 0, 42 / 64 };
    -- Icon
    local background = button:CreateTexture("Texture", "Border")
    background:SetTexture(img_border)
    background:SetTexCoord(unpack(texCoords))
    background:SetAllPoints(button)

    local icon
    icon = button:CreateTexture("Texture", "Background")
    if button_info.icon == "special:portrait" then
        SetPortraitTexture(icon, "player")
        button.portrait = icon
        button:RegisterEvent("UNIT_PORTRAIT_UPDATE")
    else
        local img_icon = Axolotl.Media(button_info.icon)
        icon:SetTexture(img_icon)
        icon:SetTexCoord(unpack(texCoords))
    end
    icon:SetAllPoints(button)

    -- Glow effects
    local glow1 = button:CreateTexture("Texture", "Highlight")
    glow1:SetTexture(img_border)
    glow1:SetTexCoord(unpack(texCoords))
    glow1:SetAlpha(0.3)
    glow1:SetBlendMode("ADD")
    glow1:SetAllPoints(button)
    local glow2 = button:CreateTexture("Glow", "Highlight")
    glow2:SetTexture(img_glow)
    glow2:SetTexCoord(unpack(texCoords))
    glow2:SetBlendMode("ADD")
    glow2:SetAllPoints(button)


    local tooltipAnchor = CreateFrame("Frame", nil, button)
    tooltipAnchor:SetPoint("BOTTOM", button, "BOTTOMLEFT", -1, -1)
    tooltipAnchor:SetHeight(1)
    tooltipAnchor:SetWidth(1)
    tooltipAnchor:Show()

    -- Tooltips
    button.tooltipAnchor = tooltipAnchor
    button.tooltipTitle = button_info.tooltipTitle
    button.tooltipDescription = button_info.tooltipDescription
    button.tooltipAction = button_info.tooltipAction

    -- Events
    button:SetScript("OnEnter", _.RibbonButton_OnEnter)
    button:SetScript("OnLeave", _.RibbonButton_OnLeave)
    button:SetScript("OnEvent", _.RibbonButton_OnEvent)

    return button
end

_.RibbonButton_OnEvent = function()
    local button = this
    ---@cast button AxolotlButton
    if (event == "UNIT_PORTRAIT_UPDATE") and (arg1 == "player") then
        SetPortraitTexture(button.portrait, arg1);
        return;
    end
end

_.RibbonButton_OnEnter = function()
    local button = this
    ---@cast button AxolotlButton
    Axolotl.util.tooltip.ShowTooltip(button)
end

_.RibbonButton_OnLeave = function()
    Axolotl.util.tooltip:HideTooltip()
end

exports.ToggleRibbonMenu = function()
    local ribbon = Axolotl.ui.Ribbon
    if ribbon:IsShown() then
        ribbon:Hide()
        PlaySound("igQuestListOpen")
    else
        ribbon:Show()
        PlaySound("igQuestListClose")
    end
end
