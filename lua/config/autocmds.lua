local api = vim.api

local function augroup(name)
  return api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
api.nvim_create_autocmd({
  "FocusGained",
  "TermClose",
  "TermLeave",
}, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = augroup("highlight_yank"),
})

-- show cursor line only in active window
api.nvim_create_autocmd(
  { "InsertLeave", "WinEnter" },
  { pattern = "*", command = "set cursorline", group = augroup("cursor_line") }
)
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorline", group = augroup("cursor_line") }
)

-- go to last loc when opening a buffer
api.nvim_create_autocmd(
  "BufReadPost",
  {
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
    group = augroup("last_loc")
  }
)


-- windows to close with "q"
api.nvim_create_autocmd(
  "FileType",
  { pattern = { "help", "startuptime", "qf", "lspinfo" }, command = [[nnoremap <buffer><silent> q :close<CR>]] }
)
api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- auto set tab, width, etc... according file type
api.nvim_create_autocmd(
  "FileType",
  { pattern = { "python" }, command = [[set tabstop=4 shiftwidth=4 expandtab ai]] }
)
api.nvim_create_autocmd(
  "FileType",
  {
    pattern = { "ruby", "javascript", "html", "css", "xml", "lua" },
    command = [[set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai]]
  }
)
api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.md", "*.mkd", "*.markdown" }, command = [[set filetype=markdown.mkd]] }
)
api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.part" }, command = [[set filetype=html]] }
)
api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  {
    pattern = { "*.vue" },
    command = [[setlocal filetype=vue.html.javascript tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai]]
  }
)

-- WSL yank support
api.nvim_create_autocmd(
  "TextYankPost",
  {
    command = [[
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
    if executable(s:clip)
      augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
      augroup END
    endif
  ]]
  }
)
