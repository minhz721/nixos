local ok_ctx, context = pcall(require, "treesitter-context")
if ok_ctx then
	context.setup({ max_lines = 3, trim_scope = "outer" })
end

local ok_bar, dropbar = pcall(require, "dropbar")
if ok_bar then
	dropbar.setup({})
end
