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
			\ ['inline help', 'torustree#guru#help'],
			\ ['current prefix mappings', 'torustree#guru#mappings'],
			\ ['available mappings (plugs)', 'torustree#guru#plugs'],
			\ ['meta command and subcommands', 'torustree#guru#meta_command'],
			\ ['autocommands', 'torustree#guru#autocommands'],
			\ ['dedicated buffer help', 'torustree#guru#mandala'],
			\ ['local maps', 'torustree#guru#mandala_mappings'],
			\ ]
lockvar! s:menu_help

if exists('s:menu_status')
	unlockvar! s:menu_status
endif
let s:menu_status = [
			\ ['dashboard', 'torustree#status#dashboard'],
			\ ['jump to current torustree location', 'torustree#vortex#jump'],
			\ ['find closest torustree location to cursor', 'torustree#projection#follow'],
			\ ]
lockvar! s:menu_status

if exists('s:menu_save_and_load')
	unlockvar! s:menu_save_and_load
endif
let s:menu_save_and_load = [
			\ ['save torustree', 'torustree#disc#write_torustree'],
			\ ['load torustree', 'torustree#disc#read_torustree'],
			\ ['save session', 'torustree#disc#write_session'],
			\ ['load session', 'torustree#disc#read_session'],
			\ ]
lockvar! s:menu_save_and_load

if exists('s:menu_torustree_navigation')
	unlockvar! s:menu_torustree_navigation
endif
let s:menu_torustree_navigation = [
			\ ['previous location' ,  "torustree#vortex#previous('location')"],
			\ ['next location' ,  "torustree#vortex#next('location')"],
			\ ['previous circle' ,  "torustree#vortex#previous('circle')"],
			\ ['next circle' ,  "torustree#vortex#next('circle')"],
			\ ['previous torus' ,  "torustree#vortex#previous('torus')"],
			\ ['next torus' ,  "torustree#vortex#next('torus')"],
			\ ['go to torus' ,  "torustree#whirl#switch('torus')"],
			\ ['go to circle' ,  "torustree#whirl#switch('circle')"],
			\ ['go to location' ,  "torustree#whirl#switch('location')"],
			\ ['go to location in index' ,  'torustree#whirl#helix'],
			\ ['go to circle in index' ,  'torustree#whirl#grid'],
			\ ['go to element in torustree tree' ,  'torustree#whirl#tree'],
			\ ['newer location in history' ,  'torustree#waterclock#newer'],
			\ ['older location in history' ,  'torustree#waterclock#older'],
			\ ['newer location in same circle' ,  "torustree#waterclock#newer('circle')"],
			\ ['older location in same circle' ,  "torustree#waterclock#older('circle')"],
			\ ['newer location in same torus' ,  "torustree#waterclock#newer('torus')"],
			\ ['older location in same torus' ,  "torustree#waterclock#older('torus')"],
			\ ['alternate anywhere' ,  "torustree#caduceus#alternate('anywhere')"],
			\ ['alternate in same torus' ,  "torustree#caduceus#alternate('same_torus')"],
			\ ['alternate in same circle' ,  "torustree#caduceus#alternate('same_circle')"],
			\ ['alternate in other torus' ,  "torustree#caduceus#alternate('other_torus')"],
			\ ['alternate in other circle' ,  "torustree#caduceus#alternate('other_circle')"],
			\ ['alternate in same torus, other circle' ,  "torustree#caduceus#alternate('same_torus_other_circle')"],
			\ ['go to location in history' ,  'torustree#whirl#history'],
			\ ['go to location in frecency' ,  'torustree#whirl#frecency'],
			\ ]
lockvar! s:menu_torustree_navigation

if exists('s:menu_native_navigation')
	unlockvar! s:menu_native_navigation
