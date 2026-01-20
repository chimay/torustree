" vim: set ft=vim fdm=indent iskeyword&:

" Cuckoo
"
" Frecency : frequent + recent

" ---- helpers

fun! torustree#cuckoo#slide (entry)
	" Decrease score in frecency
	let entry = a:entry
	let entry.score -= g:torustree_config.frecency.penalty
	return entry
endfun

" ---- functions

fun! torustree#cuckoo#record ()
	" Record current torus, circle, location in frecency
	let frecency = g:torustree_history.frecency
	let coordin = torustree#referen#coordinates()
	let entry = {}
	let length = len(frecency)
	for index in range(length)
		let elem = frecency[index]
		if elem.coordin == coordin
			let entry = frecency->remove(index)
			let entry.score += g:torustree_config.frecency.reward
			break
		endif
	endfor
	if empty(entry)
		let entry.coordin = coordin
		let entry.score = g:torustree_config.frecency.reward
	endif
	eval frecency->map({ _, val -> torustree#cuckoo#slide (val) })
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
