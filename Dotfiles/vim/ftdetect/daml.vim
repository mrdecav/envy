autocmd BufRead,BufNewFile *.daml call DAMLFile()

function DAMLFile()
  setlocal filetype=haskell
endfunction
