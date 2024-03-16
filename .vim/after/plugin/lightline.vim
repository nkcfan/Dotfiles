if !exists('g:loaded_lightline')
    finish
endif

augroup LightlineOnChanges
  autocmd!
  autocmd User ALEFixPre   call lightline#update()
  autocmd User ALEFixPost  call lightline#update()
  autocmd User ALELintPre  call lightline#update()
  autocmd User ALELintPost call lightline#update()
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
  autocmd User CocGitStatusChange call lightline#update()
  if exists('##DiagnosticChanged')
      autocmd DiagnosticChanged * call lightline#update()
  endif
augroup end

