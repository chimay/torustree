" vim: set ft=vim fdm=indent iskeyword&:

" Quartz
"
" Internal Constants for menus in mandalas

" Dictionaries are defined as list of items to preserve the order
" of keys.
"
" Useful for menus & context menus

" ---- submenus

if exists('s:menu_help')
	unlockvar! s:menu_help
endif
let s:menu_help = [
			\ ['inline help', 'wheeltree#guru#help'],
			\ ['current prefix mappings', 'wheeltree#guru#mappings'],
			\ ['available mappings (plugs)', 'wheeltree#guru#plugs'],
			\ ['meta command and subcommands', 'wheeltree#guru#meta_command'],
			\ ['autocommands', 'wheeltree#guru#autocommands'],
			\ ['dedicated buffer help', 'wheeltree#guru#mandala'],
			\ ['local maps', 'wheeltree#guru#mandala_mappings'],
			\ ]
lockvar! s:menu_help

if exists('s:menu_status')
	unlockvar! s:menu_status
endif
let s:menu_status = [
			\ ['dashboard', 'wheeltree#status#dashboard'],
			\ ['jump to current wheeltree location', 'wheeltree#vortex#jump'],
			\ ['find closest wheeltree location to cursor', 'wheeltree#projection#follow'],
			\ ]
lockvar! s:menu_status

if exists('s:menu_save_and_load')
	unlockvar! s:menu_save_and_load
endif
let s:menu_save_and_load = [
			\ ['save wheeltree', 'wheeltree#disc#write_wheel'],
			\ ['load wheeltree', 'wheeltree#disc#read_wheel'],
			\ ['save session', 'wheeltree#disc#write_session'],
			\ ['load session', 'wheeltree#disc#read_session'],
			\ ]
lockvar! s:menu_save_and_load

if exists('s:menu_wheel_navigation')
	unlockvar! s:menu_wheel_navigation
endif
let s:menu_wheel_navigation = [
			\ ['previous location' ,  "wheeltree#vortex#previous('location')"],
			\ ['next location' ,  "wheeltree#vortex#next('location')"],
			\ ['previous circle' ,  "wheeltree#vortex#previous('circle')"],
			\ ['next circle' ,  "wheeltree#vortex#next('circle')"],
			\ ['previous torus' ,  "wheeltree#vortex#previous('torus')"],
			\ ['next torus' ,  "wheeltree#vortex#next('torus')"],
			\ ['go to torus' ,  "wheeltree#whirl#switch('torus')"],
			\ ['go to circle' ,  "wheeltree#whirl#switch('circle')"],
			\ ['go to location' ,  "wheeltree#whirl#switch('location')"],
			\ ['go to location in index' ,  'wheeltree#whirl#helix'],
			\ ['go to circle in index' ,  'wheeltree#whirl#grid'],
			\ ['go to element in wheeltree tree' ,  'wheeltree#whirl#tree'],
			\ ['newer location in history' ,  'wheeltree#waterclock#newer'],
			\ ['older location in history' ,  'wheeltree#waterclock#older'],
			\ ['newer location in same circle' ,  "wheeltree#waterclock#newer('circle')"],
			\ ['older location in same circle' ,  "wheeltree#waterclock#older('circle')"],
			\ ['newer location in same torus' ,  "wheeltree#waterclock#newer('torus')"],
			\ ['older location in same torus' ,  "wheeltree#waterclock#older('torus')"],
			\ ['alternate anywhere' ,  "wheeltree#caduceus#alternate('anywhere')"],
			\ ['alternate in same torus' ,  "wheeltree#caduceus#alternate('same_torus')"],
			\ ['alternate in same circle' ,  "wheeltree#caduceus#alternate('same_circle')"],
			\ ['alternate in other torus' ,  "wheeltree#caduceus#alternate('other_torus')"],
			\ ['alternate in other circle' ,  "wheeltree#caduceus#alternate('other_circle')"],
			\ ['alternate in same torus, other circle' ,  "wheeltree#caduceus#alternate('same_torus_other_circle')"],
			\ ['go to location in history' ,  'wheeltree#whirl#history'],
			\ ['go to location in frecency' ,  'wheeltree#whirl#frecency'],
			\ ]
lockvar! s:menu_wheel_navigation

if exists('s:menu_native_navigation')
	unlockvar! s:menu_native_navigation
