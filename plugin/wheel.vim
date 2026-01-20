" vim: set filetype=vim:
" Wheeltree - Vim Navigation Framework and Buffer Groups Manager

scriptencoding utf-8

if exists("g:wheeltree_loaded")
	finish
endif

let g:wheeltree_loaded = 1

call wheeltree#void#foundation ()
call wheeltree#centre#commands ()
call wheeltree#centre#plugs ()
call wheeltree#centre#cables ()
