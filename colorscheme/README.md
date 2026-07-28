# colorscheme

색 테마는 두 개 — `coolnight`(기본)과 `github-dark`(GitHub Dark Default).
전환은 `theme` 스크립트 하나로 한다.

    theme              # 현재 상태 출력
    theme coolnight
    theme github-dark

## 원칙: 테마와 배경은 격리

`theme`는 팔레트(색)만 바꾼다. 배경 이미지·투명도·폰트는 건드리지 않는다 — 그건 각
터미널 설정에서 사용자가 직접 관리한다. 두 테마 모두 투명 배경을 전제로 한다.

## 팔레트 (단일 소스)

`palette.toml`이 두 테마의 canonical 팔레트다 — 이름→hex 정의, 백업 겸 권위 소스.
각 도구는 이 값에 손으로 맞춘다(코드 생성 없음 — 의도적으로 단순). 드리프트 점검:

    colorscheme/bin/palette-check                # 현재 테마
    colorscheme/bin/palette-check github-dark

ghostty·wezterm은 완전한 ANSI-16(bright 포함)을 담으므로 palette-check 대상에서 제외한다
— palette.toml은 시맨틱 색(bg/fg/accent 등)을 정의하고, ANSI 원색은 그 테마 파일이 권위다.

## 동작 방식

`current` 심링크가 활성 테마 디렉터리를 가리키고, `theme` 스크립트가 재지정한 뒤 각 도구를 맞춘다.

심링크를 따라가는 도구 (파일 수정 없음)

- tmux — `.tmux.conf`가 `colorscheme/current/tmux.conf`를 source
- yazi — `yazi/theme.toml`이 `colorscheme/current/yazi-theme.toml` 심링크
- pspg — `~/.pspg_theme_current`가 `colorscheme/current/pspg-theme` 심링크 (`PSQL_PAGER`의 `--custom-style=current`)
- nvim — `current`를 읽어 tokyonight(coolnight) / github_dark_default 적용, 창 포커스 시 자동 추종

셀렉터 라인을 스크립트가 재작성하는 도구

- ghostty `theme =` — 테마 파일 `ghostty/themes/<name>`
- starship `palette =` — `[palettes.<name>]`
- wezterm `local active_theme =` — 인라인 `themes` 테이블

## 테마별 커스텀 (공통 vs 전용)

공통 구조: 위 전환 메커니즘, 투명 배경, 플로트 테두리→FloatBorder·snacks→Normal 링크.

coolnight 전용

- 터미널·nvim 모두 vivid 강조색(palette.toml `[coolnight]`) 사용.
- nvim 보조 파랑 blue1/blue5/blue6은 tokyonight 원본 유지(on_colors가 안 덮는 값이라 그대로).
- nvim 에디터 bg는 `#011628`(터미널 `#011423`과 별개, 투명이라 거의 안 보임).

github-dark 전용 — stock `github_dark_default`에 얹는 보정, `nvim/.../colorscheme.lua`의 `style_github()`

- LSP 레퍼런스: 밑줄(sp=blue), solid 블록 제거.
- CursorLine `#182f50`(차분한 파랑), CursorLineNr blue bold.
- 플로트 테두리 `#58a6ff`로 밝게(모든 border 그룹이 여기 링크), FloatTitle 동일.
- Pmenu·TabLine·TabLineFill 배경 투명화(stock은 solid).
- StatusLine·Added·Changed·Removed bg 제거(이 dotfiles의 fg-only statusline 보호).
- lazygit: active 테두리 ANSI `blue`(테마 추종), inactive `#6e7681`.

## 리로드

tmux·starship·wezterm 즉시 반영, nvim 창 포커스 시. ghostty `⌘⇧,`.

## 팔레트 추가

1. `palette.toml`에 `[<name>]` 섹션 추가.
2. `colorscheme/<name>/`에 `tmux.conf`·`yazi-theme.toml`·`pspg-theme` 프래그먼트 생성 — 기존 것 복사 후 hex만 sed 치환(glyph 보존).
3. ghostty(`themes/<name>`)·starship(`[palettes.<name>]`)·wezterm(`themes`)·nvim(분기)에 등록.
4. `bin/theme` case 문에 이름 추가. `bin/palette-check <name>`로 점검.
