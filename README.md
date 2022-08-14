
> Supports plugins such as [NERDTree](https://github.com/preservim/nerdtree), [vim-airline](https://github.com/vim-airline/vim-airline), [CtrlP](https://github.com/ctrlpvim/ctrlp.vim), [powerline](https://github.com/powerline/powerline), [denite](https://github.com/Shougo/denite.nvim), [unite](https://github.com/Shougo/unite.vim), [lightline.vim](https://github.com/itchyny/lightline.vim), [vim-startify](https://github.com/mhinz/vim-startify), [vimfiler](https://github.com/Shougo/vimfiler.vim), [vim-buffet](https://github.com/bagrat/vim-buffet) and [flagship](https://github.com/tpope/vim-flagship).


Features
--------

- Adds filetype glyphs (icons) to various vim plugins.
- Customizable and extendable glyphs settings.
- Supports a wide range of file type extensions.
- Supports popular full filenames, like `.gitignore`, `node_modules`, `.vimrc`, and many more.
- Supports `byte order marker (BOM)`.
- Works with patched fonts, especially [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts).

> See [Detailed Features](https://github.com/ryanoasis/vim-devicons/wiki/Detailed-Features) for more.

> See [Configuration](https://github.com/ryanoasis/vim-devicons/wiki/Extra-Configuration) for a list of configuration and customization options.

Installation
------------

1. Install a [Nerd Font compatible font](https://github.com/ryanoasis/nerd-fonts#font-installation) or [patch your own](https://github.com/ryanoasis/nerd-fonts#font-patcher). Then set your terminal font (or `guifont` if you are using GUI version of Vim).
1. Install the Vim plugin with your favorite plugin manager, e.g. [vim-plug](https://github.com/junegunn/vim-plug):

    ```vim
    Plug 'ryanoasis/vim-devicons'
    ```

    > Always load the vim-devicons as the very last one.

1. Configure Vim

    ```vim
    set encoding=UTF-8
    ```

	> No need to set explicitly under Neovim: always uses UTF-8 as the default encoding.


> See [Installation](https://github.com/ryanoasis/vim-devicons/wiki/Installation) for detailed setup instructions

Use `:help devicons` for further configuration.

Developers
----------

See [DEVELOPER](DEVELOPER.md) for how to use the API.

Troubleshooting
---------------

See [FAQ](https://github.com/ryanoasis/vim-devicons/wiki/FAQ-&-Troubleshooting).

Contributing
------------

### [Code of Conduct](CODE_OF_CONDUCT.md)

This project has adopted a Code of Conduct that we expect project participants to adhere to. Check out [code of conduct](CODE_OF_CONDUCT.md) for further details.

### [Contributing Guide](CONTRIBUTING.md)

Read our [contributing](CONTRIBUTING.md) guide to learn about how to send pull requests, creating issues properly.

### Promotion

You can help us by simply giving a star or voting on vim.org. It will ensure continued development going forward.

- Star this repository [on GitHub](https://github.com/ryanoasis/vim-devicons).
- Vote for it [on vim.org](http://www.vim.org/scripts/script.php?script_id=5114).

Acknowledgments
---------------

Thanks goes to these people for inspiration and helping with sending PRs.

- [vim-airline](https://github.com/vim-airline/vim-airline)
- [nerdtree](https://github.com/preservim/nerdtree)
- [nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin) by [@Xuyuanp](https://github.com/Xuyuanp)
- [seti-ui](https://atom.io/themes/seti-ui) by [@jesseweed](https://github.com/jesseweed)
- [devicons](http://vorillaz.github.io/devicons) by [@vorillaz](https://github.com/vorillaz)
- [development.svg.icons](https://github.com/benatespina/development.svg.icons) by [@benatespina](https://github.com/benatespina)
- [Learn Vimscript the Hard Way](http://learnvimscriptthehardway.stevelosh.com/) book by [Steve Losh](http://stevelosh.com/)
- All [contributors](https://github.com/ryanoasis/vim-devicons/graphs/contributors)

License
-------

[MIT](LICENSE)
