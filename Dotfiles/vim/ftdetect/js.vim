" Language: JavaScript

autocmd BufNewFile,BufReadPost *.js call JSSetup()
autocmd BufNewFile *.js             call JSBrowserTmpl()

function JSSetup()
    set textwidth=0
endfunction

function JSBrowserTmpl()
    0r ${USRVIMRUNTIME}/skel/js-browser.js
    exe "normal Gdd5G$"
endfunction
