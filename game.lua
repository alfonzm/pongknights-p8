function _init()
    grav = 0

    p = {
        x = 63,
        y = 63,
        spd = 3,
        dx = 0,
        dy = 0,
        mx = 0,
        my = 0,
        w = 4,
        h = 8,
        colW = 10,
        colH = 10,
    }

    pdl = false

    eBulls = {}

    bullSpd = 2
    add(eBulls, {x=0, y=63+2, dx=1, dy = 0, w=2, h=2})
    add(eBulls, {x=127, y=0, dx=-1, dy = 1, w=2, h=2})
end

function _update()
    p.mx, p.my = 0, 0

    if btn(1) then
        p.dx = 1
        p.mx = 1
    elseif btn(0) then
        p.dx = -1
        p.mx = -1
    end

    if btn(3) then
        p.dy = 1
        p.my = 1
    elseif btn(2) then
        p.dy = -1
        p.my = -1
    end

    local len = sqrt(p.mx*p.mx+p.my*p.my)

    if len > 0 and not pdl then
        p.x += p.mx/len*p.spd
        p.y += p.my/len*p.spd
    end

    pdl = (btn(5)) and true or false

    for b in all(eBulls) do
        b.x = b.x + (b.dx * bullSpd)
        b.y = b.y + (b.dy * bullSpd)
        if b.x < -20 or b.x > 127 + 20 or b.y < -20 or b.y > 127 + 20 then
            del(eBulls, b)
        end

        if hitPlayer(p,b) and b.bounced ~= 1 then
            if pdl then
                b.dx = b.dx * -1
                b.dy = b.dy * -1
                b.bounced = 1
            end
            -- del(eBulls, b)
        end
    end
end

function hitPlayer(a,b)
    return a.x-a.colW/2 < b.x+b.w
        and a.x+a.colW > b.x
        and a.y-a.colH/2 < b.y+b.h
        and a.y+a.colH > b.y
end

function _draw()
    cls()
    spr(1,p.x,p.y)

    if pdl then
        pCenterX = p.x + p.w/2
        padW = 1
        padDist = p.w/2

        padX = p.dx == 1 and (pCenterX + padDist + 4) or (pCenterX - padDist - 2)

        pCenterY = p.y + p.h/2
        padY = p.dy + p.h/2

        rectfill(padX, p.y+p.h/2-p.h/2-1, padX+padW, p.y+p.h/2 - p.h/2 + p.h, 7)
    end

    for b in all(eBulls) do
        rectfill(b.x, b.y, b.x+2, b.y+2, 7)
    end
end
