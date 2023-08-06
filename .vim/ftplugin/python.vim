if exists('g:ale_linters')
    let b:ale_linter_aliases = {'python': ['python', 'text']}
    let b:ale_linters = ['flake8'] + g:ale_linters['text']
    let b:ale_fixers = ['black', 'isort']
endif
