-- 입력기
ENGLISH_INPUTS = {
    ["com.apple.keylayout.ABC"] = true
}

KOREAN_INPUTS = {
    ["com.apple.inputmethod.Korean.2SetKorean"] = true
}

-- 키보드 매핑 모듈
require("keyboard.mapping")

-- 윈도우 전환 모듈 불러오기
require("keyboard.window_switch")

-- Cmd + Alt + R로 Hammerspoon 설정 리로드
hs.hotkey.bind({"cmd", "alt"}, "r", function()
    hs.reload()
    hs.alert.show("Hammerspoon 설정이 리로드되었습니다!")
end)
