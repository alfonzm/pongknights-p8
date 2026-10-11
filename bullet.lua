bullet = gameobject:new({
    dy = 0,
    colOx=2,
    colOy=2,
    colW=4,
    colH=4,

    update = function(self)
        local bullSpd = 2
        self.x = self.x + (self.dx * bullSpd)
        self.y = self.y + (self.dy * bullSpd)
        if self.x < -20 or self.x > 127 + 20 or self.y < -20 or self.y > 127 + 20 then
            del(bullets, self)
        end

        if self.bounced ~= 1 and pdl and collidingPaddle(self) then
            self.dx = self.dx * -1
            self.dy = self.dy * -1
            self.bounced = 1
        end
    end,

    draw = function(self)
        spr(2, self.x, self.y)
    end
})
