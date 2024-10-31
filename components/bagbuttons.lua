---@type Axolotl.components.bagbuttons
Axolotl.components.bagbuttons = {}
---@class Axolotl.components.bagbuttons
local exports = Axolotl.components.bagbuttons
---@class Axolotl.components.bagbuttons._
local _ = {}

function exports.RepositionContainers()
    local parent = CreateFrame("Frame", nil, UIParent)
    Axolotl.ui.BagButtonsParent = parent
    parent:SetPoint("TOP", Axolotl.ui.InfoBar, "BOTTOM")
    parent:SetPoint("BOTTOM", MultiBarRight, "TOP")
    parent:SetPoint("RIGHT", MultiBarRight, "RIGHT", 0, 0)
    parent:SetWidth(100)

    ---@type CheckButton
    local backpack = getglobal("MainMenuBarBackpackButton")
    backpack:SetParent(parent)
    backpack:ClearAllPoints()
    backpack:SetPoint("RIGHT", parent, "RIGHT")

    ---@type CheckButton
    local bag1 = getglobal("CharacterBag0Slot")
    bag1:SetParent(parent)
    bag1:ClearAllPoints()
    bag1:SetPoint("BOTTOM", backpack, "TOP")

    local bag2 = getglobal("CharacterBag1Slot")
    bag2:SetParent(parent)
    bag2:ClearAllPoints()
    bag2:SetPoint("BOTTOMRIGHT", backpack, "LEFT")

    local bag3 = getglobal("CharacterBag2Slot")
    bag3:SetParent(parent)
    bag3:ClearAllPoints()
    bag3:SetPoint("TOP", backpack, "BOTTOM")

    local bag4 = getglobal("CharacterBag3Slot")
    bag4:SetParent(parent)
    bag4:ClearAllPoints()
    bag4:SetPoint("TOPRIGHT", backpack, "LEFT")

    local keyring = getglobal("KeyRingButton")
    keyring:SetParent(parent)
    keyring:ClearAllPoints()
    keyring:SetPoint("RIGHT", bag2, "BOTTOMLEFT")
end
