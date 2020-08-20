""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function To Compile Easily and put error in quick fix list "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Extensions_known()
    let s:dic = {}

    let s:dic['c'] = "gcc -W -Wall -Wextra -Werror " .  expand("%") . " -o " . expand("%<")

    let s:dic['cpp'] = "g++ -W -Wall -Wextra -Werror " .  expand("%") . " -o " . expand("%<")
    let s:dic['C'] = "g++  -W -Wall -Wextra -Werror " .  expand("%") . " -o " . expand("%<")
    let s:dic['cc'] = "g++ -W -Wall -Wextra -Werror " .  expand("%") . " -o " . expand("%<")

    let s:dic['java'] = "javac -g " . expand("%")

    let s:dic['tex'] = "pdfcslatex -file-line-error-style " . expand("%")

    let s:dic['pp'] = "fpc -g -O2 " . expand("%") . " -o " . expand("%<")
    let s:dic['pas'] = "fpc -g -O2 " . expand("%") . " -o " . expand("%<")

    let s:dic['py'] = "python3 " . expand("%")

    let s:dic['perl'] = "perl " . expand("%")

    let s:dic['js'] = "node " . expand("%")

    let s:dic['make'] = "make"
    let s:dic['makefile'] = "make"
    let s:dic['Makefile'] = "make"

    return s:dic
endfunction

function! Compile()
    let s:defaults = Extensions_known()

    let s:extension = expand("%:e")

    if !exists('b:ccommand')
        if has_key(s:defaults, s:extension)
            let b:ccommand = s:defaults[s:extension]
        else
            let b:ccommand = "make"
        endif
    endif

    echohl Question
    let b:ccommand = input("compile: ", b:ccommand)
    echohl None

    let &makeprg = b:ccommand
    exec "make"
endfunction

command! -nargs=0 Compile :call Compile()

map <C-c>c <ESC>:Compile<CR><CR><CR>:copen<CR>
map <C-c>sc <ESC>:w<CR>:Compile<CR><CR><CR>:copen<CR>

""""""""""""""""""""""""""""""""""""
" Remap to make indentation faster "
""""""""""""""""""""""""""""""""""""

inoremap {<CR> {<CR>}<Esc>O
inoremap (<CR> (<CR>)<Esc>O
inoremap [<CR> [<CR>]<Esc>O

nnoremap <leader>ai magg=G`a

"""""""""""""""""""""""""""""""""""""
" Function to Clean trailing Spaces "
"""""""""""""""""""""""""""""""""""""

function! CleanExtraSpaces() "Function to clean unwanted spaces
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

autocmd BufWritePre * :call CleanExtraSpaces()
"call CleanExtraSpaces to remove unwanted spaces when saving

"""""""""""""""""""""""""""""""""""""""""""""""""
" Function to have a change all occurences like "
"""""""""""""""""""""""""""""""""""""""""""""""""

function! Therenamer(word)
    let s:replace = a:word
    echohl Question
    let s:replace = input("Replace with: ", a:word)
    echohl None
    exec "%s/" . a:word . "/" . s:replace . "/g"
endfunction

command! Renamer call feedkeys("\yiw :call Therenamer(\"\<C-r>\"\")")

nnoremap <leader>r :Renamer
imap <C-r>r <Esc>:Renamer

"""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations for C programming (and c++) "
"""""""""""""""""""""""""""""""""""""""""""""

if (&ft == 'c')

    setlocal cindent
    let c_space_errors = 1

    abbrev iff if () {<CR>
    abbrev forf for() {<CR>
    abbrev whilef while () {<CR>
    abbrev mallocf (type)malloc(size * sizeof(type));

    abbrev incstdio #include <stdio.h>
    abbrev incunistd #include <unistd.h>
    abbrev inclib #include <stdlib.h>
    abbrev incmath #include <math.h>
    abbrev incstring #include <string.h>
    abbrev incmy #include <my.h>
    abbrev incbool #include <stdbool.h>
    abbrev inccdef #include <cdefs.h>
    abbrev incdef #include <stddef.h>
    abbrev incint #include <stdint.h>

    abbrev mainf int main(void)<CR>{<CR>return (0);
    abbrev mainargf int main(int argc, char **argv)<CR>{<CR>return (0);
    abbrev intf int f()<CR>{<CR>return (int);
    abbrev charf char f()<CR>{<CR>return (char);
    abbrev strf char *f()<CR>{<CR>return (char*);
    abbrev voidf void f()<CR>{<CR>foo
    abbrev switchf switch() {<CR>case '?':<CR>break;<CR>case '?':<CR>break;<CR>default:<CR>break;

endif

""""""""""""""""""""""""""""""""""""""""""""""""
" My implementation of hlnext of Damian Conway "
""""""""""""""""""""""""""""""""""""""""""""""""

if exists("loaded_HLNext")
    finish
endif
let loaded_HLNext = 1

nnoremap           /   :call HLNextSetTrigger()<CR>/
nnoremap           ?   :call HLNextSetTrigger()<CR>?
nnoremap  <silent> n  n:call HLNext()<CR>
nnoremap  <silent> N  N:call HLNext()<CR>

highlight default HLNext ctermfg=white ctermbg=darkred

let g:HLNext_matchnum = 0

function! HLNext ()
    call HLNextOff()
    let target_pat = '\c\%#'.@/
    let g:HLNext_matchnum = matchadd('HLNext', target_pat)
endfunction

function! HLNextOff ()
    if (g:HLNext_matchnum > 0)
        call matchdelete(g:HLNext_matchnum)
        let g:HLNext_matchnum = 0
    endif
endfunction

function! HLNextSetTrigger ()
    augroup HLNext
        autocmd!
        autocmd  CursorMoved  *  :call HLNextMovedTrigger()
    augroup END
endfunction

function! HLNextMovedTrigger ()
    augroup HLNext
        autocmd!
    augroup END
    call HLNext()
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For cross platforming and make this works everytime "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

set fileformat=unix

setglobal termencoding=utf-8 fileencodings=
scriptencoding utf-8
set encoding=utf-8

autocmd BufNewFile,BufRead  *  try
autocmd BufNewFile,BufRead  *  set encoding=utf-8
autocmd BufNewFile,BufRead  *  endtry