endif
let s:menu_native_navigation = [
			\ ['go to buffer' ,  'torustree#frigate#buffer'],
			\ ['go to buffer (include unlisted)' ,  "torustree#frigate#buffer('all')"],
			\ ['go to tab & window' ,  'torustree#frigate#tabwin'],
			\ ['go to tab & window (fold tree mode)' ,  'torustree#frigate#tabwin_tree'],
			\ ['go to marker' ,  'torustree#frigate#marker()'],
			\ ['go to jump' ,  'torustree#frigate#jump()'],
			\ ['go to change' ,  'torustree#frigate#change()'],
			\ ['go to tag' ,  'torustree#frigate#tag()'],
			\ ]
lockvar! s:menu_native_navigation

if exists('s:menu_organize_torustree')
	unlockvar! s:menu_organize_torustree
endif
let s:menu_organize_torustree = [
			\ ['add a new torus' ,  'torustree#tree#add_torus'],
			\ ['add a new circle' ,  'torustree#tree#add_circle'],
			\ ['add new location at cursor' ,  'torustree#tree#add_here'],
			\ ['add a new file' ,  'torustree#tree#add_file'],
			\ ['add a new buffer' ,  'torustree#tree#add_buffer'],
			\ ['add files matching glob' ,  'torustree#tree#add_glob'],
			\ ['reorder toruses' ,  "torustree#yggdrasil#reorder('torus')"],
			\ ['reorder circles' ,  "torustree#yggdrasil#reorder('circle')"],
			\ ['reorder locations' ,  "torustree#yggdrasil#reorder('location')"],
			\ ['rename torus' ,  "torustree#tree#rename('torus')"],
			\ ['rename circle' ,  "torustree#tree#rename('circle')"],
			\ ['rename location' ,  "torustree#tree#rename('location')"],
			\ ['rename file & location' ,  'torustree#tree#rename_file'],
			\ ['rename toruses' ,  "torustree#yggdrasil#rename('torus')"],
			\ ['rename circles' ,  "torustree#yggdrasil#rename('circle')"],
			\ ['rename locations' ,  "torustree#yggdrasil#rename('location')"],
			\ ['rename locations & filenames' ,  'torustree#yggdrasil#rename_file'],
			\ ['delete torus' ,  "torustree#tree#delete('torus')"],
			\ ['delete circle' ,  "torustree#tree#delete('circle')"],
			\ ['delete location' ,  "torustree#tree#delete('location')"],
			\ ['move circle' ,  "torustree#tree#move('circle')"],
			\ ['move location' ,  "torustree#tree#move('location')"],
			\ ['copy torus' ,  "torustree#tree#copy('torus')"],
			\ ['copy circle' ,  "torustree#tree#copy('circle')"],
			\ ['copy location' ,  "torustree#tree#copy('location')"],
			\ ['copy or move toruses' ,  "torustree#yggdrasil#copy_move('torus')"],
			\ ['copy or move circles' ,  "torustree#yggdrasil#copy_move('circle')"],
			\ ['copy or move locations' ,  "torustree#yggdrasil#copy_move('location')"],
			\ ['reorganize torustree' ,  'torustree#yggdrasil#reorganize'],
			\ ]
lockvar! s:menu_organize_torustree

if exists('s:menu_organize_native')
	unlockvar! s:menu_organize_native
endif
let s:menu_organize_native = [
			\ ['reorganize tabs & windows' ,  'torustree#mirror#reorg_tabwin'],
			\ ]
lockvar! s:menu_organize_native

if exists('s:menu_refactoring')
	unlockvar! s:menu_refactoring
endif
let s:menu_refactoring = [
			\ ['grep in edit mode' ,  'torustree#shadow#grep_edit'],
			\ ['narrow current file' ,  'torustree#shadow#narrow_file'],
			\ ['narrow all files in circle' ,  'torustree#shadow#narrow_circle'],
			\ ]
lockvar! s:menu_refactoring

if exists('s:menu_search_file')
	unlockvar! s:menu_search_file
endif
let s:menu_search_file = [
			\ ['go to most recently used file (mru)' ,  'torustree#frigate#mru'],
			\ ['go to locate result' ,  'torustree#frigate#locate'],
			\ ['go to find result' ,  'torustree#frigate#find'],
			\ ['go to async find result' ,  'torustree#frigate#async_find'],
			\ ]
