---@type Axolotl.components.castbar
Axolotl.components.castbar = {}
---@class Axolotl.components.castbar
local exports = Axolotl.components.castbar
---@class Axolotl.components.castbar._
local _ = {}

function exports.Place()
    ---@type StatusBar
    local bar = CastingBarFrame
    bar:SetWidth(140)
    UIPARENT_MANAGED_FRAME_POSITIONS["CastingBarFrame"] = { baseY = 250 };


    ---@type Texture
    local border = CastingBarBorder
    border:SetPoint("TOP", bar, "TOP", 0, 28)
    border:SetPoint("BOTTOM", bar, "BOTTOM", 0, -22)
    border:SetPoint("LEFT", bar, "LEFT", -26, 0)
    border:SetPoint("RIGHT", bar, "RIGHT", 26, 0)

    ---@type Texture
    local flash = CastingBarFlash
    flash:SetAllPoints(border)

    bar:SetScript("OnUpdate", exports.CastBar_OnUpdate)
end

function exports.CastBar_OnUpdate()
    CastingBarFrame_OnUpdate()

    ---@type Texture
    local spark = CastingBarSpark
    ---@type StatusBar
    local bar = CastingBarFrame
    if not this.casting and not this.channeling then
        return
    end

    -- Recalculate spark position
    local min, max = bar:GetMinMaxValues()
    local value = bar:GetValue()
    local progress = (value - min) / (max - min)

    spark:ClearAllPoints()
    spark:SetPoint("CENTER", bar, "LEFT", progress * bar:GetWidth(), 2)
end
