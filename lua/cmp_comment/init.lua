local cmp = require('cmp')
local context = require('cmp.config.context')
local ts_utils = require('nvim-treesitter.ts_utils')

local source = {}

-- Determine if the source is available in the current context
function source:is_available()
  -- Check if the cursor is in a generic comment using pattern matching
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1 -- Convert to 0-based index
  local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
  if line and line:sub(1, col):match("^%s*[#/%-%*]+") then
    return true
  end

  -- Check if Treesitter is available for the current buffer
  if not pcall(require, 'nvim-treesitter.ts_utils') then
    return false
  end

  -- Traverse the syntax tree to check if the cursor is in a comment node
  local node = ts_utils.get_node_at_cursor()
  local comment_types = {"comment", "line_comment", "block_comment", "doc_comment"}
  while node do
    if vim.tbl_contains(comment_types, node:type()) then
      return true
    end
    node = node:parent()
  end

  -- Use cmp.config.context to check if the cursor is in a comment syntax group
  return context.in_syntax_group('Comment') or context.in_treesitter_capture('comment')
end

-- Get the keyword pattern for triggering completion
function source:get_keyword_pattern()
  return [[\k*]]
end

-- Get the trigger characters for the source
function source:get_trigger_characters()
  return {"#", "--", "//", "/*"}
end

-- Register the source with cmp.nvim
cmp.register_source('comment', source)

-- Setup function for the plugin
local M = {}
function M.setup(config)
  M.config = config or {}
  M.suggestions = M.config.suggestions or {
    "TODO: ",
    "FIXME: ",
    "NOTE: ",
    "This function handles ",
    "Returns ",
    "Checks whether ",
    "Initializes ",
    "Cleans up ",
  }

  -- Update the complete function to include suggestions
  function source:complete(params, callback)
    local items = {}

    -- Add suggestions from the configuration or defaults
    for _, suggestion in ipairs(M.suggestions) do
      table.insert(items, {
        label = suggestion,
        kind = cmp.lsp.CompletionItemKind.Text,
      })
    end

    -- Add comments from the buffer
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
      local comment = line:match("%s*[%-%-%#//]+%s*(.+)")
      if comment then
        table.insert(items, {
          label = comment,
          kind = cmp.lsp.CompletionItemKind.Text,
        })
      end
    end

    callback({ items = items })
  end
end

return M