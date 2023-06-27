augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 500})
augroup END

function! TrimWhitespace()
  if &ft == "markdown" || &ft == "vimwiki"
    return
  endif
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfunction

augroup trim_whitespace
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Indent/tabs
augroup filetype_options
  autocmd!
  autocmd Filetype vim  setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype go   setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd Filetype css  setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype scss setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype beancount setlocal ts=2 sts=2 sw=2 expandtab nofoldenable relativenumber

  autocmd BufNewFile,BufRead {Brewfile,Gemfile} set filetype=ruby
augroup END

augroup terminal_options
  autocmd!
  autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal nonumber norelativenumber
  autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
augroup END

augroup quickfix_close
  autocmd!
  autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
augroup END

augroup linenumber
  autocmd!
  autocmd InsertEnter * setlocal norelativenumber
  autocmd InsertLeave * setlocal relativenumber
augroup END

" beancount format
function! BeanFormat()
  let l:save = winsaveview()
  exec ':%!bean-format'
  call winrestview(l:save)
endfunction

augroup bean_format
  autocmd!
  autocmd BufWritePre {*.bean,*.beancount} :call BeanFormat()
  autocmd BufWritePost {*.bean,*.beancount} :!bean-check <afile>
augroup END
