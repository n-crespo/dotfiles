vim.g.neovide_scale_factor = 0.8
local change_scale_factor = function(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
	change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
	change_scale_factor(1 / 1.25)
end)

-- Helper function for transparency formatting
local alpha = function()
	return string.format("%x", math.floor(255 * vim.g.neovide_transparency_point or 0.8))
end
-- Set transparency and background color (title bar color)
vim.g.neovide_transparency = 1
vim.g.neovide_transparency_point = 0.8
vim.g.neovide_background_color = "#0f1117" .. alpha()
-- Add keybinds to change transparency
local change_transparency = function(delta)
	vim.g.neovide_transparency_point = vim.g.neovide_transparency_point + delta
	vim.g.neovide_background_color = "#0f1117" .. alpha()
end
vim.keymap.set({ "n", "v", "o" }, "<C-]>", function()
	change_transparency(0.01)
end)
vim.keymap.set({ "n", "v", "o" }, "<C-[>", function()
	change_transparency(-0.01)
end)

vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save File", noremap = true, silent = true })

-- media control buttons (don't send keypresses)
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- volume up
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- volume down
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- mute
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- mute
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- prev
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- skip

-- --------------------------------------- BETTER MOTIONS ---------------------------------------

vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { noremap = true, desc = "Go Down" })
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { noremap = true, desc = "Go Up" })
vim.keymap.set("n", "G", "Gzz", { noremap = true, desc = "End of File" })
vim.keymap.set("n", "n", "nzzzv", { noremap = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, desc = "Prev Search Result" })

-- don't let cursor fly around when using J
vim.keymap.set("n", "J", "mzJ`z<cmd>delm z<CR>", { silent = true, desc = "better J" })

-- full line navigation (i never use E and B)
vim.keymap.set({ "n", "v", "o" }, "E", "g$", { desc = "End of line", silent = true })
vim.keymap.set({ "n", "v", "o" }, "B", "g0", { desc = "Start of line", silent = true })

-- go to visual end of line unless wrap is disabled!!
vim.keymap.set({ "n", "v", "o" }, "E", function()
	if vim.opt.wrap:get() then
		vim.cmd("normal! g$")
	else
		vim.cmd("normal! $")
	end
end, { desc = "End of line", silent = true })

vim.keymap.set({ "n", "v", "o" }, "B", function()
	if vim.opt.wrap:get() then
		vim.cmd("normal! g0")
	else
		vim.cmd("normal! 0")
	end
end, { desc = "Start of line", silent = true })

-- --------------------------------------- PASTING + REGISTERS -------------------------------------

-- allow changing and deleting without overriding current paste registers
-- in other words automatically delete or change to the void register
vim.keymap.set({ "n", "v" }, "D", '"_D', { noremap = true, silent = true, desc = "Delete till end of line" })
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true, silent = true, desc = "Delete" })
vim.keymap.set({ "n", "v" }, "C", '"_C', { noremap = true, silent = true, desc = "Change till end of line" })
vim.keymap.set({ "n", "v" }, "c", '"_c', { noremap = true, silent = true, desc = "Change" })
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true, silent = true, desc = "Delete under cursor" })
vim.keymap.set("v", "p", '"_dp', { noremap = true, silent = true, desc = "Paste" })
vim.keymap.set("n", "X", "0D", { remap = true, desc = "Clear Line", silent = true })

-- delete to register
vim.keymap.set("v", "<leader>d", '"+d', { desc = "Cut", silent = true, remap = false })
vim.keymap.set("n", "<leader>d", '"+dd', { desc = "Cut", silent = true })

-- paste from system clipboard
vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.keymap.set("c", "<C-v>", "<C-r>+")

-- select last changed/yanked text
vim.keymap.set(
	"n",
	"gV",
	'"`[" . strpart(getregtype(), 0, 1) . "`]"',
	{ expr = true, replace_keycodes = false, desc = "Visually select changed text" }
)

-- --------------------------------------- WINDOWS BUFFERS AND TABS --------------------------------

