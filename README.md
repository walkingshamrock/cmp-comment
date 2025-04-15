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

## Requirements
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
