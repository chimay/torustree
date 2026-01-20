" vim: set filetype=vim:
" Torustree - Vim Navigation Framework and Buffer Groups Manager

scriptencoding utf-8

if exists("g:wheeltree_loaded")
	finish
endif

let g:wheeltree_loaded = 1

call torustree#void#foundation ()
call torustree#centre#commands ()
call torustree#centre#plugs ()
call torustree#centre#cables ()