-- tab navigation
vim.keymap.set("n", "<S-h>", "<cmd>tabprev<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "<S-l>", "<cmd>tabnext<cr>", { desc = "Next Tab" })

vim.keymap.set("n", "<leader><Tab>q", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- delete all other {something} (tab, buffer, window)
vim.keymap.set("n", "<leader>wo", "<cmd>only <CR>", { silent = true, desc = "Window only" })

-- needed because I override <C-w>
vim.keymap.set("n", "<leader>wr", "<C-w>r", { silent = true, desc = "Window rotate" })
vim.keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Other Window", silent = true })

-- cd to current buffer (replace autochdir)
vim.keymap.set("n", "<leader>bl", function()
	vim.cmd([[cd %:h]])
	vim.notify(vim.fn.getcwd(), vim.log.levels.INFO, {
		title = "Buffer Locate",
	})
end, { desc = "Buffer Locate", silent = true })

-- close buffer (soft) (preserve split)
-- vim.keymap.set("n", "<leader>k", "<leader>bd", { remap = true, silent = true, desc = "Close Buffer" })

-- close buffer (not soft) (don't preserve split)
-- vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "quit", silent = true })
vim.keymap.set("n", "<leader>q", "<C-W>c", { desc = "quit", silent = true })

-- splits
-- vim.keymap.set("n", "\\", "<cmd>vsplit<cr>", { remap = true, silent = true, desc = "Vertical Split" })
vim.keymap.set("n", "|", "<cmd>vsplit<cr>", { remap = true, silent = true, desc = "Vertical Split" })
vim.keymap.set("n", "_", "<cmd>split<cr>", { remap = true, silent = true, desc = "Vertical Split" })

-- window resizing (<C-up> and <C-down> are used by multicursor)
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })

vim.keymap.set("n", "<leader>bo", ":%bd|e#<cr>", { desc = "Buffer Only", silent = true })

-- --------------------------------- OS SPECIFIC KEYMAPS -------------------------------------------

-- these are used because LWin+j, k, h, and l are mapped to the arrow keys and
-- LWin+u and d are mapped to page up and page down (via autohotkey)
if vim.fn.has("wsl") or vim.fn.has("win32") then
	vim.keymap.set("n", "<leader>os", "<cmd>silent !wsl-open %<cr>", { silent = true, desc = "Open in System Viewer" })
	-- vim.keymap.set({ "n", "v" }, "<Up>", "<M-k>", { remap = true, silent = true })
	-- vim.keymap.set({ "n", "v" }, "<Down>", "<M-j>", { remap = true, silent = true })
	vim.keymap.set("n", "<PageUp>", "<C-u>zz", { silent = true })
	vim.keymap.set("n", "<PageDown>", "<C-d>zz", { silent = true })
elseif vim.fn.has("mac") then
	-- vim.notify("Keymaps not set, MacOS detected")
	vim.keymap.set("n", "<leader>os", "<cmd>!open %<cr>", { silent = true, desc = "Open in System Viewer" })
end

-- --------------------------------- TAB RELATED STUFF --------------------------------------------

-- vim.keymap.set("n", "<C-Tab>", "<cmd>tabnext<cr>", { silent = true, desc = "Next Tab" })
-- vim.keymap.set("n", "<C-S-Tab>", "<cmd>tabprev<cr>", { silent = true, desc = "Previous Tab" })

vim.keymap.set("n", "<C-Tab>", "<C-i>zz", { remap = false, silent = true, desc = "Prev Jumplist" })

vim.keymap.set("n", "<C-space>", "<cmd>$tabnew<cr>")
vim.keymap.set("n", "<leader>1", "<cmd>tabn 1<cr>", { silent = true, desc = "Tab 1" })
vim.keymap.set("n", "<leader>2", "<cmd>tabn 2<cr>", { silent = true, desc = "Tab 2" })
vim.keymap.set("n", "<leader>3", "<cmd>tabn 3<cr>", { silent = true, desc = "Tab 3" })
vim.keymap.set("n", "<leader>4", "<cmd>tabn 4<cr>", { silent = true, desc = "Tab 4" })
vim.keymap.set("n", "<leader>5", "<cmd>tabn 5<cr>", { silent = true, desc = "Tab 5" })

-- --------------------------------- INSERT MODE + COMPLETION -------------------------------------

-- completion cycling in command mode
vim.keymap.set("c", "<C-j>", "<C-n>", { remap = true, desc = "Cycle through completion items" })
vim.keymap.set("c", "<C-k>", "<C-p>", { remap = true, desc = "Cycle through completion items" })

-- in insert mode auto-correct the last misspelled word
vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "Auto Correct", silent = true })
vim.keymap.set("i", "<C-Del>", "<C-o>de") -- traditional functionality of <C-delete>
vim.keymap.set("i", "<M-BS>", "<C-u>", { desc = "Clear Line" })
vim.keymap.set("n", "<M-BS>", "<NOP>", { desc = "Clear Line" })
vim.keymap.set("i", "<S-CR>", "<esc>o", { remap = false })

-- backspace to clear snippets
vim.keymap.set("s", "<BS>", "<C-O>c", { remap = true })

-- --------------------------------- PLUGIN SPECIFIC KEYMAPS ---------------------------------------

