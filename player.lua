player = gameobject:new({
    x = 63,
    y = 63,
    spd = 2,
    dx = 0,
    dy = 0,

    collider = {
        ox = 0,
        oy = 0,
        w = 8,
        h = 8,
    },

    update = function(self)
        self.dx = 0
        self.dy = gravity

        if btn(1) then
            self.dx = 1
        elseif btn(0) then
            self.dx = -1
        end

        -- move up/down (topdown)
        -- if btn(3) then
        --     self.dy = 1
        --     my = 1
        -- elseif btn(2) then
        --     self.dy = -1
        --     my = -1
        -- end

        -- -- topdown movement
        -- local len = sqrt(mx * mx + my * my)
        -- if len > 0 and not pdl then
        --     self.x += mx / len * self.spd
        --     self.y += my / len * self.spd
        -- end

        local mx = self.dx * self.spd
        local my = self.dy

        moveTileX(self, mx)
        if not moveTileY(self, my) then
            self.dy = 0
        end
    end,

    draw = function(self)
        spr(3, self.x, self.y)

        if pdl then
            local padX, padY, padX2, padY2 = self:getPaddleRect()
            rectfill(padX, padY, padX2, padY2, 7)
        end
    end,

    getPaddleRect = function(self)
        local padWidth = 1
        local padHeight = 10
        local padGap = 2
        local padDist = 8 / 2 + padGap

        local pCenterX = self.x + 8 / 2
        local pCenterY = self.y + 8 / 2

        local padX = self.dx == 1 and (pCenterX + padDist) or (pCenterX - padDist - padWidth - 1)
        local padX2 = padX + padWidth

        local padY = pCenterY - padHeight / 2
        local padY2 = pCenterY + padHeight / 2 - 1

        if self.dy ~= 0 then
            padX = pCenterX - padHeight / 2
            padX2 = padX + padHeight - 1
        end

        if self.dy == -1 then
            padY = pCenterY - padDist - padWidth - 1
            padY2 = padY + padWidth
        elseif self.dy == 1 then
            padY = pCenterY + padDist
            padY2 = padY + padWidth
        end

        return padX, padY, padX2, padY2
    end,
})
