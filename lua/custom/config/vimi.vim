set errorformat=%A\ %#File\ \"%f\"\\,\ line\ %l\\,\ in\ %o,%Z\ %#%m
" :set efm=%f\ %l%.%#
command! W :w
command! X :x
command! Q :q
" :inoremap <S-Tab> <C-V><Tab>


" set jumpoptions=stack
nnoremap = :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
nnoremap { :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>
" " for all buffers
" let g:slime_target = "tmux"
" let g:slime_bracketed_paste = 1

" nmap <leader>scc <Plug>SlimeSendCell


" if not explicitly configured, it defaults to `screen`
" autocmd BufWritePost *.py LspRestart
"
  
