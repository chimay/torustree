<!-- vim: set filetype=markdown: -->

<!-- vim-markdown-toc GFM -->

* [Introduction](#introduction)
  * [What is it ?](#what-is-it-)
  * [What does it look like ?](#what-does-it-look-like-)
    * [History and meta-command](#history-and-meta-command)
    * [Frecency, dedicated buffers and layers](#frecency-dedicated-buffers-and-layers)
    * [More screenshots & screencasts](#more-screenshots--screencasts)
  * [File groups & categories](#file-groups--categories)
    * [Why do you need three levels of grouping ?](#why-do-you-need-three-levels-of-grouping-)
    * [A torustree that follows you](#a-torustree-that-follows-you)
  * [Features](#features)
  * [History](#history)
  * [Prerequisites](#prerequisites)
    * [Software](#software)
    * [Operating system](#operating-system)
* [Installation](#installation)
  * [Using vim-packager](#using-vim-packager)
  * [Using minpac](#using-minpac)
  * [Using vim-plug](#using-vim-plug)
  * [Cloning the repo in a pack-start directory](#cloning-the-repo-in-a-pack-start-directory)
* [Documentation](#documentation)
  * [Vim help](#vim-help)
  * [Wiki](#wiki)
  * [In torustree menu](#in-torustree-menu)
* [Configuration](#configuration)
  * [Wiki](#wiki-1)
  * [Example](#example)
* [Meta-command](#meta-command)
* [Bindings](#bindings)
  * [Frequently used functions](#frequently-used-functions)
* [Examples](#examples)
  * [Display matching files in splits](#display-matching-files-in-splits)
  * [More](#more)
* [Warning](#warning)

<!-- vim-markdown-toc -->

# Introduction
## What is it ?

The goal is to generalize the torustree groups and toruses to build
a virtual vim file system with locations and directories of
location/subdirs.

Torustree is a :

- file group manager
- session manager (tabs & windows)
- navigation plugin
- refactoring tool

for Vim and Neovim.

Our favorite editor has already plenty of nice navigation functions. Torustree
enhances their interface by using :

- intuitive completion with multi-pattern support for prompting functions
- dedicated buffers, in which you can filter and select elements, besides using
  the full power of your editor
- a meta-command with subcommands, actions and completion
- edit modes, that allow you to reflect your changes in a dedicated buffer to
  the original file(s)

With these tools, any line in any file is only a few keys away.

All is written in lightweight, classical Vimscript. No dependency
required.

## What does it look like ?

### History and meta-command

![History & :Torustree command completion](https://github.com/chimay/torustree-multimedia/blob/main/screenshot/history-meta-command.jpg)

### Frecency, dedicated buffers and layers

![Frecency, dedicated buffers and layers](https://github.com/chimay/torustree-multimedia/blob/main/screenshot/mandalas-and-leaves.jpg)

### More screenshots & screencasts

See the [torustree-multimedia repository](https://github.com/chimay/torustree-multimedia).

## File groups & categories

Torustree let you organize your files by creating as many file groups as
you need, add the files you want to it and quickly navigate between :

- files of the same group
- file groups

Note that :

- a location contains a name, a filename, as well as a line & column number
- a file group, in fact a location group, is called a circle
- a set of file groups, or a category, is called a torus (a circle of circles)
- the list of toruses is called the torustree

Currently, there are more than a thousand files in my groups, and it runs like a breeze.

### Why do you need three levels of grouping ?

At first glance, managing groups with circles in a torus seems to be
sufficient. But with time, the torus grows big, and a third level helps
you to organize your files by groups and categories:

- the torustree contains all the toruses
- each torus contains a category of files, e.g.:
  + configuration, development, publication
- each circle contains a project, e.g.:
  + kitty or vifm circles in configuration torus
  + shell or vimscript in development torus
  + tea or art in publication torus

You can also organize a torus in subprojects. For instance, in the torustree
torus, I have the following groups :

  - plugin/ dir files
  - autoload/ dir files
  - doc files
  - wiki files
  - test files

### A torustree that follows you

Torustree is designed to follow your workflow : you only add the files
you want, where you want. For instance, if you have a `organize` group
with agenda & todo files, you can quickly alternate them, or display
them in two windows. Then, if you suddenly got an idea to tune vim,
you switch to the `vim` group with your favorites configuration files in
it. Same process, to cycle, alternate or display the files. Over time,
your groups will grow and adapt to your style.

## Features

The group manager is the core, but it goes far beyond that : you need a
quick navigation framework to travel in the torustree, and once it is there,
it’s easy to add new functionalities.

- add
  + files from anywhere in the filesystem
  + a file in more than one group
  + file:line-1 and file:line-2 in the same group
- may be saved in torustree file (recommended)
- on demand loading of files
  + no slowdown of (neo)vim start
- easy navigation
  + switch to matching tab & window if available
  + next / previous location, circle or torus
  + single or multi-pattern completion in prompting functions
  + choose file, group or category in dedicated buffer
    - filter candidates
    - selection tools
    - preview
    - folds matching torustree tree structure
    - context menus
  + auto `:lcd` to project root of current file
  + history of torustree files
    - anywhere
    - in same group
    - in same category
  + signs displayed at torustree locations
- search files
  + using locate
  + using find
  + MRU files not found in torustree
  + opened buffers
  + visible buffers in tabs & windows
- search inside files
  + grep on group files
    - navigate
    - edit mode : edit and propagate changes by writing the dedicated buffer
  + outline
    - folds headers in group files (based on fold markers)
    - markdown headers
    - org mode headers
  + tags
  + markers
  + jumps & changes lists
- narrow
  + current file
  + all circle file with a pattern
- yank ring using TextYankPost event
  + paste before or after, linewise or characterwise
  + switch register ring
- reorganizing
  + torustree elements
  + tabs & windows
- undo list
  + diff between last & chosen state
- command output in buffer
  + :ex or !shell command
  + async shell command
  + result can be filtered, as usual
- dedicated buffers ring to save your searches
  + layer ring in each dedicated buffer
- batch operations
- autogroup files by extension or directory
- save tabs & windows in minimal session file
- display files
  + split levels : torus, circle, location
  + split
    - vertical, golden vertical
    - horizontal, golden horizontal
    - main left, golden left
    - main top, golden top
    - grid
  + mix of above
    - circles on tabs, locations on split
    - toruses on tabs, circles on split

## History

This project is inspired by :

- [torus](https://github.com/chimay/torus), a file group plugin for Emacs,
  itself inspired by [MTorus](https://www.emacswiki.org/emacs/MTorus)

- [ctrlspace](https://github.com/vim-ctrlspace/vim-ctrlspace), a workspace
  plugin for Vim

- [unite](https://github.com/Shougo/unite.vim), a search plugin for arbitrary sources

- [quickfix-reflector](https://github.com/stefandtw/quickfix-reflector.vim),
  for the grep edit mode

- [NrrwRgn](https://github.com/chrisbra/NrrwRgn), for the narrow dedicated buffers

- [YankRing](https://github.com/vim-scripts/YankRing.vim), whose name is
  self-explanatory

## Prerequisites

### Software

- vim >= 8.2
- neovim >= 0.6

Basically, it assumes the existence of `:map-cmd` and `#{...}` syntax
for dictionaries.

If your distribution uses an older version, you can resort to appimages :

- [vim appimage](https://github.com/vim/vim-appimage)
- [neovim appimage](https://appimage.github.io/neovim/)

These are fast evolving pieces of software, it's worth upgrading anyway.

### Operating system

Some outer rim functions assume a Unix-like OS, like Linux or BSD :

- async functions
- external commands, like locate
- mirror the torustree structure in a filesystem tree

Most of the plugin should work out of the box on other OSes, however. If
you encounter some problem, please let me know.

# Installation
## Using vim-packager

Simply add this line after `packager#init()` to your initialisation file :

~~~vim
call packager#add('chimay/torustree', { 'type' : 'start' })
~~~

and run `:PackagerInstall` (see the
[vim-packager readme](https://github.com/kristijanhusak/vim-packager)).

## Using minpac

Simply add this line after `minpac#init()` to your initialisation file :

~~~vim
call minpac#add('chimay/torustree', { 'type' : 'start' })
~~~

and run `:PackUpdate` (see the
[minpac readme](https://github.com/k-takata/minpac)).

## Using vim-plug

The syntax should be similar with other git oriented plugin managers :

~~~vim
Plug 'chimay/torustree'
~~~

and run `:PlugInstall` to install.

## Cloning the repo in a pack-start directory

You can clone the repository somewhere in your `runtime-search-path`. You
can get a minimal version by asking a shallow clone (depth 1) and
filtering out the screenshots blobs :

```vim
mkdir -p ~/.local/share/nvim/site/pack/foo/start
cd ~/.local/share/nvim/site/pack/foo/start
git clone --depth 1 --filter=blob:none https://github.com/chimay/torustree
```

If you install or update with git, don't forget to run :

```vim
:helptags doc
```

to be able to use the inline help.

# Documentation
## Vim help

[Your guide](https://github.com/chimay/torustree/blob/master/doc/torustree.txt)
on the torustree tracks :

~~~vim
:help torustree.txt
~~~

## Wiki

A [torustree wiki](https://github.com/chimay/torustree/wiki) is also available.

It is recommended to read at least the
[step-by-step](https://github.com/chimay/torustree/wiki/step-by-step)
and [workflow](https://github.com/chimay/torustree/wiki/workflow)
pages, either in the wiki or in the `torustree.txt` file.

## In torustree menu

In the help submenu of the main menu (default map : `<M-w><M-m>`), you have
access to :

- the inline help (torustree.txt)
- the list of current torustree mappings
- the list of available plug mappings
- the list of :Torustree subcommands and actions
- the list of autocommands of your torustree group
- a dedicated buffer basic help
- local buffer maps

# Configuration
## Wiki

For a thorough list of options, see the
[configuration](https://github.com/chimay/torustree/wiki/configuration)
and
[autocommands](https://github.com/chimay/torustree/wiki/autocommands)
pages in the wiki.

## Example

Here is an example of configuration :

~~~vim
if ! exists("g:torustree_loaded")
  " ---- DONT FORGET TO INITIALIZE DICTS BEFORE USING THEM
  let g:torustree_config                 = {}
  let g:torustree_config.project         = {}
  let g:torustree_config.storage         = {}
  let g:torustree_config.storage.torustree   = {}
  let g:torustree_config.storage.session = {}
  let g:torustree_config.maxim           = {}
  let g:torustree_config.completion      = {}
  let g:torustree_config.frecency        = {}
  let g:torustree_config.display         = {}
  let g:torustree_config.display.sign    = {}

  " ---- The bigger it is, the more mappings available
  let g:torustree_config.mappings = 10
  " ---- Prefix for mappings
  " ---- Other ideas : '<space>', '<D-w>'
  let g:torustree_config.prefix = '<M-w>'
  " ---- Locate database ; default one if left empty
  let g:torustree_config.locate_db = '~/index/locate/home.db'
  " ---- Grep command : :grep or :vimpgrep
  let g:torustree_config.grep = 'grep'

  " Marker of project root
  "let g:torustree_config.project.markers = '.git'
  "let g:torustree_config.project.markers = '.project-root'
  " List of markers
  " The project dir is found as soon as one marker is found in it
  let g:torustree_config.project.markers = ['.hg' , '.git', '.project-root']
  " Auto cd to project root if > 0
  let g:torustree_config.project.auto_chdir = 1

  " The folder where toruses and circles will be stored and read
  let g:torustree_config.storage.torustree.folder = '~/.local/share/torustree'
  " Name of the default torustree file
  let g:torustree_config.storage.torustree.name = 'torustree.vim'
  " Auto read torustree file on startup if > 0
  let g:torustree_config.storage.torustree.autoread = 1
  " Auto write torustree file on exit if > 0
  let g:torustree_config.storage.torustree.autowrite = 1
  " The folder where sessions will be stored and read
  let g:torustree_config.storage.session.folder = '~/.local/share/torustree/session'
  " Name of the default session file
  let g:torustree_config.storage.session.name = 'session.vim'
  " Auto read default session file on startup if > 0
  let g:torustree_config.storage.session.autoread = 1
  " Auto write default session file on exit if > 0
  let g:torustree_config.storage.session.autowrite = 1
  " Number of backups for torustree & session files
  let g:torustree_config.storage.backups = 5

  " ---- Maximum number of elements in history
  let g:torustree_config.maxim.history = 400
  " ---- Maximum number of elements in input history
  let g:torustree_config.maxim.input = 200

  " ---- Maximum number of elements in mru
  let g:torustree_config.maxim.mru = 300

  " ---- Maximum number of elements in yank ring
  let g:torustree_config.maxim.default_yanks = 700
  let g:torustree_config.maxim.other_yanks = 100
  " ---- Maximum lines of yank to add in yank ring
  let g:torustree_config.maxim.yank_lines = 30
  " ---- Maximum size of yank to add in yank ring
  let g:torustree_config.maxim.yank_size = 3000

  " ---- Maximum size of layer ring
  let g:torustree_config.maxim.layers = 10

  " ---- Maximum number of tabs in layouts
  let g:torustree_config.maxim.tabs = 12
  " ---- Maximum number of horizontal splits
  let g:torustree_config.maxim.horizontal = 3
  " ---- Maximum number of vertical splits
  let g:torustree_config.maxim.vertical = 4

  " ---- Completion
  let g:torustree_config.completion.vocalize = 1
  let g:torustree_config.completion.wordize = 1
  let g:torustree_config.completion.fuzzy = 0
  let g:torustree_config.completion.scores = 1

  " ---- Frecency
  let g:torustree_config.frecency.reward = 120
  let g:torustree_config.frecency.penalty = 1

  " ---- Mandala & leaf status in statusline ?
  let g:torustree_config.display.statusline = 1
  " ---- Torustree dedibuf message : one-line or multi-line
  let g:torustree_config.display.dedibuf_msg = 'one-line'
  " ---- Filter prompt in dedicated buffers
  "let g:torustree_config.display.prompt = 'torustree $ '
  "let g:torustree_config.display.prompt_writable = 'torustree # '
  " ---- Selection marker in dedicated buffers
  "let g:torustree_config.display.selection = '-> '
  " ---- Signs
  let g:torustree_config.display.sign.switch = 1
  " ---- Signs at torustree locations
  "let g:torustree_config.display.sign.settings = { 'text' : '@' }
  " ---- Signs after using Torustree interface to native navigation (buffer, marker, jump, change, tag, ...)
  "let g:torustree_config.display.sign.native_settings = { 'text' : '*' }

  let g:torustree_config.debug = 0
endif

augroup torustree
  " Clear the group
  autocmd!
  " On vim enter, for autoreading
  autocmd VimEnter * call torustree#void#init()
  " On vim leave, for autowriting
  autocmd VimLeave * call torustree#void#exit()
  " Update location line & col before leaving a window
  autocmd BufLeave * call torustree#vortex#update()
  " For the generalized alternate window command, for all windows in all tabs
  autocmd BufLeave * call torustree#caduceus#update_window()
  " Executed before jumping to a location
  autocmd User WheelBeforeJump call torustree#vortex#update()
  " Executed before organizing the torustree
  autocmd User WheelBeforeOrganize call torustree#vortex#update()
  " Executed before writing the torustree
  autocmd User WheelBeforeWrite call torustree#vortex#update()
  " Executed after jumping to a location
  "autocmd User WheelAfterJump norm zMzx
  " For current torustree location to auto follow window changes
  autocmd WinEnter * call torustree#projection#follow()
  " For current torustree location to follow on editing, buffer loading
  "autocmd BufRead * call torustree#projection#follow()
  " For current torustree location to follow on entering buffer
  "autocmd BufEnter * call torustree#projection#follow()
  " Executed after using Torustree interface to a native jump (buffer, marker, jump, change, tag, ...)
  "autocmd User WheelAfterNative call torustree#projection#follow()
  " Add current non-torustree file to MRU files
  autocmd BufRead * call torustree#attic#record()
  " To record your yanks in the yank ring
  autocmd TextYankPost * call torustree#codex#add()
augroup END
~~~

# Meta-command

The `:Torustree` meta-command gives you access to almost all the plugin
features :

```vim
:Torustree subcommand
```

Completion is available for subcommands. For further details,
see the
[meta-command wiki page](https://github.com/chimay/torustree/wiki/command).

I suggest you map it to a convenient key. Example :

```vim
nnoremap <space>w :Torustree<space>
```

# Bindings

For a thorough discussion on bindings, see
[the bindings page](https://github.com/chimay/torustree/wiki/bindings)
in the wiki.

## Frequently used functions

Below are some bindings that you may find useful. They are included in
the level 10 mappings :

~~~vim
let nmap = 'nmap <silent>'
let vmap = 'vmap <silent>'
" Menus
exe nmap '<m-m>          <plug>(torustree-menu-main)'
exe nmap '<m-=>          <plug>(torustree-menu-meta)'
" Sync
exe nmap '<m-i>          <plug>(torustree-info)'
exe nmap '<m-$>          <plug>(torustree-sync-up)'
exe nmap '<c-$>          <plug>(torustree-sync-down)'
" ---- navigate in the torustree
" --  next / previous
exe nmap '<m-pageup>   <plug>(torustree-previous-location)'
exe nmap '<m-pagedown> <plug>(torustree-next-location)'
exe nmap '<c-pageup>   <plug>(torustree-previous-circle)'
exe nmap '<c-pagedown> <plug>(torustree-next-circle)'
exe nmap '<s-pageup>   <plug>(torustree-previous-torus)'
exe nmap '<s-pagedown> <plug>(torustree-next-torus)'
" -- switch
exe nmap '<m-cr>        <plug>(torustree-prompt-location)'
exe nmap '<c-cr>        <plug>(torustree-prompt-circle)'
exe nmap '<s-cr>        <plug>(torustree-prompt-torus)'
exe nmap '<m-space>     <plug>(torustree-dedibuf-location)'
exe nmap '<c-space>     <plug>(torustree-dedibuf-circle)'
exe nmap '<s-space>     <plug>(torustree-dedibuf-torus)'
" -- index
exe nmap '<m-x>         <plug>(torustree-prompt-index)'
exe nmap '<m-s-x>       <plug>(torustree-dedibuf-index)'
exe nmap '<m-c-x>       <plug>(torustree-dedibuf-index-tree)'
" -- history
exe nmap '<m-home>      <plug>(torustree-history-newer)'
exe nmap '<m-end>       <plug>(torustree-history-older)'
exe nmap '<c-home>      <plug>(torustree-history-newer-in-circle)'
exe nmap '<c-end>       <plug>(torustree-history-older-in-circle)'
exe nmap '<s-home>      <plug>(torustree-history-newer-in-torus)'
exe nmap '<s-end>       <plug>(torustree-history-older-in-torus)'
exe nmap '<m-h>         <plug>(torustree-prompt-history)'
exe nmap '<m-c-h>       <plug>(torustree-dedibuf-history)'
" -- alternate
exe nmap '<c-^>          <plug>(torustree-alternate-anywhere)'
exe nmap '<m-^>          <plug>(torustree-alternate-same-circle)'
exe nmap '<m-c-^>        <plug>(torustree-alternate-same-torus-other-circle)'
" ---- navigate using Torustree interface to vim native tools
" -- buffers
exe nmap '<m-b>          <plug>(torustree-prompt-buffer)'
exe nmap '<m-c-b>        <plug>(torustree-dedibuf-buffer)'
exe nmap '<m-s-b>        <plug>(torustree-dedibuf-buffer-all)'
" -- tabs & windows : visible buffers
exe nmap '<m-v>          <plug>(torustree-prompt-tabwin)'
exe nmap '<m-c-v>        <plug>(torustree-dedibuf-tabwin-tree)'
exe nmap '<m-s-v>        <plug>(torustree-dedibuf-tabwin)'
" -- (neo)vim lists
exe nmap "<m-'>          <plug>(torustree-prompt-marker)"
exe nmap "<m-k>          <plug>(torustree-prompt-marker)"
exe nmap '<m-j>          <plug>(torustree-prompt-jump)'
exe nmap '<m-,>          <plug>(torustree-prompt-change)'
exe nmap '<m-c>          <plug>(torustree-prompt-change)'
exe nmap '<m-t>          <plug>(torustree-prompt-tag)'
exe nmap "<m-c-k>        <plug>(torustree-dedibuf-markers)"
exe nmap '<m-c-j>        <plug>(torustree-dedibuf-jumps)'
exe nmap '<m-;>          <plug>(torustree-dedibuf-changes)'
exe nmap '<m-c-t>        <plug>(torustree-dedibuf-tags)'
" ---- organize the torustree
exe nmap '<m-insert>     <plug>(torustree-prompt-add-here)'
exe nmap '<m-del>        <plug>(torustree-prompt-delete-location)'
exe nmap '<m-r>          <plug>(torustree-dedibuf-reorganize)'
" ---- organize other things
exe nmap '<m-c-r>        <plug>(torustree-dedibuf-reorg-tabwin)'
" ---- refactoring
exe nmap '<m-c-g>        <plug>(torustree-dedibuf-grep-edit)'
exe nmap '<m-n>          <plug>(torustree-dedibuf-narrow-operator)'
exe vmap '<m-n>          <plug>(torustree-dedibuf-narrow)'
exe nmap '<m-c-n>        <plug>(torustree-dedibuf-narrow-circle)'
" ---- search
" -- files
exe nmap '<m-f>          <plug>(torustree-prompt-find)'
exe nmap '<m-c-f>        <plug>(torustree-dedibuf-find)'
exe nmap '<m-c-&>        <plug>(torustree-dedibuf-async-find)'
exe nmap '<m-u>          <plug>(torustree-prompt-mru)'
exe nmap '<m-c-u>        <plug>(torustree-dedibuf-mru)'
exe nmap '<m-l>          <plug>(torustree-dedibuf-locate)'
" -- inside files
exe nmap '<m-o>          <plug>(torustree-prompt-occur)'
exe nmap '<m-c-o>        <plug>(torustree-dedibuf-occur)'
exe nmap '<m-g>          <plug>(torustree-dedibuf-grep)'
exe nmap '<m-s-o>        <plug>(torustree-prompt-outline)'
exe nmap '<c-s-o>        <plug>(torustree-dedibuf-outline)'
" ---- yank ring
exe nmap '<m-y>          <plug>(torustree-prompt-yank-plain-linewise-after)'
exe nmap '<m-p>          <plug>(torustree-prompt-yank-plain-charwise-after)'
exe nmap '<m-s-y>        <plug>(torustree-prompt-yank-plain-linewise-before)'
exe nmap '<m-s-p>        <plug>(torustree-prompt-yank-plain-charwise-before)'
exe nmap '<m-c-y>        <plug>(torustree-dedibuf-yank-plain)'
exe nmap '<m-c-p>        <plug>(torustree-dedibuf-yank-list)'
" ---- undo list
exe nmap '<m-s-u>        <plug>(torustree-dedibuf-undo-list)'
" ---- ex or shell command output
exe nmap '<m-!>          <plug>(torustree-dedibuf-command)'
exe nmap '<m-&>          <plug>(torustree-dedibuf-async)'
" ---- dedicated buffers
exe nmap '<m-tab>        <plug>(torustree-mandala-add)'
exe nmap '<m-backspace>  <plug>(torustree-mandala-delete)'
exe nmap '<m-left>       <plug>(torustree-mandala-backward)'
exe nmap '<m-right>      <plug>(torustree-mandala-forward)'
exe nmap '<c-up>         <plug>(torustree-mandala-switch)'
" ---- layouts
exe nmap '<m-z>          <plug>(torustree-zoom)'
~~~

# Examples
## Display matching files in splits

- `<M-w><space>` to launch the location navigator
- `i` to go to insert mode
- enter the pattern you want
  + e.g. `\.vim$` if all your vim locations end with `.vim`
- `<enter>` to validate the pattern
- `*` to select all the visible (filtered) locations
- `v` to open all selected locations in vertical splits

## More

More examples are available in the
[wiki examples page](https://github.com/chimay/torustree/wiki/examples).

# Warning

Despite abundant testing, some bugs might remain, so be careful.

