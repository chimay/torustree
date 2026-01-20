" vim: set ft=vim fdm=indent iskeyword&:

" Cuckoo
"
" Frecency : frequent + recent

" ---- helpers

fun! wheeltree#cuckoo#slide (entry)
	" Decrease score in frecency
	let entry = a:entry
	let entry.score -= g:wheeltree_config.frecency.penalty
	return entry
endfun

" ---- functions

fun! wheeltree#cuckoo#record ()
	" Record current torus, circle, location in frecency
	let frecency = g:wheeltree_history.frecency
	let coordin = wheeltree#referen#coordinates()
	let entry = {}
	let length = len(frecency)
	for index in range(length)
		let elem = frecency[index]
		if elem.coordin == coordin
			let entry = frecency->remove(index)
			let entry.score += g:wheeltree_config.frecency.reward
			break
		endif
	endfor
	if empty(entry)
		let entry.coordin = coordin
		let entry.score = g:wheeltree_config.frecency.reward
	endif
	eval frecency->map({ _, val -> wheeltree#cuckoo#slide (val) })
	eval frecency->filter({ _, val -> val.score >= 0 })
	let length = len(frecency)
	for index in range(length)
		let elem = frecency[index]
		if entry.score >= elem.score
			eval frecency->insert(entry, index)
			return v:true
		endif
	endfor
	" still not inserted ? add it at the end
	eval frecency->add(entry)
	return v:true
endfun
