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

## References

https://johngrib.github.io/wiki/mac/setting/#brewfile-%EC%83%9D%EC%84%B1

todo del : test obsidian
