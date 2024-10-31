---@type Axolotl.components.unitframes
Axolotl.components.unitframes = {}
---@class Axolotl.components.unitframes
local exports = Axolotl.components.unitframes
---@class Axolotl.components.unitframes._
local _ = {}

function exports.Place()
    local party1 = PartyMemberFrame1
    party1:ClearAllPoints()
    party1:SetPoint("BOTTOMRIGHT", MultiBarLeft, "BOTTOMLEFT", -80, 50)
    local party2 = PartyMemberFrame2
    party2:ClearAllPoints()
    party2:SetPoint("BOTTOMLEFT", party1, "TOPLEFT", 0, 15)
    local party3 = PartyMemberFrame3
    party3:ClearAllPoints()
    party3:SetPoint("BOTTOMLEFT", party2, "TOPLEFT", 0, 15)
    local party4 = PartyMemberFrame4
    party4:ClearAllPoints()
    party4:SetPoint("BOTTOMLEFT", party3, "TOPLEFT", 0, 15)
end

function exports.Debug_ShowPartyFrames()
    for i = 1, MAX_PARTY_MEMBERS, 1 do
        getglobal("PartyMemberFrame" .. i):Show();
        getglobal("PartyMemberFrame" .. i .. "PetFrame"):Show();
    end
end
