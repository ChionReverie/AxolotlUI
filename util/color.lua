---@class Axolotl.util.Color
---@field red number
---@field green number
---@field blue number
---@field alpha number
---@field chatColor string
local Color = {}
Color.__index = Color
Axolotl.util.Color = Color
---@class Axolotl.util.Color._
local _ = {}

function Color:new(r, g, b, a)
    local chatColor = string.format(
        "|c%02x%02x%02x%02x",
        a * 255,
        r * 255,
        g * 255,
        b * 255
    )
    ---@type Axolotl.util.Color
    local color = {
        red = r,
        green = g,
        blue = b,
        alpha = a,
        chatColor = chatColor
    }
    setmetatable(color, self)
    return color
end

function Color:ArgsRGB()
    return self.red, self.green, self.blue
end

function Color:ArgsRGBA()
    return self.red, self.green, self.blue, self.alpha
end

function Color.HexColor(hex)
    hex = string.gsub(hex, "#", "")
    hex = string.gsub(hex, "0x", "")

    local r, g, b
    local a = 1

    local len = string.len(hex)
    if len <= 4 then
        r = tonumber(string.sub(hex, 1, 1), 16) / 15
        g = tonumber(string.sub(hex, 2, 2), 16) / 15
        b = tonumber(string.sub(hex, 3, 3), 16) / 15
        if len == 4 then
            a = tonumber(string.sub(hex, 4, 4), 16) / 15
        end
    else
        r = tonumber(string.sub(hex, 1, 2), 16) / 255
        g = tonumber(string.sub(hex, 3, 4), 16) / 255
        b = tonumber(string.sub(hex, 5, 6), 16) / 255
        if len == 8 then
            a = tonumber(string.sub(hex, 7, 8), 16) / 255
        end
    end

    return Color:new(r, g, b, a)
end
