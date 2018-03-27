" zargs.vim - arg-list helpers

" " don't load twice
" if exists("g:loaded_zargs") || &cp || v:version < 700
"   finish
" endif
" let g:loaded_zargs = 1

function! ListZargFiles(A,B,C)
  function! Trans(A)
    return "\"" . substitute(a:A,'.*zargs/\(.*\)$','\1','g') . "\""
  endfunction

  let l:zargs=split(globpath(&rtp, 'zargs/*'))
  let l:zargsShort=map(l:zargs, 'Trans(v:val)')
  return join(l:zargsShort,"\n")
endfunction

function! InvokeZargs(type)
  let g:targetPath=globpath(&rtp, "**/zargs/".a:type)
  if g:targetPath == ''
    echom "zargs file not found for ".a:type
  else
    let g:targetFile=split(g:targetPath, '\n')[0]
    execute "edit ".g:targetFile
    redraw
    echom "edit ".g:targetFile
  endif
endfunction

command! -complete=custom,ListZargFiles -nargs=1 -bang Zargs
    \ :call InvokeZargs(<args>)