-- zb but respect scrollEOF plugin
vim.keymap.set("n", "zb", "zbkj", { silent = true, desc = "Bottom line" })

-- git blame
vim.keymap.set("n", "gb", "<leader>ghb", { remap = true, silent = true, desc = "Blame Line" })
vim.keymap.set("n", "gp", "<leader>ghp", { remap = true, silent = true, desc = "Blame Line" })

-- unholy non-native vim keymap for find in buffer
vim.keymap.set("n", "<C-f>", function()
	require("telescope.builtin").current_buffer_fuzzy_find(
		require("telescope.themes").get_dropdown({ winblend = 0, previewer = false })
	)
end, { desc = "find word" })

vim.keymap.set("n", "gp", "<leader>ghp>", { remap = true, desc = "git preview" })

vim.keymap.set(
	"x",
	"'",
	[[:s/\%V\(.*\)\%V/'\1'/ <CR><cmd>noh<cr>]],
	{ desc = "Surround selection with '", silent = true }
)
vim.keymap.set(
	"x",
	'"',
	[[:s/\%V\(.*\)\%V/"\1"/ <CR><cmd>noh<cr>]],
	{ desc = 'Surround selection with "', silent = true }
)
vim.keymap.set(
	"x",
	"*",
	[[:s/\%V\(.*\)\%V/*\1*/ <CR><cmd>noh<cr>]],
	{ desc = "Surround selection with *", silent = true }
)
vim.keymap.set(
	"x",
	"_",
	[[:s/\%V\(.*\)\%V/_\1_/ <CR><cmd>noh<cr>]],
	{ desc = "Surround selection with *", silent = true }
)
vim.keymap.set(
	"x",
	"q",
	[[:s/\%V\(.*\)\%V/"\1"/ <CR><cmd>noh<cr>]],
	{ desc = "Surround selection with *", silent = true }
)

-- vim.keymap.set("n", "<leader>s*", [[:s/\<<C-r><C-w>\>/*<C-r><C-w>\*/ <CR>]], { desc = "Surround word with *" })
-- vim.keymap.set("n", '<leader>s"', [[:s/\<<C-r><C-w>\>/"<C-r><C-w>\"/ <CR>]], { desc = 'Surround word with "' })
-- vim.keymap.set("n", "<leader>s'", [[:s/\<<C-r><C-w>\>/'<C-r><C-w>\'/ <CR>]], { desc = "Surround word with '" })

-- ------------------------------------- PERMISSIONS -----------------------------------------------

-- Force save as sudo (for readonly files)
vim.keymap.set("n", "<leader>W", "<cmd>w !sudo tee %<cr>", { desc = "Force Save File", noremap = true, silent = true })

-- grant permissions
vim.keymap.set("n", "<leader>X", "<Cmd>!sudo chmod +x %<CR>", { silent = true, desc = "Grant File Permissions" })

-- --------------------------------- TERMINAL KEYMAPS-----------------------------------------------

-- clear terminal (overriding <C-l> for window navigation)
vim.keymap.set("t", "<C-l>", "<C-l>", { noremap = true })

-- restore original terminal keymap behavior
vim.keymap.set("t", "<C-k>", "<C-k>", { noremap = true })
vim.keymap.set("t", "<C-j>", "<C-j>", { noremap = true })
vim.keymap.set({ "t", "n" }, "<C-S-H>", "<cmd>wincmd h<cr>", { noremap = true })
vim.keymap.set({ "t", "n" }, "<C-S-L>", "<cmd>wincmd l<cr>", { noremap = true })
vim.keymap.set({ "t", "n" }, "<C-S-J>", "<cmd>wincmd j<cr>", { noremap = true }) -- this doesn't work
vim.keymap.set({ "t", "n" }, "<S-NL>", "<cmd>wincmd j<cr>", { noremap = true }) -- this does?
vim.keymap.set({ "t", "n" }, "<C-S-K>", "<cmd>wincmd k<cr>", { noremap = true })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true })

-- ------------------------------------- ABBREVIATIONS --------------------------------------------

-- note: these will work in every filetype
local abbrevations = {
	{ "dont", "don't" },
	{ "shouldnt", "shouldn't" },
	{ "cant", "can't" },
	{ "wont", "won't" },
	{ "wouldnt", "wouldn't" },
	{ "seperate", "separate" },
	{ "teh", "the" },
	{ "thats", "that's" },
	{ "itll", "it'll" },
}
for _, v in ipairs(abbrevations) do
	vim.cmd(string.format("iabbrev %s %s", v[1], v[2]))
end

vim.cmd("cnoreabbrev Set  set")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev WQ wq")

vim.api.nvim_create_user_command("W", "w", { nargs = 0 })
vim.api.nvim_create_user_command("E", "e", { nargs = 0 })
vim.api.nvim_create_user_command("Q", "qa", { nargs = 0 })
vim.api.nvim_create_user_command("Wq", "wq", { nargs = 0 })
vim.api.nvim_create_user_command("WQ", "wq", { nargs = 0 })

-- ------------------------------------- MISC KEYMAPS ----------------------------------------------

-- apply macro over selected region
vim.keymap.set("x", "Q", ":norm @q<cr>", { desc = "Play Q Macro", silent = true })

-- replace all instances of word (without LSP)
vim.keymap.set(
	"n",
	"<leader>ci",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace instances" }
)

vim.keymap.set(
	"n",
	"<leader>cI",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]],
	{ desc = "Replace instances with confirmation" }
)

-- : (easier to hit when using in combination with <C-k>)
vim.keymap.set({ "n", "v" }, "<C-;>", ":", { remap = true, silent = false, desc = "Commmand Mode" })
vim.keymap.set({ "n", "v" }, "<C-x>", ":", { remap = true, silent = false, desc = "Commmand Mode" }) -- NOTE; this (in alacritty) is <C-;>

-- increment and decrement with plus and minus (since I override <C-a>)
vim.keymap.set({ "n", "v" }, "+", "<C-a>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "-", "<C-x>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })

-- follow links better
vim.keymap.set("n", "gx", "<cmd>sil !open <cWORD><cr>", { silent = true, desc = "Follow Link" })

-- Use ` to fold when in normal mode
-- To see help about folds use `:help fold`
vim.keymap.set({ "n", "v" }, "`", function()
	-- Get the current line number
	local line = vim.fn.line(".")
	-- Get the fold level of the current line
	local foldlevel = vim.fn.foldlevel(line)
	if foldlevel == 0 then
		vim.notify("No fold found", vim.log.levels.INFO)
	else
		vim.cmd("normal! za")
	end
end, { desc = "Toggle fold" })