lockvar! s:menu_search_file

if exists('s:menu_search_inside_file')
	unlockvar! s:menu_search_inside_file
endif
let s:menu_search_inside_file = [
			\ ['go to matching line (occur)' ,  'torustree#frigate#occur'],
			\ ['go to grep result' ,  'torustree#frigate#grep()'],
			\ ['go to outline result' ,  'torustree#frigate#outline()'],
			\ ]
lockvar! s:menu_search_inside_file

if exists('s:menu_yank')
	unlockvar! s:menu_yank
endif
let s:menu_yank = [
			\ ['yank torustree in list mode' ,  "torustree#clipper#yank('list')"],
			\ ['yank torustree in plain mode' ,  "torustree#clipper#yank('plain')"],
			\ ]
lockvar! s:menu_yank

if exists('s:menu_undo')
	unlockvar! s:menu_undo
endif
let s:menu_undo = [
			\ ['undo list' ,  'torustree#triangle#undolist'],
			\ ]
lockvar! s:menu_undo

if exists('s:menu_command')
	unlockvar! s:menu_command
endif
let s:menu_command = [
			\ [':ex or !shell command output', 'torustree#mandala#command'],
			\ ['async shell command output' ,  'torustree#mandala#async'],
			\ ]
lockvar! s:menu_command

if exists('s:menu_dedicated_buffers')
	unlockvar! s:menu_dedicated_buffers
endif
let s:menu_dedicated_buffers = [
			\ ['add new dedicated buffer', 'torustree#cylinder#add()'],
			\ ['delete current dedicated buffer', 'torustree#cylinder#add()'],
			\ ['switch dedicated buffer', 'torustree#cylinder#switch()'],
			\ ]
lockvar! s:menu_dedicated_buffers

if exists('s:menu_layout')
	unlockvar! s:menu_layout
endif
let s:menu_layout = [
			\ ['zoom ,  one tab, one window', 'torustree#mosaic#zoom()'],
			\ ['rotate windows clockwise' ,  'torustree#mosaic#rotate_clockwise()'],
			\ ['rotate windows counter-clockwise' ,  'torustree#mosaic#rotate_counter_clockwise()'],
			\ ]
lockvar! s:menu_layout

if exists('s:menu_layout_tabs')
	unlockvar! s:menu_layout_tabs
endif
let s:menu_layout_tabs = [
			\ ['toruses on tabs' ,  "torustree#mosaic#tabs('torus')"],
			\ ['circles on tabs' ,  "torustree#mosaic#tabs('circle')"],
			\ ['locations on tabs' ,  "torustree#mosaic#tabs('location')"],
			\ ]
lockvar! s:menu_layout_tabs

if exists('s:menu_layout_windows')
	unlockvar! s:menu_layout_windows
