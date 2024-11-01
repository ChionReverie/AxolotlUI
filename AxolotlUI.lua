---@class Axolotl
--Main namespace for the Axolotl UI Addon
Axolotl = {}
---@class Axolotl.components
--Namespace for custom components
Axolotl.components = {}
---@class Axolotl.util
--Namespace for Utility functions
Axolotl.util = {}
---@class Axolotl.ui
--Main container namespace for UI elements.
--Elements in here are inserted from other files.
Axolotl.ui = {}
---@class Axolotl.config
Axolotl.config = {}

Axolotl.Path = "Interface\\Addons\\AxolotlUI"

-- Preload
Axolotl.Frame = CreateFrame("Frame", nil, UIParent)
Axolotl.Frame:RegisterEvent("ADDON_LOADED")
Axolotl.Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
Axolotl.Frame:SetScript("OnEvent", function()
    if event == "PLAYER_ENTERING_WORLD" then
        Axolotl.util.reset.EngageReset()
        return
    end

    if event == "ADDON_LOADED" and not Axolotl.Loaded and arg1 == "AxolotlUI" then
        Axolotl:Start()
        Axolotl.Loaded = true
        return
    end
end)


-- Functions below
Axolotl.Media = function(key)
    local result = tostring(key)
    if strfind(result, "img:") then
        result = string.gsub(result, "img:", Axolotl.Path .. "\\img\\")
    elseif strfind(result, "font:") then
        result = string.gsub(result, "font:", Axolotl.Path .. "\\fonts\\")
    end
    return result
end

Axolotl.Start = function()
    Axolotl.components.infobar.Place()
    Axolotl.components.ribbonmenu.Place()
    Axolotl.components.actionbar.Place()
    Axolotl.components.xpbar.Place()
    Axolotl.components.minimap.Place()
    Axolotl.components.bagbuttons.Place()
    Axolotl.components.unitframes.Place()
    Axolotl.components.buffs.Place()
end

Axolotl.ToggleAddonsFrame = function()
    message("Not yet implemented")
end
