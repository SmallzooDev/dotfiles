
" 참고 link ---------------------------------------------------------------------
  nnoremap <F10>r :source ~/.ideavimrc<CR>
  nmap s <NOP>
  nmap f <NOP>
  nmap F <NOP>
" set commands -----------------------------------------------------------------

  set number
  set history=1000
  set hlsearch
  set ignorecase
  set incsearch
  set smartcase
  set matchpairs
  set undolevels=2000 "undolevels
  set nrformats
  set visualbell
  set clipboard+=unnamed
  let mapleader=" "

  " https://github.com/JetBrains/ideavim/wiki/marketplace-plugin-example
  " set trackactionids

  " https://github.com/JetBrains/ideavim/wiki/Emulated-plugins
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'easymotion/vim-easymotion'

  " https://github.com/AlexPl292/IdeaVim-EasyMotion#supported-commands
  let g:EasyMotion_do_mapping = 0

  nmap sf <Plug>(easymotion-f)
  nmap sF <Plug>(easymotion-F)

  nmap sk <Plug>(easymotion-k)
  nmap sj <Plug>(easymotion-j)

  nmap sw <Plug>(easymotion-w)
  nmap sb <Plug>(easymotion-b)
  " https://github.com/JetBrains/ideavim/wiki/NERDTree-support
  Plug 'preservim/nerdtree'
  nmap <F1>f :NERDTreeFind<CR>

  " ideavim only
  set ideajoin
  set ideamarks

