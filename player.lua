player = gameobject:new({
    spd = 3,
    dx = 0,
    dy = 0,
    mx = 0,
    my = 0,
    w = 4,
    h = 8,
    colW = 12,
    colH = 12,

    update = function(self)
        self.mx, self.my = 0, 0

        if btn(1) then
            self.dx = 1
            self.mx = 1
        elseif btn(0) then
            self.dx = -1
            self.mx = -1
        end

        self.dy = 0
        if btn(3) then
            self.dy = 1
            self.my = 1
        elseif btn(2) then
            self.dy = -1
            self.my = -1
        end

        local len = sqrt(self.mx*self.mx+self.my*self.my)

        if len > 0 and not pdl then
            self.x += self.mx/len*self.spd
            self.y += self.my/len*self.spd
        end
    end
})
