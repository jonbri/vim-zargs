" zargs.vim - arg-list helpers

" don't load twice
if exists("g:loaded_zargs") || &cp || v:version < 700
  finish
endif
let g:loaded_zargs = 1

" path to directory of this script
let s:path = expand('<sfile>:p:h')

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
    execute "args `cat ".g:targetFile."`"
    echom g:targetFile." loaded"
    args
  endif
endfunction

function! InvokeZargsList()
  execute "split ".s:path."/../zargs"
endfunction

function! InvokeZargsRead()
  execute "args `cat %`"
  args
endfunction

function! ZPMapping()
  call append('.', expand('%:p'))
  normal j
endfunction


command! -complete=custom,ListZargFiles -nargs=1 -bang Zargs
    \ :call InvokeZargs(<args>)

command! -bang ZargsList
    \ :call InvokeZargsList()

command! -bang ZargsRead
    \ :call InvokeZargsRead()

" print out full path of current buffer
nnoremap zp :call ZPMapping()<CR>
