---@type Axolotl.components.minimap
Axolotl.components.minimap = {}
---@class Axolotl.components.minimap
local exports = Axolotl.components.minimap
---@class Axolotl.components.minimap._
local _ = {}

exports.Create = function()
    _.HideVanillaMinimap()

    local backdrop = Axolotl.config.style.MinimapBackdrop

    local minimapParent = CreateFrame("Frame", nil, UIParent)
    Axolotl.ui.MinimapParent = minimapParent
    minimapParent:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT")
    minimapParent:SetHeight(200)
    minimapParent:SetWidth(200)
    minimapParent:SetFrameStrata("BACKGROUND")

    local backdropColor = Axolotl.config.style.DefaultBackdrop
    local borderColor = Axolotl.config.style.DefaultBorder
    minimapParent:SetBackdrop(backdrop)
    minimapParent:SetBackdropColor(backdropColor:ArgsRGB())
    minimapParent:SetBackdropBorderColor(borderColor:ArgsRGB())

    local minimap = Minimap
    minimapParent:SetWidth(minimap:GetWidth() + 20)
    minimapParent:SetHeight(minimap:GetHeight() + 20)
    minimap:SetMaskTexture(Axolotl.Media("img:MapMask"))

    Axolotl.ui.Minimap = minimap
    minimap:SetParent(minimapParent)
    minimap:ClearAllPoints()
    minimap:SetPoint("CENTER", minimapParent)

    local header = CreateFrame("Frame", nil, minimapParent)
    Axolotl.ui.MinimapHeader = header
    header:ClearAllPoints()
    header:SetPoint("BOTTOM", minimapParent, "TOP", 0, -12)
    header:SetPoint("RIGHT", minimapParent, "RIGHT", -12, 0)
    header:SetPoint("LEFT", minimapParent, "LEFT", 12, 0)
    header:SetHeight(32)

    header:SetBackdrop(backdrop)
    header:SetBackdropColor(backdropColor:ArgsRGB())
    header:SetBackdropBorderColor(borderColor:ArgsRGB())
    -- Needed to put header behind the parent
    header:SetFrameLevel(0)

    local zoneText = MinimapZoneTextButton
    zoneText:SetParent(minimapParent)
    zoneText:SetPoint("CENTER", header, "CENTER", 0, 3)

    local tracking = MiniMapTrackingFrame
    tracking:SetParent(minimapParent)
    tracking:ClearAllPoints()
    tracking:SetPoint("CENTER", header, "LEFT", -3, 3)

    local buttonZoomIn = MinimapZoomIn
    buttonZoomIn:SetParent(minimapParent)
    buttonZoomIn:ClearAllPoints()
    buttonZoomIn:SetPoint("BOTTOM", minimap, "LEFT", -15, 10)

    local buttonZoomOut = MinimapZoomOut
    buttonZoomOut:SetParent(minimapParent)
    buttonZoomOut:ClearAllPoints()
    buttonZoomOut:SetPoint("TOP", minimap, "LEFT", -15, -10)
end

_.HideVanillaMinimap = function()
    -- Can't simply hide MinimapCluster because some elements
    -- are still parented to it.
    MinimapBorderTop:Hide()
    MinimapToggleButton:Hide()
    MinimapBorder:Hide()
    GameTimeFrame:Hide()
    MiniMapMailIcon:Hide()
    MiniMapMailBorder:Hide()
end
