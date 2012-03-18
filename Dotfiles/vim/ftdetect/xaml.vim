autocmd BufRead,BufNewFile *.xaml call XAMLFile()

function XAMLFile()
  setlocal filetype=xml
  set textwidth=0
  set tabstop=4
  set shiftwidth=4
  set nowrap
endfunction
