let b:ale_linters = ['clangtidy', 'ccls']
let b:ale_fixers = ['clang-format']
let b:ale_cpp_clangtidy_options = get(g:, 'ale_cpp_clangtidy_options', '') . ' -x c++'