endif
let s:menu_native_navigation = [
			\ ['go to buffer' ,  'wheeltree#frigate#buffer'],
			\ ['go to buffer (include unlisted)' ,  "wheeltree#frigate#buffer('all')"],
			\ ['go to tab & window' ,  'wheeltree#frigate#tabwin'],
			\ ['go to tab & window (fold tree mode)' ,  'wheeltree#frigate#tabwin_tree'],
			\ ['go to marker' ,  'wheeltree#frigate#marker()'],
			\ ['go to jump' ,  'wheeltree#frigate#jump()'],
			\ ['go to change' ,  'wheeltree#frigate#change()'],
			\ ['go to tag' ,  'wheeltree#frigate#tag()'],
			\ ]
lockvar! s:menu_native_navigation

if exists('s:menu_organize_wheel')
	unlockvar! s:menu_organize_wheel
endif
let s:menu_organize_wheel = [
			\ ['add a new torus' ,  'wheeltree#tree#add_torus'],
			\ ['add a new circle' ,  'wheeltree#tree#add_circle'],
			\ ['add new location at cursor' ,  'wheeltree#tree#add_here'],
			\ ['add a new file' ,  'wheeltree#tree#add_file'],
			\ ['add a new buffer' ,  'wheeltree#tree#add_buffer'],
			\ ['add files matching glob' ,  'wheeltree#tree#add_glob'],
			\ ['reorder toruses' ,  "wheeltree#yggdrasil#reorder('torus')"],
			\ ['reorder circles' ,  "wheeltree#yggdrasil#reorder('circle')"],
			\ ['reorder locations' ,  "wheeltree#yggdrasil#reorder('location')"],
			\ ['rename torus' ,  "wheeltree#tree#rename('torus')"],
			\ ['rename circle' ,  "wheeltree#tree#rename('circle')"],
			\ ['rename location' ,  "wheeltree#tree#rename('location')"],
			\ ['rename file & location' ,  'wheeltree#tree#rename_file'],
			\ ['rename toruses' ,  "wheeltree#yggdrasil#rename('torus')"],
			\ ['rename circles' ,  "wheeltree#yggdrasil#rename('circle')"],
			\ ['rename locations' ,  "wheeltree#yggdrasil#rename('location')"],
			\ ['rename locations & filenames' ,  'wheeltree#yggdrasil#rename_file'],
			\ ['delete torus' ,  "wheeltree#tree#delete('torus')"],
			\ ['delete circle' ,  "wheeltree#tree#delete('circle')"],
			\ ['delete location' ,  "wheeltree#tree#delete('location')"],
			\ ['move circle' ,  "wheeltree#tree#move('circle')"],
			\ ['move location' ,  "wheeltree#tree#move('location')"],
			\ ['copy torus' ,  "wheeltree#tree#copy('torus')"],
			\ ['copy circle' ,  "wheeltree#tree#copy('circle')"],
			\ ['copy location' ,  "wheeltree#tree#copy('location')"],
			\ ['copy or move toruses' ,  "wheeltree#yggdrasil#copy_move('torus')"],
			\ ['copy or move circles' ,  "wheeltree#yggdrasil#copy_move('circle')"],
			\ ['copy or move locations' ,  "wheeltree#yggdrasil#copy_move('location')"],
			\ ['reorganize wheeltree' ,  'wheeltree#yggdrasil#reorganize'],
			\ ]
lockvar! s:menu_organize_wheel

if exists('s:menu_organize_native')
	unlockvar! s:menu_organize_native
endif
let s:menu_organize_native = [
			\ ['reorganize tabs & windows' ,  'wheeltree#mirror#reorg_tabwin'],
			\ ]
lockvar! s:menu_organize_native

if exists('s:menu_refactoring')
	unlockvar! s:menu_refactoring
endif
let s:menu_refactoring = [
			\ ['grep in edit mode' ,  'wheeltree#shadow#grep_edit'],
			\ ['narrow current file' ,  'wheeltree#shadow#narrow_file'],
			\ ['narrow all files in circle' ,  'wheeltree#shadow#narrow_circle'],
			\ ]
lockvar! s:menu_refactoring

if exists('s:menu_search_file')
	unlockvar! s:menu_search_file
endif
let s:menu_search_file = [
			\ ['go to most recently used file (mru)' ,  'wheeltree#frigate#mru'],
			\ ['go to locate result' ,  'wheeltree#frigate#locate'],
			\ ['go to find result' ,  'wheeltree#frigate#find'],
			\ ['go to async find result' ,  'wheeltree#frigate#async_find'],
			\ ]
lockvar! s:menu_search_file

if exists('s:menu_search_inside_file')
	unlockvar! s:menu_search_inside_file
