" zargs.vim - plugin for populating the arg-list

" don't load twice
if exists("g:loaded_zargs") || &cp || v:version < 700
  finish
endif
let g:loaded_zargs = 1

" path to directory of this script
let s:path = expand('<sfile>:p:h')

" auto-complete for Zargs command
function! ListZargFiles(A,B,C)
  function! Trans(A)
    return "\"" . substitute(a:A,'.*zargs/\(.*\)$','\1','g') . "\""
  endfunction
  let l:zargs=split(globpath(&rtp, 'zargs/*'))
  let l:zargsShort=map(l:zargs, 'Trans(v:val)')
  call insert(l:zargsShort, "'%'") " prepend '%'
  return join(l:zargsShort,"\n")
endfunction

function! InvokeZargsList()
  execute "split ".s:path."/../zargs"
endfunction

function! InvokeZargs(...)
  " if no args, show list
  if a:0 == ''
    call InvokeZargsList()
  " read in current buffer contents
  elseif a:1 == '%'
    execute "args `cat %`"
    args
  " read in file from zargs dir
  else
    let g:targetPath=globpath(&rtp, "**/zargs/".a:1)
    if g:targetPath == ''
      echom "zargs file not found for ".a:1
    else
      let g:targetFile=split(g:targetPath, '\n')[0]
      execute "args `cat ".g:targetFile."`"
      echom g:targetFile." loaded"
      args
    endif
  endif
endfunction

function! ZPMapping()
  call append('.', expand('%:p'))
  normal j
endfunction


command! -complete=custom,ListZargFiles -nargs=? -bang Zargs
    \ :call InvokeZargs(<args>)

" print out full path of current buffer
nnoremap zp :call ZPMapping()<CR>
