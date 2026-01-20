" vim: set ft=vim fdm=indent iskeyword&:

" Projection
"
" Find & follow the closest element in torustree

" ---- scripts constants

if exists('s:level_separ')
	unlockvar s:level_separ
endif
let s:level_separ = torustree#crystal#fetch('separator/level')
lockvar s:level_separ

" ---- projection

fun! torustree#projection#closest (...)
	" Find closest location to :
	"   - given file & line
	"   - filename & position (default)
	" The search is done in album index
	" Optional arguments :
	"   - level : search in given current level
	"     + torustree : everywhere in the torustree
	"     + torus : in current torus
	"     + circle : in current circle
	"   - file name
	"   - line number
	"   - column number
	if a:0 > 0
		let level = a:1
	else
		let level = 'torustree'
	endif
	if a:0 > 1
		let filename = a:2
	else
		let filename = expand('%:p')
	endif
	if a:0 > 2
		let linum = a:3
	else
		let linum = line('.')
	endif
	if a:0 > 3
		let colnum = a:4
	else
		let colnum = col('.')
	endif
	" no global var, should be fine without deepcopy
	let album = torustree#helix#album ()
	eval album->filter({ _,value -> value[2].file ==# filename })
	" narrow down to current level
	let narrow = torustree#referen#level_index_in_coordin(level)
	if narrow >= 0
		let narrow_coordin = torustree#referen#coordinates ()
		for index in range(0, narrow)
			eval album->filter({ _,value -> value[index] == narrow_coordin[index] })
		endfor
	endif
	if empty(album)
		return []
	endif
	" min diff lines
	let lines = map(deepcopy(album), {_, val -> val[2].line})
	let diff = map(copy(lines), {_, val -> abs(val - linum)})
	let where = torustree#lagrange#argmin (diff)
	let album = album->torustree#chain#sublist(where)
	" min diff columns
	let cols = map(deepcopy(album), {_, val -> val[2].col})
	let diff = map(copy(cols), {_, val -> abs(val - colnum)})
	let where = torustree#lagrange#argmin (diff)
	let album = album->torustree#chain#sublist(where)
	" closest
	let closest = album[0]
	let coordin = closest[0:1] + [closest[2].name]
	return coordin
endfun

fun! torustree#projection#follow (...)
	" Try to set current location to match current file
	" Choose location closest to current line
	" Optional arguments :
	"   - level to search in : torustree, torus or circle
	if a:0 > 0
		let level = a:1
	else
		let level = 'torustree'
	endif
	" ---- if torus or circle is empty, assume the user
	" ---- wants to add something before switching
	if level ==# 'torustree' && torustree#referen#is_empty ('torus')
		"echomsg 'torustree follow : torus is empty'
		return v:false
	endif
	" ---- first add some locations before leaving empty circle
	if torustree#chain#is_inside(level, ['torustree', 'torus']) && torustree#referen#is_empty ('circle')
		echomsg 'torustree follow : circle is empty'
		return v:false
	endif
	" ---- follow
	let coordin = torustree#projection#closest (level)
	if empty(coordin)
		" outside of the torustree
		return v:false
	endif
	" ---- if we are already there, just update location line & col
	if coordin == torustree#referen#coordinates()
		call torustree#vortex#update ('verbose')
		return v:false
	endif
	" ---- tune
	call torustree#vortex#chord (coordin)
	if g:torustree_config.project.auto_chdir > 0
		let markers = g:torustree_config.project.markers
		call torustree#disc#project_root (markers)
	endif
	call torustree#pendulum#record ()
	let infolist = [ 'torustree follow :', join(coordin, s:level_separ) ]
	call torustree#status#echo (infolist)
	" ---- update location to cursor position
	call torustree#vortex#update ()
	return v:true
endfun
