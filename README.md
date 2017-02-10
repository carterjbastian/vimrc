# Carter J. Bastian's .vimrc

Commands to configure vim. Depends on [fugitive.vim](https://github.com/tpope/vim-fugitive), [pathogen](https://github.com/tpope/vim-pathogen), and [pymode](https://github.com/python-mode/python-mode). Thanks to @wchargin for letting me use his .vimrc as a jumping off point. Still a work in progress.

## How to Use
If you're new to vim and thinking of copy-pasting this as your .vimrc, I would recommend against it. Even with the dependencies installed, not everything will work for you out of the box. It's probably a better idea just to read through it, see how things are done, and copy over ideas that you like with your own implementation.

If you're not new to vim, do whatever you want.

## Roadmap
* Plugins
* Basic Settings
* Key re-mappings
* Tab and Window Mappings
* Leader-key mappings
* Custom Operations (Control-key mappings)
    * Insert Mode
    * Normal Mode
    * Visual Mode
* Smaller Customization (Meta-key mappings)
* Filetype dependent autocommands
    * .vimrc setup
    * Python customizations
    * Bash Customizations
    * C Customizations
* Abbreviations and textual shortcuts

## Notes and TODOs
The Filetype dependent customizations are somewhat inefficient in terms of code duplication. Right now, there is a preprocessing, postprocessing, and customization function for each filetype. Because I'm only customizing a couple filetypes, this isn't _too_ unruly, but as this is added to in the future, the preprocessing, postprocessing, and customization functions for each filetypes may be combined into a larger functions which parse for a filetype.

I have default templates in `.vim/templates`. I sometimes toggle between [monokai-vim](https://github.com/sickill/vim-monokai) and the default colorscheme.
