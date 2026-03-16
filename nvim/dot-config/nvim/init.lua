-- Function to dynamically find the latest NVM node version
local function get_nvm_node_path()
	local nvm_dir = vim.fn.expand("~/.nvm/versions/node/")
	if vim.fn.isdirectory(nvm_dir) == 0 then
		return nil
	end

	-- Get all directories starting with 'v' inside the nvm folder
	local versions = vim.fn.globpath(nvm_dir, "v*", false, true)
	if #versions == 0 then
		return nil
	end

	-- Sort versions (v24 will be higher than v22)
	table.sort(versions)

	-- The last item in the table is the highest version
	local latest_version = versions[#versions]
	return latest_version .. "/bin"
end

-- Inject the path into Neovim's environment
local nvm_bin = get_nvm_node_path()
if nvm_bin then
	vim.env.PATH = nvm_bin .. ":" .. vim.env.PATH
end

require("core.set_vim")

require("core.lazy")

require("core.autocmd")

require("configs.catppuccin")

require("core.key_map")

-- Load the floating termina
require("ui.floating_terminal")

-- require("core.cursor")
