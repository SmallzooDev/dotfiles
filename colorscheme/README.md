# colorscheme

`theme` 하나로 `coolnight`, `github-dark`, `catppuccin-mocha`, `rose-pine`을 전환한다.

    theme
    theme rose-pine

`current` 심링크가 활성 테마다. `themes.lua`는 WezTerm과 Neovim의 테마 이름을 한곳에서 관리하고, Ghostty는 각 테마 디렉터리의 작은 설정을 읽는다.

Catppuccin Mocha와 Rosé Pine은 WezTerm·Ghostty의 내장 테마와 Neovim의 공식 플러그인을 사용한다. Yazi는 공식 카탈로그에 등록된 flavor를 사용한다. tmux·Starship·lazygit·pspg는 터미널 ANSI 팔레트를 사용하므로 테마별 색 복사본이 없다.

WezTerm과 tmux는 즉시 반영되고 Neovim은 포커스를 되찾을 때 반영된다. Ghostty는 `⌘⇧,`로 다시 읽는다.

테마를 추가하려면 `themes.lua`, `<name>/ghostty.conf`, `<name>/yazi-theme.toml`을 추가하고 필요한 Neovim 플러그인을 등록한다.

Yazi flavor는 처음 한 번 `ya pkg install`로 설치한다.