endif
let s:menu_layout_windows = [
			\ ['toruses on horizontal splits' ,  "torustree#mosaic#split('torus')"],
			\ ['circles on horizontal splits' ,  "torustree#mosaic#split('circle')"],
			\ ['locations on horizontal splits' ,  "torustree#mosaic#split('location')"],
			\ ['toruses on vertical splits' ,  "torustree#mosaic#split('torus', 'vertical')"],
			\ ['circles on vertical splits' ,  "torustree#mosaic#split('circle', 'vertical')"],
			\ ['locations on vertical splits' ,  "torustree#mosaic#split('location', 'vertical')"],
			\ ['toruses on splits, main top layout' ,  "torustree#mosaic#split('torus', 'main_top')"],
			\ ['circles on splits, main top layout' ,  "torustree#mosaic#split('circle', 'main_top')"],
			\ ['locations on splits, main top layout' ,  "torustree#mosaic#split('location', 'main_top')"],
			\ ['toruses on splits, main left layout' ,  "torustree#mosaic#split('torus', 'main_left')"],
			\ ['circles on splits, main left layout' ,  "torustree#mosaic#split('circle', 'main_left')"],
			\ ['locations on splits, main left layout' ,  "torustree#mosaic#split('location', 'main_left')"],
			\ ['toruses on splits, grid layout' ,  "torustree#mosaic#split_grid('torus')"],
			\ ['circles on splits, grid layout' ,  "torustree#mosaic#split_grid('circle')"],
			\ ['locations on splits, grid layout' ,  "torustree#mosaic#split_grid('location')"],
			\ ['toruses on splits, transposed grid layout' ,  "torustree#mosaic#split_transposed_grid('torus')"],
			\ ['circles on splits, transposed grid layout' ,  "torustree#mosaic#split_transposed_grid('circle')"],
			\ ['locations on splits, transposed grid layout' ,  "torustree#mosaic#split_transposed_grid('location')"],
			\ ['toruses on splits, golden horizontal' ,  "torustree#mosaic#golden('torus', 'horizontal')"],
			\ ['circles on splits, golden horizontal' ,  "torustree#mosaic#golden('circle', 'horizontal')"],
			\ ['locations on splits, golden horizontal' ,  "torustree#mosaic#golden('location', 'horizontal')"],
			\ ['toruses on splits, golden vertical' ,  "torustree#mosaic#golden('torus', 'vertical')"],
			\ ['circles on splits, golden vertical' ,  "torustree#mosaic#golden('circle', 'vertical')"],
			\ ['locations on splits, golden vertical' ,  "torustree#mosaic#golden('location', 'vertical')"],
			\ ['toruses on splits, golden left layout' ,  "torustree#mosaic#golden('torus', 'main_left')"],
			\ ['circles on splits, golden left layout' ,  "torustree#mosaic#golden('circle', 'main_left')"],
			\ ['locations on splits, golden left layout' ,  "torustree#mosaic#golden('location', 'main_left')"],
			\ ['toruses on splits, golden top layout' ,  "torustree#mosaic#golden('torus', 'main_top')"],
			\ ['circles on splits, golden top layout' ,  "torustree#mosaic#golden('circle', 'main_top')"],
			\ ['locations on splits, golden top layout' ,  "torustree#mosaic#golden('location', 'main_top')"],
			\ ]
lockvar! s:menu_layout_windows

if exists('s:menu_layout_mixed')
	unlockvar! s:menu_layout_mixed
