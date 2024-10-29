---@type Axolotl.util.tooltip
Axolotl.util.tooltip = {}
---@class Axolotl.util.tooltip
local exports = Axolotl.util.tooltip


-- TODO: This might be better placed somewhere else. Tooltip utilities module?
exports.TooltipTitle = function(text, action)
    if action and GetBindingKey(action) then
        return text .. " " .. NORMAL_FONT_COLOR_CODE .. "(" .. GetBindingKey(action) .. ")" .. FONT_COLOR_CODE_CLOSE;
    else
        return text
    end
end

---Show a tooltip for a given button
---@param button AxolotlButton
function exports.ShowTooltip(button)
    GameTooltip:SetOwner(button.tooltipAnchor, "ANCHOR_BOTTOMRIGHT")
    GameTooltip:SetText(exports.TooltipTitle(button.tooltipTitle, button.tooltipAction), 1, 1, 1);
    if (button.tooltipDescription) then
        GameTooltip:AddLine(button.tooltipDescription, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b,
            true);
    end
    GameTooltip:Show()
end

function exports.HideTooltip()
    GameTooltip:Hide()
end
