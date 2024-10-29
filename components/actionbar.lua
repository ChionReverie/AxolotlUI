---@type Axolotl.components.actionbar
Axolotl.components.actionbar = {}
---@class Axolotl.components.actionbar
local exports = Axolotl.components.actionbar
---@class Axolotl.components.actionbar._
local _ = {}

exports.Create = function()
    local container = CreateFrame("Frame", "Axolotl_ActionBarContainer", UIParent)
    Axolotl.ui.ActionBarContainer = container

    container:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, -8)
    container:SetHeight(52 + 52 + 32)
    container:SetWidth(52 * 12 + 24)

    local bar1 = Axolotl.components.actionbar.CreateActionBar({
        name = "Axolotl_ActionBar1",
        prefix = "ActionButton",
        parent = container,
        buttonWidth = 52,
        numButtons = 12,
        buttonScale = 4 / 3
    })
    Axolotl.ui.ActionBar1 = bar1
    bar1:SetPoint("BOTTOM", container, "BOTTOM", 0, 16)
    bar1:SetHeight(52)

    local bar2 = Axolotl.components.actionbar.CreateActionBar({
        name = "Axolotl_ActionBar2",
        prefix = "MultiBarBottomLeftButton",
        parent = container,
        buttonWidth = 52,
        numButtons = 12,
        buttonScale = 4 / 3
    })
    Axolotl.ui.ActionBar2 = bar2
    bar2:SetPoint("BOTTOM", bar1, "TOP", 0, 4)
    bar2:SetHeight(52)

    local bar3 = Axolotl.components.actionbar.CreateActionBar({
        name = "Axolotl_ActionBar3",
        prefix = "MultiBarBottomRightButton",
        parent = container,
        buttonWidth = 40,
        numButtons = 12,
        buttonScale = nil
    })
    Axolotl.ui.ActionBar3 = bar3
    bar3:SetPoint("BOTTOM", bar2, "TOP", 0, 4 + Axolotl.components.xpbar.BarHeight)
    bar3:SetHeight(40)

    local bonusBar = Axolotl.components.actionbar.CreateActionBar({
        name = "Axolotl_ActionBarBonus",
        prefix = "BonusActionButton",
        parent = container,
        buttonWidth = 52,
        numButtons = 12,
        buttonScale = 4 / 3
    })
    Axolotl.ui.ActionBarBonus = bonusBar
    bonusBar:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
    bonusBar:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
    bonusBar:SetScript("OnEvent", _.ActionBarBonus_OnEvent)
    bonusBar:SetAllPoints(bar1)

    local shapeshiftBar = Axolotl.components.actionbar.CreateActionBar({
        name = "Axolotl_ShapeshiftBar",
        prefix = "ShapeshiftButton",
        parent = container,
        buttonWidth = 40,
        numButtons = 10,
    })
    Axolotl.ui.ShapeshiftBar = shapeshiftBar
    shapeshiftBar:SetPoint("BOTTOMLEFT", bar2, "TOPLEFT", 0, 50)
    shapeshiftBar:SetHeight(40)

    local petBar = Axolotl.components.actionbar.CreateActionBar({
        name = "Axolotl_PetBar",
        prefix = "PetActionButton",
        parent = container,
        buttonWidth = 40,
        numButtons = 10
    })
    Axolotl.ui.PetActionBar = petBar
    petBar:SetPoint("BOTTOMLEFT", bar2, "TOPLEFT", 0, 50)
    petBar:SetHeight(40)

    -- Backgrounds
    local backdropColor = { r = 0.35, g = 0.35, b = 0.35 }
    local borderColor = { r = 0.5, g = 0.5, b = 0.5 }

    local background1 = CreateFrame("Frame", nil, container)
    Axolotl.ui.ActionBackground1 = background1;
    background1:SetFrameStrata("BACKGROUND")
    background1:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, -8)
    background1:SetHeight(52 + 52 + 32)
    background1:SetWidth(52 * 12 + 24)

    background1:SetBackdrop({
        bgFile = Axolotl.Media("img:ActionBarBackground"),
        edgeFile = Axolotl.Media("img:ActionBarFrame_Edge"),
        tileEdge = true,
        edgeSize = 16,
        insets = { left = 6, right = 6, top = 6, bottom = 6 }
    })
    background1:SetBackdropColor(backdropColor.r, backdropColor.g, backdropColor.b)
    background1:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b)

    local background2 = CreateFrame("Frame", nil, container)
    Axolotl.ui.ActionBackground2 = background2;
    background2:SetFrameStrata("LOW")
    background2:SetPoint("BOTTOM", background1, "TOP", 0, -13)
    background2:SetPoint("TOP", bar3, "TOP", 0, 9)
    background2:SetPoint("LEFT", bar3, "LEFT", -9, 0)
    background2:SetPoint("RIGHT", bar3, "RIGHT", 9, 0)
    -- background2:SetHeight(71)
    -- background2:SetWidth(500)

    background2:SetBackdrop({
        bgFile = Axolotl.Media("img:ActionBarBackground"),
        edgeFile = Axolotl.Media("img:ActionBarFrame_Edge2"),
        tileEdge = true,
        edgeSize = 16,
        insets = { left = 6, right = 6, top = 6, bottom = 6 }
    })
    background2:SetBackdropColor(backdropColor.r, backdropColor.g, backdropColor.b)
    background2:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b)
