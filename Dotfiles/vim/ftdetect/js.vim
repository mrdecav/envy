" Language: JavaScript

autocmd BufNewFile,BufReadPost *.js call JSSetup()
autocmd BufNewFile *.js             call JSSkelTmpl()

function JSSetup()
    set textwidth=0
endfunction

function JSSkelTmpl()
    let l:basename = expand("%:p:t:r")
    if match(l:basename, "Model$") > -1
        0r ${USRVIMRUNTIME}/skel/js-model.js
    elseif match(l:basename, "View$") > -1
        0r ${USRVIMRUNTIME}/skel/js-view.js
    elseif match(l:basename, "Editor$") > -1
        0r ${USRVIMRUNTIME}/skel/js-view.js
    else
        0r ${USRVIMRUNTIME}/skel/js-browser.js
        exe "normal Gdd5G$"
    endif
endfunction
