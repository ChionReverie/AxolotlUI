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
    -- Fixes issue where target frame sits in front of VanillaStoryline's conversation box.
    PlayerFrame:SetFrameStrata("BACKGROUND")
    TargetFrame:SetFrameStrata("BACKGROUND")
    if StorylineFrame then
        StorylineFrame:SetFrameStrata("HIGH")
    end

    -- Force-hide Multi ActionBars
    MainMenuBar:Hide()
    MultiBarBottomLeft:Hide()
    MultiBarBottomRight:Hide()
    -- MultiBarLeft:Hide()
    -- MultiBarRight:Hide()
end
