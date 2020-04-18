" class
hi default link cppStructure Statement
" true false
hi default link cppBoolean Statement            " true false

hi default link cStructure Statement
hi default link cType Statement
hi default link cStorageClass Statement

let b:ale_linters = ['clangtidy']
let b:ale_cpp_clangtidy_options = get(g:, 'ale_cpp_clangtidy_options', '') . ' -x c++'
