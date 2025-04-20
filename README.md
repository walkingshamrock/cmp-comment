# cmp-comment

`cmp-comment` is a custom source plugin for [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) that provides completion suggestions for comments in Neovim.

Thank you for considering supporting this project! Your generosity helps keep development active and ensures the plugin continues to improve.

[![Buy Me A Coffee](https://img.shields.io/badge/-Buy%20me%20a%20coffee-yellow?style=for-the-badge&logo=buy-me-a-coffee&logoColor=white)](https://www.buymeacoffee.com/walkingshamrock)

## Features
- Suggests predefined phrases for comments, such as `TODO:`, `FIXME:`, and more.
- Uses Tree-sitter to detect if the cursor is inside a comment.

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)
Add the following to your Neovim configuration:

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
1. Place the cursor inside a comment.
2. Trigger completion (e.g., `<C-Space>`).
3. Suggestions will appear based on predefined phrases.

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

## Contributing
Contributions are welcome! If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request on the [GitHub repository](https://github.com/walkingshamrock/cmp-comment).

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
