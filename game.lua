function _init()
    grav = 0
    timer = 0

    player = {
        x = 63,
        y = 63,
        spd = 3,
        dx = 0,
        dy = 0,
        mx = 0,
        my = 0,
        w = 4,
        h = 8,
        colW = 12,
        colH = 12,
    }

    pdl = false

    eBulls = {}

    bullSpd = 2

end

function _update()
    timer = timer + 1

    if timer % 20 == 0 then
        local by = flr(rnd(127))
        local dx = rnd(2) < 1 and -1 or 1
        local bx = dx == -1 and 128 or 0
        add(eBulls, {
            x=bx, y=by, dx=dx, dy=0,
            colOx=2, colOy=2, colW=4, colH=4,
        })
    end

    player.mx, player.my = 0, 0

    if btn(1) then
        player.dx = 1
        player.mx = 1
    elseif btn(0) then
        player.dx = -1
        player.mx = -1
    end

    player.dy = 0
    if btn(3) then
        player.dy = 1
        player.my = 1
    elseif btn(2) then
        player.dy = -1
        player.my = -1
    end

    local len = sqrt(player.mx*player.mx+player.my*player.my)

    if len > 0 and not pdl then
        player.x += player.mx/len*player.spd
        player.y += player.my/len*player.spd
    end

    pdl = (btn(5)) and true or false

    for b in all(eBulls) do
        b.x = b.x + (b.dx * bullSpd)
        b.y = b.y + (b.dy * bullSpd)
        if b.x < -20 or b.x > 127 + 20 or b.y < -20 or b.y > 127 + 20 then
            del(eBulls, b)
        end

        if b.bounced ~= 1 and pdl and collidingPaddle(b) then
            b.dx = b.dx * -1
            b.dy = b.dy * -1
            b.bounced = 1
        end

        if colliding(player, b) then
            -- del(eBulls, b)
        end

    end
end

function bulletAabb(b)
    local x1 = b.x + b.colOx
    local y1 = b.y + b.colOy
    return x1, y1, x1 + b.colW, y1 + b.colH
end

function colliding(a,b)
    local bx1, by1, bx2, by2 = bulletAabb(b)
    return checkAabb(
        a.x-a.colW/2,
        a.y-a.colH/2,
        a.x+a.colW,
        a.y+a.colH,
        bx1, by1, bx2, by2
    )
end

function collidingPaddle(b)
    local px, py, px2, py2 = getPaddleRect()
    local bx1, by1, bx2, by2 = bulletAabb(b)
    return checkAabb(px, py, px2+1, py2+1, bx1, by1, bx2, by2)
end

function checkAabb(ax1,ay1,ax2,ay2,bx1,by1,bx2,by2)
    return ax1 < bx2
        and ax2 > bx1
        and ay1 < by2
        and ay2 > by1
end

function getPaddleRect()
    padWidth = 1
    padHeight = 14

    padGap = 3
    padDist = 8/2 + padGap

    pCenterX = player.x + 8/2
    pCenterY = player.y + 8/2

    -- padx left or right of player
    padX = player.dx == 1 and (pCenterX + padDist) or (pCenterX - padDist - padWidth - 1)
    padX2 = padX + padWidth

    padY = pCenterY - padHeight/2
    padY2 = pCenterY + padHeight/2-1

    if player.dy ~= 0 then
        padX = pCenterX - padHeight/2
        padX2 = padX + padHeight - 1
    end

    if player.dy == -1 then
        padY = pCenterY - padDist - padWidth - 1
        padY2 = padY + padWidth
    elseif player.dy == 1 then
        padY = pCenterY + padDist
        padY2 = padY + padWidth
    end

    return padX, padY, padX2, padY2
end

function _draw()
    cls(1)

    -- player
    spr(1,player.x,player.y)

    if pdl then

        local padX, padY, padX2, padY2 = getPaddleRect()

        rectfill(padX, padY, padX2, padY2, 7)
    end

    for b in all(eBulls) do
        spr(2, b.x,b.y)
    end
end
