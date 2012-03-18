" Language: HTML

autocmd BufNewFile *.html call HTMLTmpl()

function HTMLTmpl()
    0r ${USRVIMRUNTIME}/skel/empty.html
    exe "normal 3G7l"
endfunction
