-- 윈도우 전환을 위한 변수들
local windowSwitcher = {
    active = false,
    currentWindows = {},
    currentIndex = 0
}

-- 현재 포커스된 앱의 모든 윈도우를 가져오는 함수
local function getCurrentAppWindows()
    local focused = hs.window.focusedWindow()
    if not focused then return {} end
    
    local app = focused:application()
    if not app then return {} end
    
    return hs.fnutils.filter(app:allWindows(), function(win)
        return win:isStandard()
    end)
end

-- 윈도우 전환 시작
local function startWindowSwitch()
    windowSwitcher.currentWindows = getCurrentAppWindows()
    if #windowSwitcher.currentWindows == 0 then return end
    
    windowSwitcher.active = true
    windowSwitcher.currentIndex = 1
    windowSwitcher.currentWindows[1]:focus()
end

-- 다음 윈도우로 전환
local function switchToNextWindow()
    if not windowSwitcher.active then
        startWindowSwitch()
        return
    end
    
    local windows = windowSwitcher.currentWindows
    if #windows <= 1 then return end
    
    windowSwitcher.currentIndex = windowSwitcher.currentIndex % #windows + 1
    windows[windowSwitcher.currentIndex]:focus()
end

-- cmd 키가 떼졌을 때 처리
local function stopWindowSwitch()
    windowSwitcher.active = false
    windowSwitcher.currentWindows = {}
    windowSwitcher.currentIndex = 0
end

-- cmd + tab 이벤트 처리
local cmdTabHandler = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local flags = event:getFlags()
    local keyCode = event:getKeyCode()
    
    -- cmd + tab 조합 확인
    if flags.cmd and keyCode == 0x30 then  -- 0x30은 tab의 키코드
        switchToNextWindow()
        return true  -- 기본 cmd + tab 동작 방지
    end
    return false
end)

-- cmd 키 떼짐 감지
local cmdUpHandler = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
    local flags = event:getFlags()
    if not flags.cmd and windowSwitcher.active then
        stopWindowSwitch()
    end
    return false
end)

cmdTabHandler:start()
cmdUpHandler:start() 