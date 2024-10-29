---@type Axolotl.util.reset
Axolotl.util.reset = {}
---@class Axolotl.util.reset
local exports = Axolotl.util.reset

exports.EngageReset = function()
    -- Square Minimap
    Minimap:SetMaskTexture(Axolotl.Media("img:MapMask"))
    -- Lower main unit frames
    PlayerFrame:ClearAllPoints()
    PlayerFrame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOM", -80, 200)
    -- Target Frame
    TargetFrame:ClearAllPoints()
    TargetFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOM", 80, 200)

    -- Force-hide Multi ActionBars
    MainMenuBar:Hide()
    MultiBarBottomLeft:Hide()
    MultiBarBottomRight:Hide()
    -- MultiBarLeft:Hide()
    -- MultiBarRight:Hide()
end
