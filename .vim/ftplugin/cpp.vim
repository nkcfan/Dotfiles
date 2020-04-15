let b:ale_linters = ['clangtidy']
let b:ale_cpp_clangtidy_options = get(g:, 'ale_cpp_clangtidy_options', '') . ' -x c++'
