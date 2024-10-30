---@type Axolotl.components.xpbar
Axolotl.components.xpbar = {}
---@class Axolotl.components.xpbar
local exports = Axolotl.components.xpbar
---@class Axolotl.components.xpbar._
local _ = {}

exports.BarHeight = 16

exports.Create = function()
    local xpBar = Axolotl.ui.XPBar or CreateFrame("StatusBar", "Axolotl_XPBar", UIParent, "TextStatusBar")
    ---@cast xpBar TextStatusBar
    Axolotl.ui.XPBar = xpBar

    xpBar:ClearAllPoints()
    xpBar:SetPoint("CENTER", Axolotl.ui.ActionBar3, "BOTTOM", 0, -2 - exports.BarHeight / 2)

    xpBar:SetHeight(10)
    xpBar:SetWidth(Axolotl.ui.ActionBar3:GetWidth())
    xpBar:SetStatusBarTexture(Axolotl.Media("img:XpBar"))
    xpBar:SetBackdrop({
        bgFile = Axolotl.Media("img:XpBar_BG"),
    })
    xpBar:SetStatusBarColor(Axolotl.config.style.XPBarRested:ArgsRGB())
    xpBar:SetBackdropColor(Axolotl.config.style.XPBarEmpty:ArgsRGB())

    local border = CreateFrame("Frame", nil, xpBar);
    border:SetBackdrop({
        edgeFile = Axolotl.Media("img:ActionBarBackground"),
        edgeSize = 1
    })
    border:SetAllPoints(xpBar)
    border:SetBackdropBorderColor(Axolotl.config.style.XPBarBorder:ArgsRGB())

    -- TODO: Pet XP Bar?
    -- xpBar:RegisterEvent("UNIT_PET")
    -- xpBar:RegisterEvent("UNIT_PET_EXPERIENCE")

    xpBar:RegisterEvent("PLAYER_ENTERING_WORLD")

    xpBar:RegisterEvent("UNIT_LEVEL")
    xpBar:RegisterEvent("UPDATE_EXHAUSTION")
    xpBar:RegisterEvent("PLAYER_XP_UPDATE")
    xpBar:RegisterEvent("PLAYER_LEVEL_UP")

    xpBar:SetScript("OnEvent", _.XPBar_OnEvent)
    xpBar:SetScript("OnEnter", _.XPBar_OnEnter)
    xpBar:SetScript("OnLeave", _.XPBar_OnLeave)

    -- TODO: Reputation bar
    -- xpBar:RegisterEvent("UPDATE_FACTION")
    -- xpBar:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")

    -- Status text
    local textFrame = CreateFrame("Frame", nil, xpBar)
    Axolotl.ui.XPBarTextFrame = textFrame
    local statusText = textFrame:CreateFontString("Axolotl_XPBarText", "ARTWORK", "TextStatusBarText")
    -- statusText:SetDrawLayer("OVERLAY")
    -- statusText:SetFont(GameFontNormal:GetFont())
    statusText:SetPoint("CENTER", xpBar, "CENTER")
    Axolotl.ui.XPBarText = statusText

    xpBar.textLockable = 1

    SetTextStatusBarText(xpBar, statusText);
    SetTextStatusBarTextPrefix(xpBar, "XP");

    _.UpdateXPValues()

    return xpBar
end

_.XPBar_OnEvent = function(self)
    local self = self or this
    ---@cast self StatusBar

    _.UpdateXPValues()
end

_.UpdateXPValues = function()
    local xpBar = Axolotl.ui.XPBar
    local currentXP = UnitXP("Player")
    local maxXP = UnitXPMax("Player")

    xpBar:SetMinMaxValues(0, maxXP)
    xpBar:SetValue(currentXP)

    TextStatusBar_UpdateTextString(xpBar)
end

_.XPBar_OnEnter = function()
    ShowTextStatusBarText(Axolotl.ui.XPBar)
end

_.XPBar_OnLeave = function()
    ShowTextStatusBarText(Axolotl.ui.XPBar)
end