endif
let s:menu_search_inside_file = [
			\ ['go to matching line (occur)' ,  'wheeltree#frigate#occur'],
			\ ['go to grep result' ,  'wheeltree#frigate#grep()'],
			\ ['go to outline result' ,  'wheeltree#frigate#outline()'],
			\ ]
lockvar! s:menu_search_inside_file

if exists('s:menu_yank')
	unlockvar! s:menu_yank
endif
let s:menu_yank = [
			\ ['yank wheeltree in list mode' ,  "wheeltree#clipper#yank('list')"],
			\ ['yank wheeltree in plain mode' ,  "wheeltree#clipper#yank('plain')"],
			\ ]
lockvar! s:menu_yank

if exists('s:menu_undo')
	unlockvar! s:menu_undo
endif
let s:menu_undo = [
			\ ['undo list' ,  'wheeltree#triangle#undolist'],
			\ ]
lockvar! s:menu_undo

if exists('s:menu_command')
	unlockvar! s:menu_command
endif
let s:menu_command = [
			\ [':ex or !shell command output', 'wheeltree#mandala#command'],
			\ ['async shell command output' ,  'wheeltree#mandala#async'],
			\ ]
lockvar! s:menu_command

if exists('s:menu_dedicated_buffers')
	unlockvar! s:menu_dedicated_buffers
endif
let s:menu_dedicated_buffers = [
			\ ['add new dedicated buffer', 'wheeltree#cylinder#add()'],
			\ ['delete current dedicated buffer', 'wheeltree#cylinder#add()'],
			\ ['switch dedicated buffer', 'wheeltree#cylinder#switch()'],
			\ ]
lockvar! s:menu_dedicated_buffers

if exists('s:menu_layout')
	unlockvar! s:menu_layout
endif
let s:menu_layout = [
			\ ['zoom ,  one tab, one window', 'wheeltree#mosaic#zoom()'],
			\ ['rotate windows clockwise' ,  'wheeltree#mosaic#rotate_clockwise()'],
			\ ['rotate windows counter-clockwise' ,  'wheeltree#mosaic#rotate_counter_clockwise()'],
			\ ]
lockvar! s:menu_layout

if exists('s:menu_layout_tabs')
	unlockvar! s:menu_layout_tabs
endif
let s:menu_layout_tabs = [
			\ ['toruses on tabs' ,  "wheeltree#mosaic#tabs('torus')"],
			\ ['circles on tabs' ,  "wheeltree#mosaic#tabs('circle')"],
			\ ['locations on tabs' ,  "wheeltree#mosaic#tabs('location')"],
			\ ]
lockvar! s:menu_layout_tabs

if exists('s:menu_layout_windows')
	unlockvar! s:menu_layout_windows
endif
let s:menu_layout_windows = [
			\ ['toruses on horizontal splits' ,  "wheeltree#mosaic#split('torus')"],
			\ ['circles on horizontal splits' ,  "wheeltree#mosaic#split('circle')"],
			\ ['locations on horizontal splits' ,  "wheeltree#mosaic#split('location')"],
			\ ['toruses on vertical splits' ,  "wheeltree#mosaic#split('torus', 'vertical')"],
			\ ['circles on vertical splits' ,  "wheeltree#mosaic#split('circle', 'vertical')"],
			\ ['locations on vertical splits' ,  "wheeltree#mosaic#split('location', 'vertical')"],
			\ ['toruses on splits, main top layout' ,  "wheeltree#mosaic#split('torus', 'main_top')"],
			\ ['circles on splits, main top layout' ,  "wheeltree#mosaic#split('circle', 'main_top')"],
			\ ['locations on splits, main top layout' ,  "wheeltree#mosaic#split('location', 'main_top')"],
			\ ['toruses on splits, main left layout' ,  "wheeltree#mosaic#split('torus', 'main_left')"],
			\ ['circles on splits, main left layout' ,  "wheeltree#mosaic#split('circle', 'main_left')"],
			\ ['locations on splits, main left layout' ,  "wheeltree#mosaic#split('location', 'main_left')"],
			\ ['toruses on splits, grid layout' ,  "wheeltree#mosaic#split_grid('torus')"],
			\ ['circles on splits, grid layout' ,  "wheeltree#mosaic#split_grid('circle')"],
			\ ['locations on splits, grid layout' ,  "wheeltree#mosaic#split_grid('location')"],
			\ ['toruses on splits, transposed grid layout' ,  "wheeltree#mosaic#split_transposed_grid('torus')"],
			\ ['circles on splits, transposed grid layout' ,  "wheeltree#mosaic#split_transposed_grid('circle')"],
			\ ['locations on splits, transposed grid layout' ,  "wheeltree#mosaic#split_transposed_grid('location')"],
			\ ['toruses on splits, golden horizontal' ,  "wheeltree#mosaic#golden('torus', 'horizontal')"],
			\ ['circles on splits, golden horizontal' ,  "wheeltree#mosaic#golden('circle', 'horizontal')"],
			\ ['locations on splits, golden horizontal' ,  "wheeltree#mosaic#golden('location', 'horizontal')"],
			\ ['toruses on splits, golden vertical' ,  "wheeltree#mosaic#golden('torus', 'vertical')"],
			\ ['circles on splits, golden vertical' ,  "wheeltree#mosaic#golden('circle', 'vertical')"],
			\ ['locations on splits, golden vertical' ,  "wheeltree#mosaic#golden('location', 'vertical')"],
			\ ['toruses on splits, golden left layout' ,  "wheeltree#mosaic#golden('torus', 'main_left')"],
			\ ['circles on splits, golden left layout' ,  "wheeltree#mosaic#golden('circle', 'main_left')"],
			\ ['locations on splits, golden left layout' ,  "wheeltree#mosaic#golden('location', 'main_left')"],
			\ ['toruses on splits, golden top layout' ,  "wheeltree#mosaic#golden('torus', 'main_top')"],
			\ ['circles on splits, golden top layout' ,  "wheeltree#mosaic#golden('circle', 'main_top')"],
			\ ['locations on splits, golden top layout' ,  "wheeltree#mosaic#golden('location', 'main_top')"],
			\ ]