" copy , paste , select 기능 보완 ------------------------------------------------
  nnoremap <C-m> :
  vnoremap <C-m> :
  inoremap <C-m> <CR>
  cnoremap <C-m> <CR>

  " nnoremap <Esc> <Esc>:w<CR>
  " inoremap <Esc> <Esc>:w<CR>

  " Insert Mode:
  inoremap <C-f> <Esc>:let @z=@/<CR>/\v[)"}>]<CR>:let @/=@z<CR>:noh<CR>a
  inoremap <C-b> <Esc>:let @z=@/<CR>?\v[("{<]<CR>:let @/=@z<CR>:noh<CR>i
  inoremap <C-e> <C-o>A
  inoremap <C-a> <C-o>I

" 키 navigation 기능 보완 ---------------------------------------------------------
  nnoremap <PageDown> gT
  nnoremap <PageUp> gt
  nnoremap gl 1gtgT
  nnoremap gf 1gt

" IntelliJ action 명령 테스트 ----------------------------------------------------

  "ideavim 에서는 :command 명령을 사용할 수 없다...

  "라인 스플릿. :action 을 부르는 방식의 성능이 나쁘고, number operation 반복이 안 됨
  nnoremap K i<CR><ESC>

  "다음 기능들은 검색 창이 열린 다음에 포커스가 곧바로 에디터로 이동하므로 불편하고 쓸모가 없음.
  "실행한 다음 포커스가 남아 있기만 해도 굉장히 쓸만할 것 같은데 아쉽다.
  " nnoremap <F1><F1> :action SearchEverywhere<CR>
  nmap <F1><F1> <Action>(SearchEverywhere)
  nmap <F1><F2> <Action>(FindInPath)
  nmap <F1><F3> <Action>(ShowBookmarks)
  nmap <F3><F3> <Action>(ActivateTerminalToolWindow)

  nmap <F1>t <Action>(ActivateStructureToolWindow)
  nmap <F1>s <Action>(ManageRecentProjects)
  nmap <F1>r <Action>(ActivateREPLToolWindow)
  nmap <F1>d <Action>(ActivateDatabaseToolWindow)
  nmap <leader>gR <Action>(ShowUsages)
  nmap <leader>gi <Action>(GotoImplementation)
  nmap <leader>gI <Action>(GotoSuperMethod)

" IntelliJ IDEA 에서 제공하지 않는 VIM 기능들 ----------------------------------------

  "ideavim 에서는 insert mode <C-P>, <C-N> 이 작동하지 않는다. 대신 IntelliJ 의 keymap 중
  "  Main Menu > Code > Code > Completion > Cyclic Expand Word 가 비슷한 기능을 한다.
  "  Cyclic Expand Word 에 ^p, Cyclic Expand Word (Backward) 에 ^n 을 지정해주면 된다.

nnoremap g; :action JumpToLastChange<CR>
nnoremap g, :action JumpToNextChange<CR>

nnoremap H ^
nnoremap L g_

nnoremap [[ :action MethodUp<CR>
nnoremap ]] :action MethodDown<CR>
onoremap [[ :action MethodUp<CR>
onoremap ]] :action MethodDown<CR>

nnoremap <C-S-5> :action EditorMatchBrace<CR>
nnoremap <leader>K :action QuickJavaDoc<CR>
nnoremap <Tab>d :action QuickJavaDoc<CR>
nnoremap <Tab>f :action QuickFixes<CR>
nnoremap <Tab>oo :action CloseAllEditorsButActive<CR>
nnoremap <Tab>ol :action CloseAllToTheLeft<CR>
nnoremap <Tab>or :action CloseAllToTheRight<CR>
nnoremap <Tab>i :action InspectCode<CR>
nnoremap <Tab>u :action FindUsages<CR>
nnoremap <Tab>, :e ~/.ideavimrc<CR>
nnoremap <leader>ll :action Refactorings.QuickListPopupAction<CR>
nnoremap <leader>rn :action RenameElement<CR>
nnoremap <Space>v :action CopyPaths<CR>



" Bookmarks 알파벳 마크는 글로벌 마크만 왼쪽에 표시된다. 글로벌 마크만 쓰자.
nmap `0 <Action>(GotoBookmark0)
nmap `1 <Action>(GotoBookmark1)
nmap `2 <Action>(GotoBookmark2)
nmap `3 <Action>(GotoBookmark3)
nmap `4 <Action>(GotoBookmark4)
nmap `5 <Action>(GotoBookmark5)
nmap `6 <Action>(GotoBookmark6)
nmap `7 <Action>(GotoBookmark7)
nmap `8 <Action>(GotoBookmark8)
nmap `9 <Action>(GotoBookmark9)
nmap `a <Action>(GotoBookmarkA)
nmap `b <Action>(GotoBookmarkB)
nmap `c <Action>(GotoBookmarkC)
nmap `d <Action>(GotoBookmarkD)
nmap `e <Action>(GotoBookmarkE)
nmap `f <Action>(GotoBookmarkF)
nmap `g <Action>(GotoBookmarkG)
nmap `h <Action>(GotoBookmarkH)
nmap `i <Action>(GotoBookmarkI)
nmap `j <Action>(GotoBookmarkJ)
nmap `k <Action>(GotoBookmarkK)
nmap `l <Action>(GotoBookmarkL)
nmap `m <Action>(GotoBookmarkM)
nmap `n <Action>(GotoBookmarkN)
nmap `o <Action>(GotoBookmarkO)
nmap `p <Action>(GotoBookmarkP)
nmap `q <Action>(GotoBookmarkQ)
nmap `r <Action>(GotoBookmarkR)
nmap `s <Action>(GotoBookmarkS)
nmap `t <Action>(GotoBookmarkT)
nmap `u <Action>(GotoBookmarkU)
nmap `v <Action>(GotoBookmarkV)
nmap `w <Action>(GotoBookmarkW)
nmap `x <Action>(GotoBookmarkX)
nmap `y <Action>(GotoBookmarkY)
nmap `z <Action>(GotoBookmarkZ)

nmap m0 <Action>(ToggleBookmark0)
nmap m1 <Action>(ToggleBookmark1)
nmap m2 <Action>(ToggleBookmark2)
nmap m3 <Action>(ToggleBookmark3)
nmap m4 <Action>(ToggleBookmark4)
nmap m5 <Action>(ToggleBookmark5)
nmap m6 <Action>(ToggleBookmark6)
nmap m7 <Action>(ToggleBookmark7)
nmap m8 <Action>(ToggleBookmark8)
nmap m9 <Action>(ToggleBookmark9)
nmap ma <Action>(ToggleBookmarkA)
nmap mb <Action>(ToggleBookmarkB)
nmap mc <Action>(ToggleBookmarkC)
nmap md <Action>(ToggleBookmarkD)
nmap me <Action>(ToggleBookmarkE)
nmap mf <Action>(ToggleBookmarkF)
nmap mg <Action>(ToggleBookmarkG)
nmap mh <Action>(ToggleBookmarkH)
nmap mi <Action>(ToggleBookmarkI)
nmap mj <Action>(ToggleBookmarkJ)
nmap mk <Action>(ToggleBookmarkK)
nmap ml <Action>(ToggleBookmarkL)
nmap mm <Action>(ToggleBookmarkM)
nmap mn <Action>(ToggleBookmarkN)
nmap mo <Action>(ToggleBookmarkO)
nmap mp <Action>(ToggleBookmarkP)
nmap mq <Action>(ToggleBookmarkQ)
nmap mr <Action>(ToggleBookmarkR)
nmap ms <Action>(ToggleBookmarkS)
nmap mt <Action>(ToggleBookmarkT)
nmap mu <Action>(ToggleBookmarkU)
nmap mv <Action>(ToggleBookmarkV)
nmap mw <Action>(ToggleBookmarkW)
nmap mx <Action>(ToggleBookmarkX)
nmap my <Action>(ToggleBookmarkY)
nmap mz <Action>(ToggleBookmarkZ)

nmap <F1>p <Action>(ParameterNameHints)

" for split
nmap <leader>sv <Action>(SplitVertically)
nmap <leader>sh <Action>(SplitHorizontally)
nmap <leader>su <Action>(Unsplit)
nmap <leader>sm <Action>(MoveEditorToOppositeTabGroup)
nmap <leader>sb <Action>(Back)
nmap <leader>sf <Action>(Forward)

nmap <leader>cw <Action>(HideActiveWindow)

nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-k> <C-w>k
nmap <C-j> <C-w>j

" 열려있는 파일을 explorer에서 포커스 맞추기
nmap <leader>e <Action>(SelectInProjectView)
