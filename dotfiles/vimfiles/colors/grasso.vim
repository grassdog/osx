" My colors based on Zellner.
" Makes things a little easier on the eyes on windows machines
" vim: tw=0 ts=4 sw=4
" Vim color file
" Last Change:	2007 Dec 21

set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "grasso"

hi Comment term=bold ctermfg=DarkGreen guifg=DarkGreen
hi Normal guifg=black guibg=LightGray
hi Constant term=underline ctermfg=Magenta guifg=Magenta
hi Special term=bold ctermfg=Magenta guifg=Magenta
hi Identifier term=underline ctermfg=Blue guifg=Blue
hi Statement term=bold ctermfg=DarkRed gui=NONE guifg=Brown
hi PreProc term=underline ctermfg=Magenta guifg=Purple
hi Type term=underline ctermfg=Blue gui=NONE guifg=Blue
hi Search term=reverse ctermfg=Yellow ctermbg=Red gui=NONE guifg=Black guibg=Yellow
hi Visual term=reverse ctermfg=Black ctermbg=Cyan gui=NONE guifg=Black guibg=Cyan
hi Tag term=bold ctermfg=DarkGreen guifg=DarkGreen
hi Error term=reverse ctermfg=15 ctermbg=9 guibg=Red guifg=White
hi Todo term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow
hi  StatusLine term=bold,reverse cterm=NONE ctermfg=Yellow ctermbg=DarkGray gui=NONE guifg=Yellow guibg=DarkGray
hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
hi! link MoreMsg Comment
hi! link ErrorMsg Visual
hi! link WarningMsg ErrorMsg
hi! link Question Comment
hi link String	Constant
hi link Character	Constant
hi link Number	Constant
hi link Boolean	Constant
hi link Float		Number
hi link Function	Identifier
hi link Conditional	Statement
hi link Repeat	Statement
hi link Label		Statement
hi link Operator	Statement
hi link Keyword	Statement
hi link Exception	Statement
hi link Include	PreProc
hi link Define	PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	Type
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment Special
hi link Debug		Special
