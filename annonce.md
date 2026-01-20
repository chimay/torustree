# Introduction

## Goal

[Wheeltree](https://github.com/chimay/wheeltree) is a plugin for Vim or Neovim
aimed at managing buffer groups.

In short, it let you organize your buffers by creating as many buffer
groups as you need, add the buffers you want to it and quickly navigate
between :

- Buffers of the same group
- Buffer groups

Note that :

- A location contains a name, a filename, as well as a line & column number
- A buffer group, in fact a location group, is called a circle
- A set of buffer groups, or a category, is called a torus (a circle of circles)
- The list of toruses is called the wheeltree

## Features

- Add
  + Files from anywhere in the filesystem
  + A file in more than one group
  + file:line-1 and file:line-2 in the same group
- Easy navigation
  + On demand loading of files
  + Jump to matching tab & window if available
  + Choose file, group or category in special buffer
    * Filter candidates
	* Folds matching wheeltree tree structure
  + Auto `:lcd` to project root of current file
- May be saved in wheeltree file
- Reordering elements
- Moving elements
- Display files
  + 1 location per tab
  + 1 circle per tab
  + 1 torus per tab
  + split : vertical, horizontal, grid, main, ...
  + Mix of above
- Batch operations

# Installation

Simply add this line to your initialisation file :

```vim
call minpac#add('chimay/wheeltree', { 'type' : 'start' })
```

and it’s done.

# Documentation

Your guide on the wheeltree tracks :

```vim
 :help wheeltree.txt
 ```

