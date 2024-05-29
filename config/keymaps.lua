-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = LazyVim.safe_keymap_set

-- map("n", "<S-x>", ":bd<CR>", { silent = true })
map("n", "<S-x>", ":bp|bd#<CR>", { silent = true })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })

map("n", "d", '"_d', { silent = true })
map("n", "dd", '"_dd', { silent = true })
map("x", "d", '"_d', { silent = true })
map("x", "dd", '"_dd', { silent = true })
map("n", "<M-q>", "<C-W>w", { silent = true })
map("n", "<M-k>", "", { silent = true })
map("n", "<M-j>", "", { silent = true })
map("x", "<M-k>", "", { silent = true })
map("x", "<M-j>", "", { silent = true })
map("n", "<M-j>", ":vsplit<CR>", { silent = true })
map("n", "<M-k>", ":wincmd c<CR>", { silent = true })
map("x", "<M-j>", ":vsplit<CR>", { silent = true })
map("x", "<M-k>", ":wincmd c<CR>", { silent = true })

map("n", "<C-s>", ":w<CR>", { silent = true })
map("x", "<C-s>", ":w<CR>", { silent = true })
map("i", "<C-s>", "<C-c>:w<CR>", { silent = true })

-- Harpoon
local harpoon = require("harpoon")
local extensions = require("harpoon.extensions")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end)
vim.keymap.set("n", "<M-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<M-1>", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<M-2>", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<M-3>", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<M-4>", function()
  harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<M-s>", function()
  harpoon:list():prev()
end)
vim.keymap.set("n", "<M-a>", function()
  harpoon:list():next()
end)

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

vim.keymap.set("n", "<C-e>", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

harpoon:extend({
  UI_CREATE = function(cx)
    vim.keymap.set("n", "<C-v>", function()
      harpoon.ui:select_menu_item({ vsplit = true })
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-x>", function()
      harpoon.ui:select_menu_item({ split = true })
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-t>", function()
      harpoon.ui:select_menu_item({ tabedit = true })
    end, { buffer = cx.bufnr })
  end,
})

harpoon:extend(extensions.builtins.navigate_with_number())

-- require("nvim-termi.termi")
-- vim.api.nvim_set_keymap("n", "<leader>b", ":lua testFct()<CR>", { silent = true, noremap = true })

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
end, { desc = "Next error/warning todo comment" })

-- oil.nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- build with build.lua script
vim.keymap.set("n", "<C-b>", ":luafile build.lua<CR>", { noremap = true, silent = true })
