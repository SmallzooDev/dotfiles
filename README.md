# My Dotfiles Repository

---

## Install Brew

```
# https://brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> /Users/joonkyu_kang/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/joonkyu_kang/.zprofile

```

## Mise

```
mise install go@latest
mise install python@latest
mise install node@lts
mise install rust@latest

mise use -g go@latest
mise use -g python@latest
mise use -g node@lts
mise use -g rust@latest
```

## LLM

```
npm install -g @anthropic-ai/claude-code
npm install -g @google/gemini-cli

```

## Brew Bundle

```
brew bundle
```

## Go

```
  go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
  go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

## Tmux Popup

| 키 | 용도 | 유형 |
|---|---|---|
| `C-f p` | Scratch shell (Claude Code) | Persistent |
| `C-f g` | Lazygit | Instant |
| `C-f n` | Notes | Instant |

### Persistent 세션 종료

popup 안에서:
```bash
exit  # shell 종료 → 세션도 함께 종료
```

popup 밖에서:
```bash
tmux kill-session -t scratch
```

> `C-f p`는 detach(세션 유지), `exit`는 세션 종료

## References

https://johngrib.github.io/wiki/mac/setting/#brewfile-%EC%83%9D%EC%84%B1
