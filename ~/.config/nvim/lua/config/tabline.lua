-- Custom tabline for filename-only display
function _G.tabline()
  local s = ''
  for i = 1, vim.fn.tabpagenr('$') do
    if i == vim.fn.tabpagenr() then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end

    s = s .. '%' .. i .. 'T'

    local buflist = vim.fn.tabpagebuflist(i)
    local winnr = vim.fn.tabpagewinnr(i)
    local bufname = vim.fn.bufname(buflist[winnr])
    local filename = vim.fn.fnamemodify(bufname, ':t')

    if filename == '' then
      filename = '[No Name]'
    end

    s = s .. ' ' .. filename .. ' '
  end

  s = s .. '%#TabLineFill#%T'
  return s
end

vim.opt.tabline = "%!v:lua.tabline()"