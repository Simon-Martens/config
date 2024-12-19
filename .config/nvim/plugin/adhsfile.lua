local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function file_exists(name)
  local f = io.open(name, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local function create_floating_window(opts)
  -- Create a new buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) and opts.buf ~= -1 then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  vim.api.nvim_set_option_value('filetype', 'markdown', { buf = buf })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':ADHSFile<cr>', { noremap = false, silent = true })
  -- vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':b<CR>', { noremap = false, silent = false })
  -- vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':wq<CR>', { noremap = false, silent = false })

  -- Get the dimensions of the editor
  local width = vim.o.columns
  local height = vim.o.lines

  -- Define the dimensions for the floating window
  local win_width = math.floor(width * 0.8)
  local win_height = math.floor(height * 0.8)

  -- Define the options for the floating window
  local wopts = {
    relative = 'editor',
    width = win_width,
    height = win_height,
    col = math.floor((width - win_width) / 2),
    row = math.floor((height - win_height) / 2),
    border = { '╔', '═', '╗', '║', '╝', '═', '╚', '║' },
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, wopts)

  return { buf = buf, win = win }
end

local toggle_adhsfile = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    local new_buf = false
    if state.floating.buf == -1 then
      new_buf = true
    end
    state.floating = create_floating_window { buf = state.floating.buf }
    if new_buf or not file_exists 'ADHSFile.md' then
      vim.cmd ':e ADHSFile.md'
    end
    if file_exists 'ADHSFile.md' then
      vim.cmd ':$'
      vim.cmd ':norm! o'
    end
    vim.cmd ':startinsert'
  else
    vim.api.nvim_set_current_buf(state.floating.buf)
    -- Can't get this to work in pure lua
    vim.cmd ':update'
    pcall(vim.cmd, ':%s#\\($\\n\\s*\\)\\+\\%$##')
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command('ADHSFile', toggle_adhsfile, {})
vim.keymap.set({ 'n', 'v' }, '<Leader>a', ':ADHSFile<CR>', { noremap = true, silent = true })
