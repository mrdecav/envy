" Allow JSHint to be called any time from vim on the current buffer
" by using the JSHint command.
command! JSHint call s:JSHint()

function s:JSHint()
    :!eslint %
endfunction

autocmd BufWritePost *.js call s:JSHint()
