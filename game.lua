function _init()
    gravity = 1
    timer = 0

    pdl = false

    entities = {}

    add(entities, player)
end

function _update60()
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

function collidingPaddle(b)
    local px, py, px2, py2 = player:getPaddleRect()
    return b:intersectsRect(px, py, px2 + 1, py2 + 1)
end

-- px, py are pixel coordinates
function isSolid(px, py)
    return fget(mget(px \ 8, py \ 8), 0)
end

-- dx, dy = how many pixels the aabb would move
function isCollidingTile(obj, dx, dy)
    local x1, y1, x2, y2 = obj:getAabb()
    x1 += dx
    y1 += dy
    x2 += dx
    y2 += dy
    return isSolid(x1, y1)
        or isSolid(x2 - 1, y1)
        or isSolid(x1, y2 - 1)
        or isSolid(x2 - 1, y2 - 1)
end

function _draw()
    cls(0)

    map(0,0)

    for e in all(entities) do
        e:draw()
    end
end
