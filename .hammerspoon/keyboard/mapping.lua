-- F17 + HJKL을 방향키로 매핑
local function keyStroke(modifiers, key)
    hs.eventtap.keyStroke(modifiers, key, 0)
end

-- F17 + HJKL 매핑 설정
local f17Handler = nil
local keyMap = {
    h = 'left',
    j = 'down',
    k = 'up',
    l = 'right'
}

hs.hotkey.bind({}, 'F17', function()
    f17Handler = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
        local char = event:getCharacters()
        local mappedKey = keyMap[char]
        
        if mappedKey then
            keyStroke({}, mappedKey)
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

-- ESC 키를 눌렀을 때 무조건 영문으로 전환
local escapeHandler = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local keyCode = event:getKeyCode()
    local flags = event:getFlags()
    
    -- ESC 키이고 다른 modifier가 없을 때
    if keyCode == 0x35 and not next(flags) then
        -- 영문으로 전환
        for input, _ in pairs(ENGLISH_INPUTS) do
            hs.keycodes.currentSourceID(input)
            break
        end
    end
    return false  -- 이벤트를 계속 전달
end)

escapeHandler:start()