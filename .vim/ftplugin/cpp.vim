if exists('g:ale_linters')
    let b:ale_linter_aliases = {'cpp': ['cpp', 'text']}
    let b:ale_linters = ['clangtidy', 'ccls'] + g:ale_linters['text']
    let b:ale_fixers = ['clang-format']
    let b:ale_cpp_clangtidy_options = get(g:, 'ale_cpp_clangtidy_options', '') . ' -x c++'
endif