lockvar! s:menu_layout_windows

if exists('s:menu_layout_mixed')
	unlockvar! s:menu_layout_mixed
endif
let s:menu_layout_mixed = [
			\ ['mix : toruses on tabs & circles on splits', "wheeltree#pyramid#steps('torus')"],
			\ ['mix : circles on tabs & locations on splits', "wheeltree#pyramid#steps('circle')"],
			\ ]
lockvar! s:menu_layout_mixed

" ---- list of submenus variables

if exists('s:menu_list')
	unlockvar! s:menu_list
endif
let s:menu_list = [
			\ 'help',
			\ 'status',
			\ 'save and load',
			\ 'wheeltree navigation',
			\ 'native navigation',
			\ 'organize wheeltree',
			\ 'organize native',
			\ 'refactoring',
			\ 'search file',
			\ 'search inside file',
			\ 'yank',
			\ 'undo',
			\ 'command',
			\ 'layout',
			\ 'layout tabs',
			\ 'layout windows',
			\ 'layout mixed',
			\ ]
lockvar! s:menu_list

" ---- main menu

if exists('s:menu_main')
	unlockvar! s:menu_main
endif
let s:menu_main = []
for s:name in s:menu_list
	let s:formated = substitute(s:name, ' ', '_', 'g')
	eval s:menu_main->extend(s:menu_{s:formated})
endfor
lockvar! s:menu_main

" ---- meta menu

if exists('s:menu_meta')
	unlockvar! s:menu_meta
endif
let s:menu_meta = []
for s:name in s:menu_list
	let s:formated = substitute(s:name, ' ', '_', 'g')
	let s:function = 'wheeltree#helm#submenu(' .. string(s:formated) .. ')'
	eval s:menu_meta->add([s:name, s:function])
endfor
lockvar! s:menu_meta

" ---- contextual menus

if exists('s:context_navigation')
	unlockvar! s:context_navigation
endif
let s:context_navigation = [
			\ ['open' ,  "wheeltree#boomerang#navigation('here')"],
			\ ['open in tab(s)' ,  "wheeltree#boomerang#navigation('tab')"],
			\ ['open in horizontal split(s)' ,  "wheeltree#boomerang#navigation('horizontal_split')"],
			\ ['open in vertical split(s)' ,  "wheeltree#boomerang#navigation('vertical_split')"],
			\ ['open in horizontal golden split(s)' ,  "wheeltree#boomerang#navigation('horizontal_golden')"],
			\ ['open in vertical golden split(s)' ,  "wheeltree#boomerang#navigation('vertical_golden')"],
			\ ]
lockvar! s:context_navigation

if exists('s:context_buffer')
	unlockvar! s:context_buffer
endif
let s:context_buffer = s:context_navigation + [
			\ ['delete' ,  "wheeltree#boomerang#buffer('delete')"],
			\ ['unload' ,  "wheeltree#boomerang#buffer('unload')"],
			\ ['wipe' ,  "wheeltree#boomerang#buffer('wipe')"],
			\ ['delete hidden buffers' ,  "wheeltree#boomerang#buffer('delete_hidden')"],
			\ ['wipe hidden buffers' ,  "wheeltree#boomerang#buffer('wipe_hidden')"],
			\ ]
