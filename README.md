# cmp-comment

`cmp-comment` is a custom source plugin for [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) that provides completion suggestions for comments in Neovim.

## Features
- Suggests predefined phrases for comments, such as `TODO:`, `FIXME:`, and more.
- Uses Tree-sitter to detect if the cursor is inside a comment.

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim):
```lua
{
  'walkingshamrock/cmp-comment',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'hrsh7th/nvim-cmp',
  },
  config = function()
    require('cmp').setup {
      sources = {
        { name = 'comment' },
      },
    }
  end
}
```

## Usage
- Place the cursor inside a comment and trigger completion (e.g., `<C-Space>`).
- Suggestions will appear based on predefined phrases.

## Configuration

You can customize the suggestions provided by `cmp-comment` by calling the `setup` function in your Neovim configuration. For example:

```lua
require("cmp_comment").setup({
  suggestions = {
    "Custom TODO: ",
    "Custom FIXME: ",
    "Custom NOTE: ",
  }
})
```

If no custom suggestions are provided, the plugin will use its default suggestions.

## Requirements
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