end

_.old_GetPagedId = ActionButton_GetPagedID
-- Hook
ActionButton_GetPagedID = function(button)
    local parentName = button:GetParent():GetName()
    if parentName == "Axolotl_ActionBar1" then
        return (button:GetID() + ((CURRENT_ACTIONBAR_PAGE - 1) * NUM_ACTIONBAR_BUTTONS))
    elseif parentName == "Axolotl_ActionBar2" then
        return (button:GetID() + ((BOTTOMLEFT_ACTIONBAR_PAGE - 1) * NUM_ACTIONBAR_BUTTONS))
    elseif parentName == "Axolotl_ActionBar3" then
        return (button:GetID() + ((BOTTOMRIGHT_ACTIONBAR_PAGE - 1) * NUM_ACTIONBAR_BUTTONS))
    elseif parentName == "Axolotl_ActionBarBonus" then
        local offset = GetBonusBarOffset();
        if (offset == 0 and BonusActionBarFrame and BonusActionBarFrame.lastBonusBar) then
            offset = BonusActionBarFrame.lastBonusBar;
        end
        return (button:GetID() + ((NUM_ACTIONBAR_PAGES + offset - 1) * NUM_ACTIONBAR_BUTTONS));
    end

    return _.old_GetPagedId(button)
end

_.ActionBarBonus_OnEvent = function()
    if (event == "UPDATE_BONUS_ACTIONBAR" or event == "ACTIONBAR_PAGE_CHANGED") then
        if GetBonusBarOffset() > 0 and CURRENT_ACTIONBAR_PAGE == 1 then
            Axolotl.ui.ActionBar1:Hide()
            Axolotl.ui.ActionBarBonus:Show()
            -- Necessary for keybind nonsense
            BonusActionBarFrame:Show()
        else
            Axolotl.ui.ActionBar1:Show()
            Axolotl.ui.ActionBarBonus:Hide()
            -- Necessary for keybind nonsense
            BonusActionBarFrame:Hide()
        end
    end
end

---
---@param button Button
---@param factor number
exports.ScaleActionButton = function(button, factor)
    button:SetWidth(button:GetWidth() * factor)
    button:SetHeight(button:GetHeight() * factor)

    ---@type Texture
    local border = getglobal(button:GetName() .. "Border")
    border:SetWidth(border:GetWidth() * factor)
    border:SetHeight(border:GetHeight() * factor)
    ---@type Texture
    local normalTexture = getglobal(button:GetName() .. "NormalTexture")
    normalTexture:SetWidth(normalTexture:GetWidth() * factor)
    normalTexture:SetHeight(normalTexture:GetHeight() * factor)
    ---@type Model
    local cooldown = getglobal(button:GetName() .. "Cooldown")
    cooldown:SetWidth(cooldown:GetWidth() * factor)
    cooldown:SetHeight(cooldown:GetHeight() * factor)
    cooldown:SetModelScale(cooldown:GetModelScale() * factor)
end

---@param args {name: string, prefix: string, parent: Frame, buttonWidth: number, numButtons: number, buttonScale: number?}
---@return Frame
exports.CreateActionBar = function(args)
    local bar = CreateFrame("Frame", args.name, args.parent)
    bar:SetWidth(args.buttonWidth * args.numButtons)
    local nudge = 2 -- Actionbar buttons are not centered by default for some reason =/
    for i = 1, args.numButtons, 1 do
        local button = getglobal(args.prefix .. i)
        button:SetParent(bar)
        button:SetID(i)

        button:ClearAllPoints()
        local offset = args.buttonWidth * (i - 1) + nudge
        button:SetPoint("LEFT", bar, "LEFT", offset, 0)
        if args.buttonScale then
            Axolotl.components.actionbar.ScaleActionButton(button, args.buttonScale)
        end

        -- Show grid
        if button.showgrid then
            ActionButton_ShowGrid(button)
        end
    end

    return bar
end
