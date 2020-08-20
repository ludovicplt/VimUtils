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