-- toggling comments
vim.keymap.set({ "n", "i" }, "<C-/>", "<cmd>normal gcc<CR>", { desc = "[/] Toggle comment line", silent = true })
vim.keymap.set("v", "<C-/>", "<cmd>normal gcc<CR>gv", { desc = "[/] Toggle comment line", silent = true })

vim.keymap.set({ "n", "i" }, "<C-_>", "<cmd>normal gcc<CR>", { desc = "[/] Toggle comment line", silent = true })
vim.keymap.set("v", "<C-_>", "<cmd>normal gcc<CR>gv", { desc = "[/] Toggle comment line", silent = true })

-- clean ^Ms (windows newlines)
vim.keymap.set("n", "<C-S-S>", function()
	vim.cmd([[silent! %s/\r//g]])
	vim.cmd([[w]])
	vim.notify("Cleaned all newline characters!", vim.log.levels.INFO, { title = "File Saved" })
end, { remap = false, desc = "Clean ^M", silent = true })

-- get word count of current file
vim.keymap.set("n", "<C-S-C>", function()
	vim.notify("" .. vim.fn.wordcount().words, vim.log.levels.INFO, {
		title = "Word Count",
	})
end)

vim.keymap.set("n", "<leader>a", "<cmd>=require('neocodeium').visible()<cr>", { silent = false, desc = "AI Active" })
vim.keymap.set("i", "<C-S-A>", "<cmd>=require('neocodeium').visible()<cr>", { silent = false, desc = "AI Active" })

-- z=
local spell_on_choice = vim.schedule_wrap(function(_, idx)
	if type(idx) == "number" then
		vim.cmd.normal({ idx .. "z=", bang = true })
	end
end)
local spell_select = function()
	if vim.v.count > 0 then
		spell_on_choice(nil, vim.v.count)
		return
	end
	local cword = vim.fn.expand("<cword>")
	vim.ui.select(vim.fn.spellsuggest(cword, vim.o.lines), { prompt = "Change " .. cword .. " to:" }, spell_on_choice)
end
vim.keymap.set("n", "z=", spell_select, { desc = "Show spelling suggestions" })

-- Map Escape in all visual modes to return to normal mode
vim.api.nvim_set_keymap("x", "<Esc>", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Esc>", "<Esc>", { noremap = true, silent = true })

local opt = vim.opt
opt.clipboard = "unnamedplus" -- sync with system clipboard
opt.mouse = "a" -- disable mouse
opt.conceallevel = 2 -- Hide * markup for bold and italics
opt.autowrite = true -- Enable auto writes
opt.cursorline = true -- don't highlight current line (transparent background)
opt.cursorlineopt = "number,screenline" -- cursorline respects wrapped lines
opt.rnu = true -- relative line numbers
opt.splitbelow = true -- self explanatory
opt.splitright = true -- self explanatory
opt.swapfile = false -- don't make backup swap files
opt.incsearch = true -- who knows
opt.scrolloff = 15 -- don't scroll all the way down
opt.sidescrolloff = 0 -- don't scroll all the way to the side
opt.sidescroll = 0 -- don't scroll all the way to the side
opt.numberwidth = 1 -- left side width
opt.textwidth = 80 -- formatted text width
opt.softtabstop = 2 -- 2 space tabs
opt.tabstop = 2 -- 2 space tabs
opt.shiftwidth = 2 -- 2 space tabs
opt.pumblend = 0 -- needed for cmp transparency
opt.smartindent = true -- indent smartly
opt.startofline = true
opt.breakindent = true -- indent smartly
opt.smartcase = true -- casing in search
opt.ignorecase = true -- casing in search
opt.spelllang = "en" -- spell in english pls
opt.scroll = 15
opt.showtabline = 0
vim.g.loaded_ruby_provider = 0 -- never use these
vim.g.loaded_perl_provider = 0 -- never use these
vim.g.loaded_python3_provider = 0
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.lazyvim_python_lsp = "pyright"

vim.cmd([[
set complete=
set completeopt=
]])

-- remove all trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		pcall(function()
			vim.cmd([[%s/\s\+$//e]])
		end)
		vim.fn.setpos(".", save_cursor)
	end,
})

-- always enter normal mode when leaving telescope prompt
vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
	pattern = { "TelescopePrompt" },
	callback = function()
		vim.api.nvim_exec2("silent! stopinsert!", {})
	end,
})

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	callback = function()
		if vim.w.auto_cursorline then
			vim.wo.cursorline = true
			vim.w.auto_cursorline = nil
		end
	end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	callback = function()
		if vim.wo.cursorline then
			vim.w.auto_cursorline = true
			vim.wo.cursorline = false
		end
	end,
})

-- don't conceal my hour log table
vim.api.nvim_create_autocmd({ "BufRead", "FileType" }, {
	pattern = "Mentorship-Hour-Log.md",
	command = "setlocal conceallevel=0 textwidth=0",
})

-- don't use lsp on pvs files
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	callback = function(opt)
		if vim.fn.expand("%:e") == "pvs" then
			vim.schedule(function()
				vim.lsp.buf_detach_client(opt.buf, opt.data.client_id)
			end)
		end
	end,
})

