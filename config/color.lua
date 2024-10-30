---@type Axolotl.config.color
Axolotl.config.color = {}
---@class Axolotl.config.color
local exports = Axolotl.config.color
---@class Axolotl.config.color._
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
