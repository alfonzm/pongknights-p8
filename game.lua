function _init()
    grav = 0
    timer = 0

    pdl = false

    entities = {}

    add(entities, player)
end

function _update()
    timer = timer + 1

    if timer % 20 == 0 then
        local by = flr(rnd(127))
        local dx = rnd(2) < 1 and -1 or 1
        local bx = dx == -1 and 128 or 0
        add(entities, bullet:new({
            x = bx,
            y = by,
            dx = dx,
        }))
    end

    pdl = (btn(5)) and true or false

    for e in all(entities) do
        e:update()
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
    padHeight = 10

    padGap = 2
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

    for e in all(entities) do
        e:draw()
    end
end
