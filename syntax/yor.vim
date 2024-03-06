" Vim syntax file
" Language: Porth

" Usage Instructions
" Put this file in .vim/syntax/yor.vim
" and add in your .vimrc file the next line:
" autocmd BufRead,BufNewFile *.yor set filetype=yor

if exists("b:current_syntax")
  finish
endif

set iskeyword=a-z,A-Z,-,*,_,!,@
syntax keyword yorTodos TODO XXX FIXME NOTE

" Language keywords
syntax keyword yorKeywords if elif then else while do include memory proc end def

" Comments
syntax region yorCommentLine start="//" end="$"   contains=yorTodos

" String literals
syntax region yorString start=/\v"/ skip=/\v\\./ end=/\v"/ contains=yorEscapes

" Char literals
syntax region yorChar start=/\v'/ skip=/\v\\./ end=/\v'/ contains=yorEscapes

" Escape literals \n, \r, ....
syntax match yorEscapes display contained "\\[nr\"']"

" Number literals
syntax region yorNumber start=/\s\d/ skip=/\d/ end=/\s/

" Type names the compiler recognizes
syntax keyword yorTypeNames addr int ptr bool
" Set highlights
highlight default link yorTodos Todo
highlight default link yorKeywords Keyword
highlight default link yorCommentLine Comment
highlight default link yorString String
highlight default link yorNumber Number
highlight default link yorTypeNames Type
highlight default link yorChar Character
highlight default link yorEscapes SpecialChar

let b:current_syntax = "yor"
