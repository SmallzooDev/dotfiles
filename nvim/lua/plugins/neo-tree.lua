return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- 숨김 파일을 보이게 설정
          hide_dotfiles = false, -- dotfiles를 숨기지 않음
          hide_gitignored = false, -- gitignore된 파일도 표시
        },
      },
    },
  },
}