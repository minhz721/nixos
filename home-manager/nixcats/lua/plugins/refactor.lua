local map = vim.keymap.set

local ok_inc, inc = pcall(require, "inc_rename")
if ok_inc then
	inc.setup({})
end

local function grug(fn)
	return function()
		local ok, grug_far = pcall(require, "grug-far")
		if not ok then
			vim.notify("grug-far.nvim is not installed", vim.log.levels.WARN)
			return
		end
		fn(grug_far)
	end
end

map(
	"n",
	"<leader>sr",
	grug(function(g)
		g.open({ prefills = { search = vim.fn.expand("<cword>") } })
	end),
	{ desc = "Search & replace (project)" }
)

map(
	"n",
	"<leader>sR",
	grug(function(g)
		g.open({ prefills = { paths = vim.fn.expand("%") } })
	end),
	{ desc = "Search & replace (current file)" }
)

map(
	"x",
	"<leader>sr",
	grug(function(g)
		g.with_visual_selection()
	end),
	{ desc = "Search & replace selection" }
)

map({ "n", "x" }, "<leader>cr", function()
	local ok, refactoring = pcall(require, "refactoring")
	if ok then
		refactoring.select_refactor()
	else
		vim.notify("refactoring.nvim is not installed", vim.log.levels.WARN)
	end
end, { desc = "Refactor..." })