-- hacky way to get colored pvs
vim.api.nvim_create_autocmd({ "FileType", "BufRead" }, {
	pattern = { "*.pvs" },
	command = "set ft=c",
})

-- for coldfusion syntax highlighting
vim.api.nvim_create_autocmd({ "FileType", "BufRead" }, {
	pattern = { "*.cf", "*.cfm" },
	command = "set syntax=cf filetype=cf",
})

vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "wrap",
	callback = function()
		if vim.opt.wrap:get() then
			vim.cmd("setlocal tw=0")
		else
			vim.cmd("setlocal tw=80")
		end
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.opt.wrap:get() then
			vim.cmd("setlocal tw=0")
		else
			vim.cmd("setlocal tw=80")
		end
	end,
})

-- Create an autogroup for markdown-specific settings
vim.api.nvim_create_augroup("MarkdownConceal", { clear = true })

-- Use ModeChanged to toggle conceallevel based on mode transitions
vim.api.nvim_create_autocmd("ModeChanged", {
	group = "MarkdownConceal",
	pattern = "*:i", -- Entering insert mode
	callback = function()
		if vim.bo.filetype == "markdown" then
			vim.opt_local.conceallevel = 0
		end
	end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
	group = "MarkdownConceal",
	pattern = "i:*", -- Leaving insert mode
	callback = function()
		if vim.bo.filetype == "markdown" then
			vim.opt_local.conceallevel = 2
		end
	end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
	group = "MarkdownConceal",
	pattern = "*:[vV\x16]", -- Entering visual, visual line, or visual block mode
	callback = function()
		if vim.bo.filetype == "markdown" then
			vim.opt_local.conceallevel = 0
		end
	end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
	group = "MarkdownConceal",
	pattern = "[vV\x16]:*", -- Leaving visual, visual line, or visual block mode
	callback = function()
		if vim.bo.filetype == "markdown" then
			vim.opt_local.conceallevel = 2
		end
	end,
})
