local dap = require('dap')
local dapui = require('dapui')

dapui.setup()
require('nvim-dap-virtual-text').setup()
require('dap-python').setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dc', dap.continue)
vim.keymap.set('n', '<leader>dl', dap.step_into)
vim.keymap.set('n', '<leader>dk', dap.step_over)
vim.keymap.set('n', '<leader>dj', dap.step_out)
vim.keymap.set('n', '<leader>dh', dap.step_back)
vim.keymap.set('n', '<leader>dr', dap.restart)
