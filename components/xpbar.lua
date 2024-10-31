---@type Axolotl.components.xpbar
Axolotl.components.xpbar = {}
---@class Axolotl.components.xpbar
local exports = Axolotl.components.xpbar
---@class Axolotl.components.xpbar._
local _ = {}

exports.BarHeight = 16

exports.Create = function()
    exports.CreateXPBar()
    exports.CreateRepBar()

    exports.UpdateXPValues()
    exports.UpdateRepValues()
    exports.UpdateBarPositions()
end

function exports.UpdateBarPositions()
    local xpBar = Axolotl.ui.XPBar
    local xpText = Axolotl.ui.XPBarText
    local repBar = Axolotl.ui.RepBar
    local repText = Axolotl.ui.RepBarText

    local name = GetWatchedFactionInfo()
    local repVisible = (name ~= nil)
    local xpVisible = (UnitLevel("player") < MAX_PLAYER_LEVEL)


    if repVisible and xpVisible then
        xpBar:SetPoint("TOP", Axolotl.ui.ActionBar2, "TOP", 0, 11)
        xpBar:SetHeight(7)
        xpBar:Show()
        repBar:SetPoint("TOP", Axolotl.ui.ActionBar2, "TOP", 0, 17)
        repBar:SetHeight(7)
        repBar:Show()

        xpText:ClearAllPoints()
        xpText:SetPoint("CENTER", xpBar, "BOTTOM")
        repText:ClearAllPoints()
        repText:SetPoint("CENTER", repBar, "TOP")
        return
    end

    if xpVisible then
        repBar:Hide()
        xpBar:Show()
        xpBar:SetPoint("TOP", Axolotl.ui.ActionBar2, "TOP", 0, 15)
        xpBar:SetHeight(10)
        xpText:ClearAllPoints()
        xpText:SetPoint("CENTER", xpBar, "CENTER")
        return
    end

    if repVisible then
        xpBar:Hide()
        repBar:Show()
        repBar:SetPoint("TOP", Axolotl.ui.ActionBar2, "TOP", 0, 15)
        repBar:SetHeight(10)
        repText:ClearAllPoints()
        repText:SetPoint("CENTER", repBar, "CENTER")
        return
    end

    xpBar:Hide()
    repBar:Hide()
end

exports.CreateXPBar = function()
    local xpBar = Axolotl.ui.XPBar or CreateFrame("StatusBar", "Axolotl_XPBar", UIParent, "TextStatusBar")
    ---@cast xpBar TextStatusBar
    Axolotl.ui.XPBar = xpBar

    xpBar:ClearAllPoints()
    xpBar:SetPoint("LEFT", Axolotl.ui.ActionBar3, "LEFT")
    xpBar:SetPoint("RIGHT", Axolotl.ui.ActionBar3, "RIGHT")

    xpBar:SetHeight(7)
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

    -- Status text
    local textFrame = CreateFrame("Frame", nil, xpBar)
    Axolotl.ui.XPBarTextFrame = textFrame
    local statusText = textFrame:CreateFontString("Axolotl_XPBarText", "ARTWORK", "TextStatusBarText")
    statusText:SetPoint("CENTER", xpBar, "CENTER")
    Axolotl.ui.XPBarText = statusText

    xpBar.textLockable = 1

    SetTextStatusBarText(xpBar, statusText);
    SetTextStatusBarTextPrefix(xpBar, "XP");
end

_.XPBar_OnEvent = function(self)
    local self = self or this
    ---@cast self StatusBar

    exports.UpdateXPValues()
end

exports.UpdateXPValues = function()
    exports.UpdateBarPositions()

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
    HideTextStatusBarText(Axolotl.ui.XPBar)
end

function exports.CreateRepBar()
    local repBar = Axolotl.ui.RepBar or CreateFrame("StatusBar", "Axolotl_RepBar", UIParent, "TextStatusBar")
    ---@cast repBar TextStatusBar
    Axolotl.ui.RepBar = repBar

    repBar:ClearAllPoints()
    repBar:SetPoint("LEFT", Axolotl.ui.ActionBar3, "LEFT")
    repBar:SetPoint("RIGHT", Axolotl.ui.ActionBar3, "RIGHT")
    repBar:SetHeight(7)

    repBar:SetStatusBarTexture(Axolotl.Media("img:XpBar"))
    repBar:SetBackdrop({
        bgFile = Axolotl.Media("img:XpBar_BG"),
    })
    repBar:SetStatusBarColor(Axolotl.config.style.ReputationColors[0]:ArgsRGB())
    repBar:SetBackdropColor(Axolotl.config.style.RepBarEmpty:ArgsRGB())

    local border = CreateFrame("Frame", nil, repBar);
    border:SetBackdrop({
        edgeFile = Axolotl.Media("img:ActionBarBackground"),
        edgeSize = 1
    })
    border:SetAllPoints(repBar)
    border:SetBackdropBorderColor(Axolotl.config.style.XPBarBorder:ArgsRGB())

    repBar:RegisterEvent("PLAYER_ENTERING_WORLD")
    repBar:RegisterEvent("UPDATE_FACTION")
    repBar:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")

    repBar:SetScript("OnEvent", _.RepBar_OnEvent)
    repBar:SetScript("OnEnter", _.RepBar_OnEnter)
    repBar:SetScript("OnLeave", _.RepBar_OnLeave)

    -- Status text
    local textFrame = CreateFrame("Frame", nil, repBar)
    Axolotl.ui.RepBarTextFrame = textFrame
    local statusText = textFrame:CreateFontString("Axolotl_RepBarText", "ARTWORK", "TextStatusBarText")
    statusText:SetPoint("CENTER", repBar, "CENTER")
    Axolotl.ui.RepBarText = statusText

    repBar.textLockable = 1

    SetTextStatusBarText(repBar, statusText);
    SetTextStatusBarTextPrefix(repBar, "Reputation");
end

function _.RepBar_OnEvent()
    exports.UpdateRepValues()
end

function _.RepBar_OnEnter()
    ShowTextStatusBarText(Axolotl.ui.RepBar)
end

function _.RepBar_OnLeave()
    HideTextStatusBarText(Axolotl.ui.RepBar)
end

function exports.UpdateRepValues()
    local name, standing, nmin, max, value = GetWatchedFactionInfo()
    local repBar = Axolotl.ui.RepBar

    exports.UpdateBarPositions()

    if not name then
        return
    end

    -- normalize
    max = max - nmin
    value = value - nmin
    nmin = 0

    SetTextStatusBarTextPrefix(repBar, name)
    repBar:SetMinMaxValues(nmin, max)
    repBar:SetValue(value)
    local color = Axolotl.config.style.ReputationColors[standing]
    repBar:SetStatusBarColor(color:ArgsRGB())
end