endif
let s:menu_layout_mixed = [
			\ ['mix : toruses on tabs & circles on splits', "torustree#pyramid#steps('torus')"],
			\ ['mix : circles on tabs & locations on splits', "torustree#pyramid#steps('circle')"],
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
			\ 'torustree navigation',
			\ 'native navigation',
			\ 'organize torustree',
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
	let s:function = 'torustree#helm#submenu(' .. string(s:formated) .. ')'
	eval s:menu_meta->add([s:name, s:function])
endfor
lockvar! s:menu_meta

" ---- contextual menus

if exists('s:context_navigation')
	unlockvar! s:context_navigation
endif
let s:context_navigation = [
			\ ['open' ,  "torustree#boomerang#navigation('here')"],
			\ ['open in tab(s)' ,  "torustree#boomerang#navigation('tab')"],
			\ ['open in horizontal split(s)' ,  "torustree#boomerang#navigation('horizontal_split')"],
			\ ['open in vertical split(s)' ,  "torustree#boomerang#navigation('vertical_split')"],
			\ ['open in horizontal golden split(s)' ,  "torustree#boomerang#navigation('horizontal_golden')"],
			\ ['open in vertical golden split(s)' ,  "torustree#boomerang#navigation('vertical_golden')"],
			\ ]
lockvar! s:context_navigation

if exists('s:context_buffer')
	unlockvar! s:context_buffer
endif
let s:context_buffer = s:context_navigation + [
			\ ['delete' ,  "torustree#boomerang#buffer('delete')"],
			\ ['unload' ,  "torustree#boomerang#buffer('unload')"],
			\ ['wipe' ,  "torustree#boomerang#buffer('wipe')"],
			\ ['delete hidden buffers' ,  "torustree#boomerang#buffer('delete_hidden')"],
			\ ['wipe hidden buffers' ,  "torustree#boomerang#buffer('wipe_hidden')"],
			\ ]
lockvar! s:context_buffer

if exists('s:context_buffer_all')
	unlockvar! s:context_buffer_all
endif
let s:context_buffer_all = s:context_navigation + [
			\ ['delete' ,  "torustree#boomerang#buffer('delete')"],
			\ ['unload' ,  "torustree#boomerang#buffer('unload')"],
			\ ['wipe' ,  "torustree#boomerang#buffer('wipe')"],
			\ ['delete hidden buffers' ,  "torustree#boomerang#buffer('delete_hidden')"],
			\ ['wipe hidden buffers' ,  "torustree#boomerang#buffer('wipe_hidden')"],
			\ ['wipe all hidden buffers, including unlisted ones' ,  "torustree#boomerang#buffer('wipe_all_hidden')"],
			\ ]
lockvar! s:context_buffer_all

if exists('s:context_tabwin')
	unlockvar! s:context_tabwin
endif
let s:context_tabwin = [
			\ ['open' ,  "torustree#boomerang#tabwin('open')"],
			\ ['new tab' ,  "torustree#boomerang#tabwin('tabnew')"],
			\ ['close tab' ,  "torustree#boomerang#tabwin('tabclose')"],
			\ ['reorganize' ,  'torustree#mirror#reorg_tabwin'],
			\ ]
lockvar! s:context_tabwin

if exists('s:context_tabwin_tree')
	unlockvar! s:context_tabwin_tree
endif
let s:context_tabwin_tree = [
			\ ['open' ,  "torustree#boomerang#tabwin_tree('open')"],
			\ ['new tab' ,  "torustree#boomerang#tabwin_tree('tabnew')"],
			\ ['close tab' ,  "torustree#boomerang#tabwin_tree('tabclose')"],
			\ ['reorganize' ,  'torustree#mirror#reorg_tabwin'],
			\ ]
lockvar! s:context_tabwin_tree

if exists('s:context_grep')
	unlockvar! s:context_grep
endif
let s:context_grep = s:context_navigation + [
			\ ['edit mode' ,  "torustree#shadow#grep_edit()"],
			\ ['open quickfix' ,  "torustree#boomerang#grep('quickfix')"],
			\ ]
lockvar! s:context_grep

if exists('s:context_yank_list')
	unlockvar! s:context_yank_list
endif
let s:context_yank_list = [
			\ ['linewise paste before' ,  "torustree#boomerang#yank('linewise-before')"],
			\ ['linewise paste after' ,  "torustree#boomerang#yank('linewise-after')"],
			\ ['characterwise paste before' ,  "torustree#boomerang#yank('charwise-before')"],
			\ ['characterwise paste after' ,  "torustree#boomerang#yank('charwise-after')"],
			\ ['undo' ,  'torustree#codex#undo()'],
			\ ['redo' ,  'torustree#codex#redo()'],
			\ ]
lockvar! s:context_yank_list

if exists('s:context_yank_plain')
	unlockvar! s:context_yank_plain
endif
let s:context_yank_plain = [
			\ ['linewise paste before' ,  "torustree#boomerang#yank('linewise-before')"],
			\ ['linewise paste after' ,  "torustree#boomerang#yank('linewise-after')"],
			\ ['characterwise paste before' ,  "torustree#boomerang#yank('charwise-before')"],
			\ ['characterwise paste after' ,  "torustree#boomerang#yank('charwise-after')"],
			\ ['undo' ,  'torustree#codex#undo()'],
			\ ['redo' ,  'torustree#codex#redo()'],
			\ ]
lockvar! s:context_yank_plain

" ---- public interface

fun! torustree#quartz#fetch (varname, conversion = 'no-conversion')
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
		return torustree#matrix#items2dict ({varname})
	else
		return {varname}
	endif
endfun
