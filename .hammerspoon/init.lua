-- F17 + HJKL을 방향키로 매핑
local function keyStroke(modifiers, key)
    hs.eventtap.keyStroke(modifiers, key, 0)
end

-- F17 + HJKL 매핑 설정
local f17Handler = nil

hs.hotkey.bind({}, 'F17', function()
    f17Handler = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
        local char = event:getCharacters()
        
        if char == 'h' then
            keyStroke({}, 'left')
            return true
        elseif char == 'j' then
            keyStroke({}, 'down')
            return true
        elseif char == 'k' then
            keyStroke({}, 'up')
            return true
        elseif char == 'l' then
            keyStroke({}, 'right')
            return true
        end
        return false
    end)
    
    f17Handler:start()
end, function()
    if f17Handler then
        f17Handler:stop()
        f17Handler = nil
    end
end)

-- Cmd + Alt + R로 Hammerspoon 설정 리로드
hs.hotkey.bind({"cmd", "alt"}, "r", function()
    hs.reload()
    hs.alert.show("Hammerspoon 설정이 리로드되었습니다!")
end)