lockvar! s:context_buffer

if exists('s:context_buffer_all')
	unlockvar! s:context_buffer_all
endif
let s:context_buffer_all = s:context_navigation + [
			\ ['delete' ,  "wheeltree#boomerang#buffer('delete')"],
			\ ['unload' ,  "wheeltree#boomerang#buffer('unload')"],
			\ ['wipe' ,  "wheeltree#boomerang#buffer('wipe')"],
			\ ['delete hidden buffers' ,  "wheeltree#boomerang#buffer('delete_hidden')"],
			\ ['wipe hidden buffers' ,  "wheeltree#boomerang#buffer('wipe_hidden')"],
			\ ['wipe all hidden buffers, including unlisted ones' ,  "wheeltree#boomerang#buffer('wipe_all_hidden')"],
			\ ]
lockvar! s:context_buffer_all

if exists('s:context_tabwin')
	unlockvar! s:context_tabwin
endif
let s:context_tabwin = [
			\ ['open' ,  "wheeltree#boomerang#tabwin('open')"],
			\ ['new tab' ,  "wheeltree#boomerang#tabwin('tabnew')"],
			\ ['close tab' ,  "wheeltree#boomerang#tabwin('tabclose')"],
			\ ['reorganize' ,  'wheeltree#mirror#reorg_tabwin'],
			\ ]
lockvar! s:context_tabwin

if exists('s:context_tabwin_tree')
	unlockvar! s:context_tabwin_tree
endif
let s:context_tabwin_tree = [
			\ ['open' ,  "wheeltree#boomerang#tabwin_tree('open')"],
			\ ['new tab' ,  "wheeltree#boomerang#tabwin_tree('tabnew')"],
			\ ['close tab' ,  "wheeltree#boomerang#tabwin_tree('tabclose')"],
			\ ['reorganize' ,  'wheeltree#mirror#reorg_tabwin'],
			\ ]
lockvar! s:context_tabwin_tree

if exists('s:context_grep')
	unlockvar! s:context_grep
endif
let s:context_grep = s:context_navigation + [
			\ ['edit mode' ,  "wheeltree#shadow#grep_edit()"],
			\ ['open quickfix' ,  "wheeltree#boomerang#grep('quickfix')"],
			\ ]
lockvar! s:context_grep

if exists('s:context_yank_list')
	unlockvar! s:context_yank_list
endif
let s:context_yank_list = [
			\ ['linewise paste before' ,  "wheeltree#boomerang#yank('linewise-before')"],
			\ ['linewise paste after' ,  "wheeltree#boomerang#yank('linewise-after')"],
			\ ['characterwise paste before' ,  "wheeltree#boomerang#yank('charwise-before')"],
			\ ['characterwise paste after' ,  "wheeltree#boomerang#yank('charwise-after')"],
			\ ['undo' ,  'wheeltree#codex#undo()'],
			\ ['redo' ,  'wheeltree#codex#redo()'],
			\ ]
lockvar! s:context_yank_list

if exists('s:context_yank_plain')
	unlockvar! s:context_yank_plain
endif
let s:context_yank_plain = [
			\ ['linewise paste before' ,  "wheeltree#boomerang#yank('linewise-before')"],
			\ ['linewise paste after' ,  "wheeltree#boomerang#yank('linewise-after')"],
			\ ['characterwise paste before' ,  "wheeltree#boomerang#yank('charwise-before')"],
			\ ['characterwise paste after' ,  "wheeltree#boomerang#yank('charwise-after')"],
			\ ['undo' ,  'wheeltree#codex#undo()'],
			\ ['redo' ,  'wheeltree#codex#redo()'],
			\ ]
lockvar! s:context_yank_plain

" ---- public interface

fun! wheeltree#quartz#fetch (varname, conversion = 'no-conversion')
	" Return script variable called varname
	" The leading s: can be omitted
	" Optional argument :
	"   - no-conversion : simply returns the asked variable, dont convert anything
	"   - dict : if varname points to an items list, convert it to a dictionary
	let varname = a:varname
	let conversion = a:conversion
	" ---- variable name
	let varname = substitute(varname, '/', '_', 'g')
	let varname = substitute(varname, '-', '_', 'g')
	let varname = substitute(varname, ' ', '_', 'g')
	if varname !~ '\m^s:'
		let varname = 's:' .. varname
	endif
	" ---- raw or conversion
	if conversion ==# 'dict'
		return wheeltree#matrix#items2dict ({varname})
	else
		return {varname}
	endif
endfun
