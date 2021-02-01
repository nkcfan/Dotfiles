" gutentags
"let g:gutentags_trace=1
let g:gutentags_ctags_extra_args = ['--languages=AnsiblePlaybook,Autoconf,Automake,Awk,Basic,C,C#,C++,Clojure,CPreProcessor,CUDA,DosBatch,Erlang,Fortran,Go,Iniconf,Java,JavaProperties,JavaScript,Lisp,Lua,M4,Make,MatLab,Maven2,ObjectiveC,OCaml,Pascal,Perl,Perl6,pod,Python,PythonLoggingConfig,R,RpmSpec,RSpec,Ruby,Rust,Scheme,Sh,SQL,SystemVerilog,Tcl,TclOO,Tex,Verilog,VHDL,Vim,XSLT,YACC,Yaml']
let g:gutentags_ctags_extra_args += ['--tag-relative=yes', '--fields=+ailmnS', '--c-kinds=+p', '--c++-kinds=+p', '--extras=+q']
let g:gutentags_file_list_command = expand('~/.cargo/bin/rg --files')
let g:gutentags_ctags_exclude = ['*.ini', '*.min.js', '*.css']
augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

" Prepare system wide ctags
let g:gutentags_ctags_executable = 'ctags'
let s:systags = expand('~/.vim/systags')
let s:sysincludes = ['/usr/include', '/usr/local/include']
if !filereadable(s:systags) && executable(g:gutentags_ctags_executable)
    let cmd = join([g:gutentags_ctags_executable, '-R', '-f', s:systags] + g:gutentags_ctags_extra_args + s:sysincludes)
    call system(cmd)
endif
let &tags .= ',' . s:systags
