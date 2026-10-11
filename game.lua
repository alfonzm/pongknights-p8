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

function collidingPaddle(b)
    local px, py, px2, py2 = player:getPaddleRect()
    return b:intersectsRect(px, py, px2 + 1, py2 + 1)
end

function _draw()
    cls(1)

    for e in all(entities) do
        e:draw()
    end
end
