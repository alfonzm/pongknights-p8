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
    x = 0,
    y = 0,
    update = function() end,
    draw = function() end,
})
