# vim-zargs

Vim's [arg-list](http://vimcasts.org/episodes/meet-the-arglist/) can be a very useful feature when working on tasks that deal with several related files.

Once the arg-list is populated you can perform operations such as:
* `vimgrep mySearch ##`
* Cycle through the files with [unimpaired](https://github.com/tpope/vim-unimpaired)'s `[a` and `]a` mappings

Rather than re-populating the arg-list every time Vim is opened with commands like `args path/to/*Something*.js`, zargs provides support for persisting arg-lists in files in the `vim-zargs/zargs` directory.

## Invocation
* `Zargs` - Open up the "zargs" directory in netrw
* `Zargs "%"` - Populate the arg-list from the current buffer
* `Zargs "foo"` - Populate the arg-list from the "foo" file in `vim-zargs/zargs`

The `zp` mapping is provided which will print out the full path to the current buffer.

The `Zargs` command will tab-complete with the files in `vim-zargs/zargs`.

## Suggested workflow
* Start a new task which involves several related files
* `:Zargs` and then create or open a file
* Place absolute paths (`zp` can help) in file
* Load zargs file into arg-list with `Zargs` command

## License
Same terms as Vim itself
