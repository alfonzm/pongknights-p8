local function overlap_aabb(ax1, ay1, ax2, ay2, bx1, by1, bx2, by2)
    return ax1 < bx2
        and ax2 > bx1
        and ay1 < by2
        and ay2 > by1
end

local class = {
    new = function(self, tbl)
        tbl = tbl or {}
        setmetatable(tbl, { __index = self })
        return tbl
    end,
}

gameobject = class:new({
    x = 0,
    y = 0,
    collider = {
        ox = 0,
        oy = 0,
        w = 8,
        h = 8,
    },

    getAabb = function(self)
        local c = self.collider
        local x1 = self.x + c.ox
        local y1 = self.y + c.oy
        return x1, y1, x1 + c.w, y1 + c.h
    end,

    intersectsRect = function(self, x1, y1, x2, y2)
        local ax1, ay1, ax2, ay2 = self:getAabb()
        return overlap_aabb(ax1, ay1, ax2, ay2, x1, y1, x2, y2)
    end,

    intersects = function(self, other)
        return self:intersectsRect(other:getAabb())
    end,

    update = function(self) end,
    draw = function(self) end,
})
