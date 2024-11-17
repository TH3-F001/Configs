local port = os.getenv("GDScript_Port") or "6005"
local address = "127.0.0.1"
local pipe = "/path/to/godot.pipe" -- I use /tmp/godot.pipe

-- Check if the port is already in use
local handle = io.popen("nc -zv " .. address .. " " .. port .. " 2>&1")
local result = handle:read("*a")
handle:close()

if not result:match("succeeded") then
  local cmd = vim.lsp.rpc.connect(address, port)

  vim.lsp.start({
    name = "Godot",
    cmd = cmd,
    root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
    on_attach = function(client, bufnr)
      vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
    end,
  })
else
  print("LSP server is already running on " .. address .. ":" .. port)
end
