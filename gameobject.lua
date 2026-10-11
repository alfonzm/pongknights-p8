local class = {
    new = function(self, tbl)
        tbl = tbl or {}
        setmetatable(tbl, {
            __index = self
        })

        return tbl
    end
}

gameobject = class:new({
    x = 63,
    y = 63,
    update = function() end,
    draw = function() end,
})
