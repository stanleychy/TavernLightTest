local clickWindow = nil
local clickButton = nil
local jumpButton = nil

local jumpButtonLocalX = 0
local jumpButtonLocalY = 0

local BUTTON_MOVE_SPEED = 10
local UPDATE_DELAY = 100
local WINDOW_SAFETY_MARGIN = 10

local shouldResetButton = false
local UpdateEventScheduled = false
local jumpButtonEvent

function init()
    clickWindow = g_ui.displayUI('click')
    clickWindow:hide()

    clickButton = modules.client_topmenu.addLeftButton('click', tr(''), '/images/topbuttons/terminal.png', toggle)

    jumpButton = clickWindow:recursiveGetChildById('jumpButton')
end

function update()

    if not clickWindow then
        return
    end

    if clickWindow:isDragging() then
        return
    end

    local windowSize = clickWindow:getSize()
    local buttonSize = jumpButton:getSize()
    local windowPosition = clickWindow:getPosition()

    jumpButtonLocalX = jumpButtonLocalX - BUTTON_MOVE_SPEED

    if jumpButtonLocalX < WINDOW_SAFETY_MARGIN or shouldResetButton then
        jumpButtonLocalX = math.random(buttonSize.width + WINDOW_SAFETY_MARGIN, windowSize.width - buttonSize.width)
        jumpButtonLocalY = math.random(buttonSize.height, windowSize.height - buttonSize.height - WINDOW_SAFETY_MARGIN)

        jumpButton:setPosition({
            x = windowPosition.x + jumpButtonLocalX,
            y = windowPosition.y + jumpButtonLocalY
        })
        shouldResetButton = false
    else
        jumpButton:setPosition({
            x = windowPosition.x + jumpButtonLocalX,
            y = windowPosition.y + jumpButtonLocalY
        })
    end
end

function onJumpButtonClick()
  shouldResetButton = true
end

function terminate()
    if jumpButtonEvent then
        removeEvent(jumpButtonEvent)
        jumpButtonEvent = nil
    end

    if jumpButton then
        jumpButton:destroy()
        jumpButton = nil
    end

    if clickButton then
        clickButton:destroy()
        clickButton = nil
    end

    if clickWindow then
        clickWindow:destroy()
        clickWindow = nil
    end
end

function toggle()
    if clickButton:isOn() then
        clickWindow:hide()
        clickButton:setOn(false)
    else
        clickWindow:show()
        clickWindow:raise()
        clickWindow:focus()
        clickButton:setOn(true)

        if not UpdateEventScheduled then
            UpdateEventScheduled = true
            jumpButtonEvent = periodicalEvent(update, nil, UPDATE_DELAY)
        end
    end
end
