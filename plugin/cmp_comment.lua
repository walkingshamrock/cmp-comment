vim.schedule(function()
  local ok, cmp = pcall(require, "cmp")
  if ok then
    -- Debug log to verify source registration
    vim.notify("Registering cmp_comment source", vim.log.levels.INFO)
    cmp.register_source("comment", require("cmp_comment"))
  else
    -- Debug log if cmp is not available
    vim.notify("nvim-cmp not found", vim.log.levels.WARN)
  end
end)
