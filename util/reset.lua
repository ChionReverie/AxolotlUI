---@type Axolotl.util.reset
Axolotl.util.reset = {}
---@class Axolotl.util.reset
local exports = Axolotl.util.reset

exports.EngageReset = function()
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

    -- Group loot frames
    GroupLootFrame1:ClearAllPoints();
    GroupLootFrame1:SetPoint("Top", Axolotl.ui.InfoBar, "BOTTOM", 0, -10)
    GroupLootFrame2:ClearAllPoints();
    GroupLootFrame2:SetPoint("Top", GroupLootFrame1, "BOTTOM", 0, 0)
    GroupLootFrame3:ClearAllPoints();
    GroupLootFrame3:SetPoint("Top", GroupLootFrame2, "BOTTOM", 0, 0)
    GroupLootFrame4:ClearAllPoints();
    GroupLootFrame4:SetPoint("Top", GroupLootFrame3, "BOTTOM", 0, 0)

    -- Force-hide Multi ActionBars
    MainMenuBar:Hide()
    MultiBarBottomLeft:Hide()
    MultiBarBottomRight:Hide()
    -- MultiBarLeft:Hide()
    -- MultiBarRight:Hide()

    MultiBarRight:SetPoint('RIGHT', UIParent, "RIGHT", -8, 0)
    MultiBarRight:SetPoint('BOTTOM', Axolotl.ui.MinimapParent, "TOP", 0, 30)

    MinimapCluster:ClearAllPoints()
    MinimapCluster:SetPoint("TOP", Axolotl.ui.InfoBar, "TOP", 0, -20)
    MinimapCluster:SetPoint("RIGHT", MultiBarLeft, 'LEFT', -10)
end
