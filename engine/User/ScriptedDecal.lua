---@declare-global
---@class moho.userDecal_methods
local ScriptedDecal = {}

---
function ScriptedDecal:Destroy()
end

--- Set the position based on world coords
---@param pos Vector
function ScriptedDecal:SetPosition(pos)
end

--- Set the position based on screen space mouse coords
---@param pos Vector2
function ScriptedDecal:SetPositionByScreen(pos)
end

--- Scale the text
---@param scale Vector
function ScriptedDecal:SetScale(scale)
end

--- Set the texture and add it to the decal manager
---@param tex string
function ScriptedDecal:SetTexture(tex)
end

return ScriptedDecal
