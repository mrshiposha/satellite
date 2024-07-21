local mappings = {}
function mappings:new(info)
	if not info.description then error("mapping must have `description`") end

	local valid_modes = {
		normal = true,
		visual = true,
		insert = true,
		command = true,
		terminal = true
	}

	local mode_capture = "#(%a+)#"

	local function map_error(msg)
		error("mapping '" .. info.description .. "': " .. msg)
	end

	local mode_deps = {}
	local expanded_modes = {}

	local function check_and_mark_dep(mode, dep)
		if not valid_modes[dep] then
			map_error(string.format("invalid mode dependency `%s`", dep))
		end

		if mode == dep then
			map_error(string.format("recursive dependency for `%s`", mode))
		end

		if mode_deps[dep] and mode_deps[dep][mode] then
			map_error(string.format("circular dependency `%s` <-> `%s`", mode, dep))
		end

		if not mode_deps[mode] then mode_deps[mode] = {} end

		mode_deps[mode][dep] = true
	end

	local function init_mode(mode, mapping)
		if not valid_modes[mode] then
			map_error(string.format("invalid mode `%s`", mode))
		end

		if type(mapping) == "string" then info.modes[mode] = {} end
	end

	local function dep_mapping(mode, mapping)
		local src_mapping
		local src_transform
		if type(mapping) == "string" then
			local _, _, before, dep, after = string.find(mapping,
			                                             "^(.-)" .. mode_capture ..
							                                             "(.-)$")

			if dep then
				check_and_mark_dep(mode, dep)
			else
				map_error("no dependency found")
			end

			local dep_transform
			src_mapping, dep_transform = dep_mapping(dep, info.modes[dep])
			src_transform = function(m)
				-- print("src_transform: ", mode, mapping, m, dep_transform)
				local transformed_dep = dep_transform(m)
				return before .. transformed_dep .. after
			end

			-- print(mode, mapping, src_mapping, src_transform, dep, dep_transform)
			return src_mapping, src_transform

		elseif type(mapping) == "table" then
			src_mapping = mapping
			src_transform = function(m)
				-- print("mapping: "..m)
				return m
			end

			-- print(mode, mapping, src_mapping, src_transform)
			return src_mapping, src_transform
		end
	end

	local function expand_mode(mode, mapping)
		if expanded_modes[mode] then return info.modes[mode] end

		init_mode(mode, mapping)

		local src_mapping, src_transform = dep_mapping(mode, mapping)

		for old, new in pairs(src_mapping) do
			if type(new) == "string" then
				local expanded_mapping = string.gsub(new, mode_capture, function(dep)
					check_and_mark_dep(mode, dep)

					-- print(info.description, mode, old, new, info.modes[dep][old])
					return expand_mode(dep, info.modes[dep])[old];
				end)

				-- print(info.description, mode, old, expanded_mapping)

				info.modes[mode][old] = src_transform(expanded_mapping)
			elseif type(new) == "function" then
				info.modes[mode][old] = new
			end
		end

		expanded_modes[mode] = true
		return info.modes[mode]
	end

	for mode, mapping in pairs(info.modes) do expand_mode(mode, mapping) end

	table.insert(self, info)
	return info
end

function mappings:apply()
	for _, info in ipairs(self) do
		local options = info.options or {silent = true}
		options.desc = info.description

		for mode, mode_mappings in pairs(info.modes) do
			for old, new in pairs(mode_mappings) do
				local short_name = mode:sub(1, 1)
				vim.keymap.set({short_name}, old, new, options)
			end
		end
	end
end

return {
	list_tab_wins = function()
		local wins = {}
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			local buf = vim.api.nvim_win_get_buf(win)
			table.insert(wins, {buf = buf, id = win})
		end

		return wins
	end,

	mappings = mappings,

	shutdown_lsp = function ()
		local active_clients = vim.lsp.get_active_clients()

		for _, client in ipairs(active_clients) do
			vim.lsp.stop_client(client.id)
		end

		pcall(vim.api.nvim_del_augroup_by_name, "lspconfig")
	end,
}

