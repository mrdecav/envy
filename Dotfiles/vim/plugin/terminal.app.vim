" 
let s:Terminal_app_version = '1.0.0'

augroup TerminalApp
    autocmd VimLeave * call s:RestoreTitleState()
    autocmd BufEnter * call s:UpdateTitleState()
augroup END

function s:RestoreTitleState ()
    " Reset the tab name; Terminal.app will handle setting it properly.
    :silent !printf "\e]2;\a"
    :silent !printf "\e]6;\a"
endfunction

" Updates the Terminal.app for the current file.
function s:UpdateTitleState ()
    let shortPath = expand("%:t")
    let pathURL = "file://" . substitute(expand("%:p"), " ", "\%20", "g")

    :exec ":silent !printf \"\\e]2;vim: \\%s\\a\" " . shortPath
    :exec ":silent !printf \"\\e]6;\\%s\\a\" " . pathURL
endfunction
