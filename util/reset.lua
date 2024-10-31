---@type Axolotl.util.reset
Axolotl.util.reset = {}
---@class Axolotl.util.reset
local exports = Axolotl.util.reset
local _ = {}

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

    PetFrame:ClearAllPoints()
    PetFrame:SetPoint("BOTTOMRIGHT", PlayerFrame, "TOPRIGHT", -20, -30)
    PetFrameDebuff1:ClearAllPoints()
    PetFrameDebuff1:SetPoint("BOTTOMLEFT", PetFrame, "TOP", -20, -8)

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

    Axolotl.util.reset.ResetBuffDisplay()

    -- Replace tooltip anchor
    if _.defaultTooltipAnchorFn == nil then
        _.defaultTooltipAnchorFn = GameTooltip_SetDefaultAnchor
        GameTooltip_SetDefaultAnchor = exports.SetDefaultTooltipAnchor
    end
end

function exports.ResetBuffDisplay()
    --- Columns
    for i = 0, 23, 1 do
        button:ClearAllPoints()
        ---@type Button
        local button = getglobal("BuffButton" .. i)
        ---@type Button
        local previous = getglobal("BuffButton" .. (i - 1))
        if previous then
            button:SetPoint("RIGHT", previous, "LEFT", 0, 0)
        end
    end

    --- Split into rows
    BuffButton0:ClearAllPoints()
    BuffButton0:SetPoint("BOTTOMRIGHT", Axolotl.ui.MinimapParent, "BOTTOMLEFT", -20, 4)
    BuffButton8:ClearAllPoints()
    BuffButton8:SetPoint("BOTTOMLEFT", BuffButton0, "TOPLEFT", 0, 5)
    BuffButton16:ClearAllPoints()
    BuffButton16:SetPoint("BOTTOMLEFT", BuffButton8, "TOPLEFT", 0, 5)

    -- ID swapping to reverse order of buffs
    -- (UI breaks if I re-order the buttons directly)
    for i = 0, 7, 1 do
        ---@type Button
        local button_r1 = getglobal("BuffButton" .. i)
        button_r1:SetID(7 - i)
        ---@type Button
        local button_r2 = getglobal("BuffButton" .. (i + 8))
        button_r2:SetID(15 - i)
        ---@type Button
        local button_debuff = getglobal("BuffButton" .. (i + 16))
        button_debuff:SetID(7 - i)

        --- DEBUG: Display Buff 0 on all buff buttons
        -- button_r1:SetID(0)
        -- button_r2:SetID(0)
        -- button_debuff:SetID(0)
        -- button_debuff.buffFilter = "HELPFUL"
    end
end

function exports.SetDefaultTooltipAnchor(tooltip, parent)
    tooltip:SetOwner(parent, "ANCHOR_NONE");
    tooltip.default = 1;

    local x, y = GetCursorPosition();
    tooltip:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMLEFT", x + 80, y);
end
