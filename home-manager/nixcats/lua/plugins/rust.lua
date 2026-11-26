vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function(args)
		if vim.fn.exists(":RustLsp") ~= 2 then
			return
		end
		local function m(lhs, sub, desc)
			vim.keymap.set("n", lhs, function()
				vim.cmd.RustLsp({ sub })
			end, { buffer = args.buf, desc = desc })
		end
		m("<leader>Rr", "runnables", "Rust: runnables")
		m("<leader>Rt", "testables", "Rust: testables")
		m("<leader>Rm", "expandMacro", "Rust: expand macro")
		m("<leader>Re", "explainError", "Rust: explain error")
		m("<leader>Rc", "openCargo", "Rust: open Cargo.toml")
		m("<leader>Rp", "parentModule", "Rust: parent module")
		m("<leader>Rj", "joinLines", "Rust: join lines")
	end,
})

vim.api.nvim_create_autocmd("BufRead", {
	pattern = "Cargo.toml",
	once = true,
	callback = function()
		local ok, crates = pcall(require, "crates")
		if ok then
			crates.setup({
				lsp = { enabled = true, actions = true, completion = true, hover = true },
			})
		end
	end,
})
