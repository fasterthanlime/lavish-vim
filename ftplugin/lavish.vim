" Language:    Lavish
" Maintainer:  Amos Wenger <amoswenger@gmail.com>
" Based On:    https://github.com/pangloss/vim-javascript
" URL:         http://github.com/lavish-lang/lavish-vim
" License:     MIT

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal comments=://
setlocal commentstring=//\ %s

let b:undo_ftplugin = "setlocal comments< commentstring<"

