function _init()
    x = 63
    y = 63
    grav = 0
    spd = 3

    dir = 1

    paddle = false
end

function _update()
    paddle = false

    y = y + grav

    if btn(1) then
        x = x + spd
        dir = 1
    elseif btn(0) then
        x = x - spd
        dir = 0
    end

    if btn(5) then
        paddle = true
    end
end

function _draw()
    cls()
    spr(1,x,y)

    if paddle then
        pCenterX = x + 4
        padW = 1
        padDist = 4

        padX = dir == 1 and (pCenterX + padDist) or (pCenterX - padDist - padW - 1)
        rectfill(padX, y+1, padX+padW, y + 7, 7)
    end
end
