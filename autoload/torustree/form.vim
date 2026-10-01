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
	" Template for circle, aka location list, and metadata
	" Optional argument : init dict
	let template = a:init
	if ! has_key(template, 'stones')
		let template.stones = []
	endif
	if ! has_key(template, 'glossary')
		let template.glossary = []
	endif
	if ! has_key(template, 'current')
		let template.current = -1
	endif
	return template
endfun

fun! torustree#form#forest (init = {})
	" Template for tree list, aka forest, and metadata
	" Optional argument : init dict
	let template = a:init
	if ! has_key(template, 'trees')
		let template.trees = []
	endif
	if ! has_key(template, 'glossary')
		let template.glossary = []
	endif
	if ! has_key(template, 'current')
		let template.current = -1
	endif
	return template
endfun

fun! torustree#form#tree (init = {})
	" Template for forest and circle container, aka land, and metadata
	" Optional argument : init dict
	let template = a:init
	if ! has_key(template, 'circle')
		let template.circle = torustree#form#circle ()
	endif
	if ! has_key(template, 'forest')
		let template.forest = torustree#form#forest ()
	endif
	if ! has_key(template, 'glossary')
		let template.glossary = []
	endif
	if ! has_key(template, 'current')
		let template.current = -1
	endif
	return template
endfun

