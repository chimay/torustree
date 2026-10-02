" vim: set ft=vim fdm=indent iskeyword&:

" Form
"
" Templates for torustree containers :
"
" - location : contains a file path and a cursor position
"   + stone : alias for location
" - circle : a group of locations, or a stone circle
" - forest : a list of trees
" - tree : generic container for a circle and a forest
" - torustree : root tree
"   + current
"     * depth : depth of current tree

fun! torustree#form#circle (init = {})
	" Stone circle, aka location list, and metadata
	" Optional argument : init dict
	let circle = a:init
	if ! circle->has_key('stones')
		let circle.stones = []
	endif
	if ! circle->has_key('glossary')
		let circle.glossary = []
	endif
	if ! circle->has_key('current')
		let circle.current = -1
	endif
	return circle
endfun

fun! torustree#form#forest (init = {})
	" Forest, aka tree list, and metadata
	" Optional argument : init dict
	let forest = a:init
	if ! forest->has_key('trees')
		let forest.trees = []
	endif
	if ! forest->has_key('glossary')
		let forest.glossary = []
	endif
	if ! forest->has_key('current')
		let forest.current = -1
	endif
	return forest
endfun

fun! torustree#form#tree (init = {})
	" Stone circle and forest container, aka tree, and metadata
	" Optional argument : init dict
	let tree = a:init
	if ! tree->has_key('circle')
		let tree.circle = torustree#form#circle ()
	endif
	if ! tree->has_key('forest')
		let tree.forest = torustree#form#forest ()
	endif
	return tree
endfun

fun! torustree#form#root_meta (init = {})
	" Meta for root tree metadata
	" Optional argument : init dict
	let meta = a:init
	if ! meta->has_key('depth')
		let meta.depth = 0
	endif
	return meta
endfun

fun! torustree#form#root (init_tree = {}, init_meta = {})
	" Root tree, aka torustree
	" Optional argument : init dict
	let torustree = torustree#form#tree (a:init_tree)
	let meta = torustree#form#root_meta (a:init_meta)
	for key in keys(meta)
		let torustree[key] = meta[key]
	endfor
	return torustree
endfun
