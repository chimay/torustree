" vim: set ft=vim fdm=indent iskeyword&:

" Helix
"
" Indexes

fun! wheeltree#helix#album ()
	" Full index of toruses, circles & locations in the wheeltree
	" Each entry = [torus.name, circle.name, location]
	" Not worth caching it : updated too often,
	" each time a line or col is changed in a location
	let album = []
	for torus in g:wheeltree.toruses
		for circle in torus.circles
			for location in circle.locations
				let entry = [torus.name, circle.name, location]
				let album = add(album, entry)
			endfor
		endfor
	endfor
	return album
endfun

fun! wheeltree#helix#helix ()
	" Index of locations coordinates in the wheeltree
	" Each coordinate = [torus.name, circle.name, location.name]
	if g:wheeltree.timestamp >= g:wheeltree_helix.timestamp
		let helix = []
		for torus in g:wheeltree.toruses
			for circle in torus.circles
				for location in circle.locations
					let coordin = [torus.name, circle.name, location.name]
					let helix = add(helix, coordin)
				endfor
			endfor
		endfor
		let g:wheeltree_helix.table = helix
		let g:wheeltree_helix.timestamp = wheeltree#pendulum#timestamp()
	else
		let helix = g:wheeltree_helix.table
	endif
	return helix
endfun

fun! wheeltree#helix#grid ()
	" Index of circles coordinates in the wheeltree
	" Each coordinate = [torus.name, circle.name]
	if g:wheeltree.timestamp >= g:wheeltree_grid.timestamp
		let grid = []
		for torus in g:wheeltree.toruses
			for circle in torus.circles
				let coordin = [torus.name, circle.name]
				let grid = add(grid, coordin)
			endfor
		endfor
		let g:wheeltree_grid.table = grid
		let g:wheeltree_grid.timestamp = wheeltree#pendulum#timestamp()
	else
		let grid = g:wheeltree_grid.table
	endif
	return grid
endfun

fun! wheeltree#helix#files ()
	" Index of files in the wheeltree
	if g:wheeltree.timestamp >= g:wheeltree_files.timestamp
		let files = []
		for torus in g:wheeltree.toruses
			for circle in torus.circles
				for location in circle.locations
					let filename = location.file
					let files = add(files, filename)
				endfor
			endfor
		endfor
		let files = uniq(sort(files))
		let g:wheeltree_files.table = files
		let g:wheeltree_files.timestamp = wheeltree#pendulum#timestamp()
	else
		let files = g:wheeltree_files.table
	endif
	return files
endfun

fun! wheeltree#helix#rename_file(old, new)
	" Rename all occurences old -> new filename
	let old = a:old
	let new = a:new
	let files = g:wheeltree_files.table
	for index in wheeltree#chain#rangelen(files)
		if files[index] ==# old
			let files[index] = new
		endif
	endfor
	let g:wheeltree_files.timestamp = wheeltree#pendulum#timestamp()
endfun
