# VimUtils

An awesome pack of little scripts or abbreviations to ease (n)vim use

## Installation :

If you use VimPlug :
```vim
Plug 'Heliferepo/VimUtils'
```

This plugin provides :

- Some functions to compile your code easily

- Auto Indentation of braces :
```vim
inoremap {<CR> {<CR>}<ESC>O
inoremap (<CR> (<CR>)<ESC>O
inoremap [<CR> [<CR>]<ESC>O
```

- A shortcut to indent automatically :
```vim
nnoremap <leader>ai magg=G`a
```

- Clean trailing spaces automatically everytime you save

- A function to change all occurences

- An implementation of the HlNext plugin of Damian Conway to work with Vim 8.2

- C abbreviations :
```vim
"For example typing "mainf" will give

int main(void)
{
    return (0);
}
```

- Encoding is setted to :
```
set fileformat=unix
setglobal termencoding=utf-8 fileencodings=
scriptencoding utf-8
set encoding=ut-8

"Etc ...
```
