---@type Axolotl.config.style
Axolotl.config.style = {}
---@class Axolotl.config.style
local exports = Axolotl.config.style
---@class Axolotl.config.style._
local _ = {}

local HexColor = Axolotl.util.Color.HexColor

exports.Health = HexColor("#82C846")
exports.Mana = HexColor("#3A74d6")
exports.Rage = HexColor("#D63A3F")
exports.Focus = HexColor("#D67A3A")
exports.Energy = HexColor("#DEBE42")

exports.DefaultBackdrop = HexColor("#595959")
exports.DefaultBorder = HexColor("#777777")

exports.MailIndicator = HexColor("#DE79f7")

exports.RestedIndicator_MaxRested = HexColor("#E5D283")
exports.RestedIndicator_Rested = HexColor("#83C2E5")
exports.RestedIndicator_Exhausted = HexColor("#CB83E5")

exports.XPBarBorder = HexColor("#444444")
exports.XPBarEmpty = HexColor("#171717")
exports.XPBarRested = HexColor("#7777ff")
exports.RepBarEmpty = exports.XPBarEmpty
-- Taken from FACTION_BAR_COLORS
exports.ReputationColors = {}
exports.ReputationColors[0] = HexColor("#555555") -- Unknown
exports.ReputationColors[1] = HexColor("#CC4C38") -- Hated
exports.ReputationColors[2] = HexColor("#CC4C38") -- Hostile
exports.ReputationColors[3] = HexColor("#8F4400") -- Unfriendly
exports.ReputationColors[4] = HexColor("#E5B200") -- Neutral
exports.ReputationColors[5] = HexColor("#009919") -- Friendly
exports.ReputationColors[6] = HexColor("#009919") -- Honored
exports.ReputationColors[7] = HexColor("#009919") -- Revered
exports.ReputationColors[8] = HexColor("#009919") -- Exalted


exports.ActionBarBackdrop = {
    bgFile = Axolotl.Media("img:ActionBarBackground"),
    edgeFile = Axolotl.Media("img:ActionBarFrame_Edge"),
    tileEdge = true,
    edgeSize = 16,
    insets = { left = 6, right = 6, top = 6, bottom = 6 }
}

exports.ActionBarBackdrop_Top = {
    bgFile = Axolotl.Media("img:ActionBarBackground"),
    edgeFile = Axolotl.Media("img:ActionBarFrame_Edge2"),
    tileEdge = true,
    edgeSize = 16,
    insets = { left = 6, right = 6, top = 6, bottom = 6 }
}

exports.MinimapBackdrop = exports.ActionBarBackdrop
