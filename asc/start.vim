"======================================================================
"startify
"======================================================================

let s:starttext=[
            \'+------------------------------------------------------------------------------------------------------+',
            \'|                                                                                                      |',
            \'|             ^                                                                                        |',
            \'|            / \                                                                                       |',
            \'|           /   \                                                      /                               |',
            \'|          /     \                                                    /                                |',
            \'|         /       \                                                  /                                 |',
            \'|        /---------\                                                /                                  |',
            \'|       /           \       /---\   +-----+  |     |   /---        /         /-\        X       \    | |',
            \'|      /             \     /     \  |     |  |     |  |           /         /   \      / \      |\   | |',
            \'|     /               \    |     |  |     |  |     |  \--/       /         X-----\    /---\     | \  | |',
            \'|    /                 \   |     |  \     |  \     /    /       /          \         /     \    |  \ | |',
            \'|   /                   \  |     |   \----+   \---/    /---    /---------   \-----  /       \   |   \| |',
            \'|                                         |                                                            |',
            \'|                                         |                                                            |',
            \'|                                        /                                                             |',
            \'|                                    ----                                                              |',
            \'|                                                                           -By AngusLean              |',
            \'|                                                                                  cupofish@gmail.com  |',
            \'+------------------------------------------------------------------------------------------------------+',
            \]


function! s:filter_header(lines) abort
    let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
    let centered_lines = map(copy(a:lines),
                \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
    return centered_lines
endfunction
" let g:startify_bookmarks = systemlist("cut -sd' ' -f 2 ~/.NERDTreeBookmarks")
let g:startify_list_order = [
            \ ['   My most recently used files in the current directory:'],
            \ 'dir',
            \ ['   My most recently used files:'],
            \ 'files',
            \ ['   These are my sessions:'],
            \ 'sessions',
            \ ['   These are my bookmarks:'],
            \ 'bookmarks',
            \ ]

let g:startify_session_dir = $HOME .  '/.data/' . 'vim/session'
let g:startify_custom_footer = s:filter_header(['Time: ' . strftime("%Y/%m/%d %H:%M:%S")])
let g:startify_custom_header = s:filter_header(s:starttext)
let g:startify_files_number = 6
let g:startify_enable_special = 0
let g:startify_session_autoload = 1
