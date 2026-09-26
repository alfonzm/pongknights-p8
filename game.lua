function _init()
    grav = 0

    p = {
        x = 63,
        y = 63,
        spd = 3,
        dir = 1,
        w = 8,
        h = 8,
    }

    pdl = false

    eBulls = {}

    bullSpd = 2
    add(eBulls, {x=0, y=63+2, dir=1, w=2, h=2})
    add(eBulls, {x=127, y=63+2, dir=-1, w=2, h=2})
end

function _update()
    -- p.y = p.y + grav

    if btn(1) then
        p.dir = 1
        p.x = not pdl and p.x + p.spd or p.x
    elseif btn(0) then
        p.dir = 0
        p.x = not pdl and p.x - p.spd or p.x
    end

    pdl = false

    if btn(5) then
        pdl = true
    end

    for b in all(eBulls) do
        b.x = b.x + (b.dir * bullSpd)
        if b.x < -5 or b.x > 127 + 5 then
            del(eBulls, b)
        end

        if col(p,b) then
            del(eBulls, b)
        end
    end
end

function col(a,b)
    return a.x < b.x+b.w
        and a.x+a.w > b.x
        and a.y < b.y+b.h
        and a.y+a.h > b.y
end

function _draw()
    cls()
    spr(1,p.x,p.y)

    if pdl then
        pCenterX = p.x + 4
        padW = 1
        padDist = 4

        padX = p.dir == 1 and (pCenterX + padDist) or (pCenterX - padDist - padW - 1)
        rectfill(padX, p.y+1, padX+padW, p.y + 7, 7)
    end

    for b in all(eBulls) do
        rectfill(b.x, b.y, b.x+2, b.y+2, 7)
    end
end
