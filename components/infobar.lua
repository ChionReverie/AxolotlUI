---@type Axolotl.components.infobar
Axolotl.components.infobar = {}
---@class Axolotl.components.infobar
local exports = Axolotl.components.infobar
---@class Axolotl.components.infobar._
local _ = {}

exports.Create = function()
    local mainFrame = CreateFrame("Frame", "Axolotl_InfoBar", UIParent)
    Axolotl.ui.InfoBar = mainFrame

    mainFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT")
    mainFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT")
    mainFrame:SetHeight(20)

    local background = mainFrame:CreateTexture("Texture", "BACKGROUND")
    background:SetTexture(Axolotl.Media("img:InfoBar"))
    background:SetAllPoints(mainFrame)

    -- Width: 192
    local money = CreateFrame("Frame", "Axolotl_InfoBar_MoneyBar", mainFrame, "MoneyFrameTemplate")
    money:SetPoint("LEFT", mainFrame, "CENTER", 40, 0)
    Axolotl.ui.InfoBar_MoneyBar = money;

    ---@type FontString
    local clockText = mainFrame:CreateFontString("Axolotl_InfoBar_Time")
    clockText:SetFont(GameFontNormal:GetFont())
    clockText:SetText(_.CurrentTimeString())
    clockText:SetPoint("CENTER", mainFrame, "CENTER", 0, 0)
    Axolotl.ui.InfoBar_Clock = clockText
    ---@type FontString
    local fpsText = mainFrame:CreateFontString("Axolotl_InfoBar_Framerate")
    fpsText:SetFont(GameFontNormal:GetFont())
    fpsText:SetText("")
    fpsText:SetPoint("CENTER", mainFrame, "CENTER", -70, 0)
    Axolotl.ui.InfoBar_Framerate = fpsText
    ---@type FontString
    local netText = mainFrame:CreateFontString("Axolotl_InfoBar_Ping")
    netText:SetFont(GameFontNormal:GetFont())
    netText:SetText("")
    netText:SetPoint("CENTER", mainFrame, "CENTER", -150, 0)
    Axolotl.ui.InfoBar_Ping = netText
    ---@type FontString
    local restedText = mainFrame:CreateFontString("Axolotl_InfoBar_Rested")
    restedText:SetFont(GameFontNormal:GetFont())
    restedText:SetText("")
    restedText:SetPoint("LEFT", mainFrame, "CENTER", 200, 0)
    Axolotl.ui.InfoBar_Rested = restedText

    mainFrame:SetScript("OnUpdate", _.MainFrame_OnUpdate)
    mainFrame:SetScript("OnEvent", _.MainFrame_OnEvent)

    mainFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
    mainFrame:RegisterEvent("PLAYER_XP_UPDATE");
    mainFrame:RegisterEvent("UPDATE_EXHAUSTION");
    mainFrame:RegisterEvent("PLAYER_LEVEL_UP");
    mainFrame:RegisterEvent("PLAYER_UPDATE_RESTING");

    return mainFrame
end

_.MainFrame_OnUpdate = function()
    Axolotl.ui.InfoBar_Clock:SetText(_.CurrentTimeString())

    local now = time(); -- Epoch in seconds
    if _.LastFPSTime == nil or now ~= _.LastFPSTime then
        Axolotl.components.infobar.UpdateFPSText()
        Axolotl.components.infobar.UpdateLatencyText()
        _.LastFPSTime = now
    end
end

_.MainFrame_OnEvent = function()
    Axolotl.components.infobar.UpdateRestedText()
end

_.CurrentTimeString = function()
    local FORMAT_PM = "%d:%02dpm"
    local FORMAT_AM = "%d:%02dam"
    local FORMAT_24 = "%02d:%02d"
    local hour, minute = GetGameTime()
    -- TODO: Ingame config for clock type
    -- (Currently based on OS clock settings)
    if TwentyFourHourTime then
        return format(FORMAT_24, hour, minute)
    end

    local pm = false
    if hour >= 12 then
        pm = true
    end
    if hour > 12 then
        hour = hour - 12
    end
    if hour == 0 then
        hour = 12
    end

    if pm then
        return format(FORMAT_PM, hour, minute)
    else
        return format(FORMAT_AM, hour, minute)
    end
end

exports.UpdateFPSText = function()
    local fps = GetFramerate()
    local text = format("FPS: %.1f", fps)
    Axolotl.ui.InfoBar_Framerate:SetText(text)
end

exports.UpdateLatencyText = function()
    local _down, _up, latency = GetNetStats();
    local text = format("Ping: %d", latency)
    Axolotl.ui.InfoBar_Ping:SetText(text)
end

exports.UpdateRestedText = function()
    Axolotl.ui.InfoBar_Rested:SetText(_.CurrentRestedString())
end

---@return string
_.CurrentRestedString = function()
    local xp_current = UnitXP("player")
    local xp_max = UnitXPMax("player")
    local rested = GetXPExhaustion()

    local color_rested = "|cff83c2e5"
    local color_exhausted = "|cffcb83e5"
    local color_maxrested = "|cffe5d283"

    if not rested or rested == -1 then
        return color_exhausted .. "Not Rested"
    end

    local bubbles = math.floor((20 * rested / xp_max))
    local text
    if bubbles == 30 then
        text = color_maxrested .. "Fully Rested "
    else
        text = color_rested .. "Rested: " .. bubbles .. "/30 bubbles "
    end
    if rested + xp_current >= xp_max then
        local remainder = rested + xp_current - xp_max
        text = text .. "(1L+" .. remainder .. "xp)"
    else
        text = text .. "(" .. rested .. "xp)"
    end

    return text
end
