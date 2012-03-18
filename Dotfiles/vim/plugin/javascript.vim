" Allow JSHint to be called any time from vim on the current buffer
" by using the JSHint command.
command! JSHint call s:JSHint()

function s:JSHint()
    :!jshint % --show-non-errors
endfunction

autocmd BufWritePost *.js call s:JSHint()
