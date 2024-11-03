---@type Axolotl.components.buffs
Axolotl.components.buffs = {}
---@class Axolotl.components.buffs
local exports = Axolotl.components.buffs
---@class Axolotl.components.buffs._
local _ = {}

function exports.Place()
    exports.PlaceBuffs()

    exports.PlaceTempEnchants()
end

function exports.PlaceBuffs()
    if not Axolotl.ui.BuffIcons then
        Axolotl.ui.BuffIcons = {}
    end
    if not Axolotl.ui.BuffDurations then
        Axolotl.ui.BuffDurations = {}
    end

    local parent = Axolotl.ui.BuffParent
    if not parent then
        parent = CreateFrame("Frame", nil, UIParent)
        Axolotl.ui.BuffParent = parent
    end

    local NUM_BUFFS_PER_ROW = 8
    local NUM_HELPFUL_BUFFS = 16
    local NUM_HARMFUL_BUFFS = 8
    local TOTAL = NUM_HELPFUL_BUFFS + NUM_HARMFUL_BUFFS

    local previous
    for i = 0, TOTAL - 1, 1 do
        local duration = Axolotl.ui.BuffDurations[i]
        if not duration then
            duration = parent:CreateFontString("Axolotl_Buff" .. i .. "Duration", nil, "BuffButtonDurationTemplate")
        end

        local template, id
        if i < NUM_HELPFUL_BUFFS then
            template = "BuffButtonHelpful"
            id = i
        else
            template = "BuffButtonHarmful"
            id = i - NUM_HELPFUL_BUFFS
        end

        local button = Axolotl.ui.BuffIcons[i]
        if not button then
            button = CreateFrame("Button", "Axolotl_Buff" .. i, parent, template)
            Axolotl.ui.BuffIcons[i] = button
        end

        button:SetID(id)
        button:ClearAllPoints()

        duration:SetPoint("BOTTOM", button, "TOP", 0, 0)

        local row = math.floor(i / NUM_BUFFS_PER_ROW)
        local column = math.mod(i, NUM_BUFFS_PER_ROW)
        local isNewRow = column == 0
        if previous and not isNewRow then
            button:SetPoint("LEFT", previous, "RIGHT", 0, 0)
        else
            button:SetPoint("LEFT", Axolotl.ui.ActionBackground1, "RIGHT", 5, 0)
        end
        button:SetPoint("BOTTOM", Axolotl.ui.ActionBar1, "BOTTOM", 0, row * 43)

        -- -- DEBUG
        -- button.buffFilter = "HELPFUL"

        previous = button
    end
end

function exports.PlaceTempEnchants()
    TempEnchant1:ClearAllPoints();
    TempEnchant1:SetPoint("BOTTOMLEFT", Axolotl.ui.ActionBackground2, "BOTTOMLEFT", -32, 15)
    TempEnchant1Duration:ClearAllPoints();
    TempEnchant1Duration:SetPoint("BOTTOM", TempEnchant1, "TOP", 0, 5)

    TempEnchant2:ClearAllPoints();
    TempEnchant2:SetPoint("BOTTOMLEFT", Axolotl.ui.ActionBackground2, "BOTTOMLEFT", -72, 15)
    TempEnchant2Duration:ClearAllPoints();
    TempEnchant2Duration:SetPoint("BOTTOM", TempEnchant2, "TOP", 0, 5)

    TempEnchant2:SetID(16)
    TempEnchant2:Show()
end
