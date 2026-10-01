" vim: set ft=vim fdm=indent iskeyword&:

" Geode
"
" Internal Constants for plugs & maps

" ---- subprefixes

if exists('s:batch')
	unlockvar! s:batch
endif
let s:batch = '@'
lockvar! s:batch

if exists('s:async')
	unlockvar! s:async
endif
let s:async = '&'
lockvar! s:async

if exists('s:layout')
	unlockvar! s:layout
endif
let s:layout = 'z'
lockvar! s:layout

if exists('s:debug')
	unlockvar! s:debug
endif
let s:debug = 'Z'
lockvar! s:debug

" ---- plugs

if exists('s:plugs_normal')
	unlockvar! s:plugs_normal
endif
let s:plugs_normal = [
			\ [ 'torustree-help-mappings'                     , 'torustree#guru#mappings'                                 ] ,
			\ [ 'torustree-menu-main'                         , 'torustree#helm#main'                                     ] ,
			\ [ 'torustree-menu-meta'                         , 'torustree#helm#meta'                                     ] ,
			\ [ 'torustree-info'                              , 'torustree#status#dashboard'                              ] ,
			\ [ 'torustree-sync-up'                           , 'torustree#projection#follow'                             ] ,
			\ [ 'torustree-sync-down'                         , 'torustree#vortex#jump'                                   ] ,
			\ [ 'torustree-prompt-read-torustree'                 , 'torustree#disc#read_torustree'                               ] ,
			\ [ 'torustree-prompt-write-torustree'                , 'torustree#disc#write_torustree'                              ] ,
			\ [ 'torustree-prompt-read-session'               , 'torustree#disc#read_session'                             ] ,
			\ [ 'torustree-prompt-write-session'              , 'torustree#disc#write_session'                            ] ,
			\ [ 'torustree-previous-location'                 , "torustree#vortex#previous('location')"                   ] ,
			\ [ 'torustree-next-location'                     , "torustree#vortex#next('location')"                       ] ,
			\ [ 'torustree-previous-circle'                   , "torustree#vortex#previous('circle')"                     ] ,
			\ [ 'torustree-next-circle'                       , "torustree#vortex#next('circle')"                         ] ,
			\ [ 'torustree-previous-torus'                    , "torustree#vortex#previous('torus')"                      ] ,
			\ [ 'torustree-next-torus'                        , "torustree#vortex#next('torus')"                          ] ,
			\ [ 'torustree-prompt-location'                   , "torustree#vortex#switch('location')"                     ] ,
			\ [ 'torustree-prompt-circle'                     , "torustree#vortex#switch('circle')"                       ] ,
			\ [ 'torustree-prompt-torus'                      , "torustree#vortex#switch('torus')"                        ] ,
			\ [ 'torustree-prompt-multi-switch'               , 'torustree#vortex#multi_switch'                           ] ,
			\ [ 'torustree-dedibuf-location'                  , "torustree#whirl#switch('location')"                      ] ,
			\ [ 'torustree-dedibuf-circle'                    , "torustree#whirl#switch('circle')"                        ] ,
			\ [ 'torustree-dedibuf-torus'                     , "torustree#whirl#switch('torus')"                         ] ,
			\ [ 'torustree-prompt-index'                      , 'torustree#vortex#helix'                                  ] ,
			\ [ 'torustree-prompt-index-circles'              , 'torustree#vortex#grid'                                   ] ,
			\ [ 'torustree-dedibuf-index'                     , 'torustree#whirl#helix'                                   ] ,
			\ [ 'torustree-dedibuf-index-circles'             , 'torustree#whirl#grid'                                    ] ,
			\ [ 'torustree-dedibuf-index-tree'                , 'torustree#whirl#tree'                                    ] ,
			\ [ 'torustree-history-newer'                     , 'torustree#waterclock#newer'                              ] ,
			\ [ 'torustree-history-older'                     , 'torustree#waterclock#older'                              ] ,
			\ [ 'torustree-history-newer-in-circle'           , "torustree#waterclock#newer('circle')"                    ] ,
			\ [ 'torustree-history-older-in-circle'           , "torustree#waterclock#older('circle')"                    ] ,
			\ [ 'torustree-history-newer-in-torus'            , "torustree#waterclock#newer('torus')"                     ] ,
			\ [ 'torustree-history-older-in-torus'            , "torustree#waterclock#older('torus')"                     ] ,
			\ [ 'torustree-prompt-history'                    , 'torustree#waterclock#history'                            ] ,
			\ [ 'torustree-dedibuf-history'                   , 'torustree#whirl#history'                                 ] ,
			\ [ 'torustree-alternate-anywhere'                , "torustree#caduceus#alternate('anywhere')"                ] ,
			\ [ 'torustree-alternate-same-torus'              , "torustree#caduceus#alternate('same_torus')"              ] ,
			\ [ 'torustree-alternate-same-circle'             , "torustree#caduceus#alternate('same_circle')"             ] ,
			\ [ 'torustree-alternate-other-torus'             , "torustree#caduceus#alternate('other_torus')"             ] ,
			\ [ 'torustree-alternate-other-circle'            , "torustree#caduceus#alternate('other_circle')"            ] ,
			\ [ 'torustree-alternate-same-torus-other-circle' , "torustree#caduceus#alternate('same_torus_other_circle')" ] ,
			\ [ 'torustree-alternate-window'                  , 'torustree#caduceus#alternate_window'                     ] ,
			\ [ 'torustree-alternate-menu'                    , 'torustree#caduceus#alternate_menu'                       ] ,
			\ [ 'torustree-prompt-frecency'                   , 'torustree#waterclock#frecency'                           ] ,
			\ [ 'torustree-dedibuf-frecency'                  , 'torustree#whirl#frecency'                                ] ,
			\ [ 'torustree-prompt-buffer'                     , 'torustree#sailing#buffer'                                ] ,
			\ [ 'torustree-dedibuf-buffer'                    , 'torustree#frigate#buffer'                                ] ,
			\ [ 'torustree-dedibuf-buffer-all'                , "torustree#frigate#buffer('all')"                         ] ,
			\ [ 'torustree-prompt-tabwin'                     , 'torustree#sailing#tabwin'                                ] ,
			\ [ 'torustree-dedibuf-tabwin'                    , 'torustree#frigate#tabwin'                                ] ,
			\ [ 'torustree-dedibuf-tabwin-tree'               , 'torustree#frigate#tabwin_tree'                           ] ,
			\ [ 'torustree-prompt-marker'                     , 'torustree#sailing#marker'                                ] ,
			\ [ 'torustree-prompt-jump'                       , 'torustree#sailing#jump'                                  ] ,
			\ [ 'torustree-prompt-change'                     , 'torustree#sailing#change'                                ] ,
			\ [ 'torustree-prompt-tag'                        , 'torustree#sailing#tag'                                   ] ,
			\ [ 'torustree-dedibuf-marker'                    , 'torustree#frigate#marker'                                ] ,
			\ [ 'torustree-dedibuf-jump'                      , 'torustree#frigate#jump'                                  ] ,
			\ [ 'torustree-dedibuf-change'                    , 'torustree#frigate#change'                                ] ,
			\ [ 'torustree-dedibuf-tag'                       , 'torustree#frigate#tag'                                   ] ,
			\ [ 'torustree-prompt-add-here'                   , 'torustree#land#add_here'                                 ] ,
			\ [ 'torustree-prompt-add-circle'                 , 'torustree#land#add_circle'                               ] ,
			\ [ 'torustree-prompt-add-torus'                  , 'torustree#land#add_torus'                                ] ,
			\ [ 'torustree-prompt-add-file'                   , 'torustree#land#add_file'                                 ] ,
			\ [ 'torustree-prompt-add-buffer'                 , 'torustree#land#add_buffer'                               ] ,
			\ [ 'torustree-prompt-add-glob'                   , 'torustree#land#add_glob'                                 ] ,
			\ [ 'torustree-dedibuf-reorder-location'          , "torustree#yggdrasil#reorder('location')"                 ] ,
			\ [ 'torustree-dedibuf-reorder-circle'            , "torustree#yggdrasil#reorder('circle')"                   ] ,
			\ [ 'torustree-dedibuf-reorder-torus'             , "torustree#yggdrasil#reorder('torus')"                    ] ,
			\ [ 'torustree-prompt-rename-location'            , "torustree#land#rename('location')"                       ] ,
			\ [ 'torustree-prompt-rename-circle'              , "torustree#land#rename('circle')"                         ] ,
			\ [ 'torustree-prompt-rename-torus'               , "torustree#land#rename('torus')"                          ] ,
			\ [ 'torustree-prompt-rename-file'                , 'torustree#land#rename_file'                              ] ,
			\ [ 'torustree-dedibuf-rename-location'           , "torustree#yggdrasil#rename('location')"                  ] ,
			\ [ 'torustree-dedibuf-rename-circle'             , "torustree#yggdrasil#rename('circle')"                    ] ,
			\ [ 'torustree-dedibuf-rename-torus'              , "torustree#yggdrasil#rename('torus')"                     ] ,
			\ [ 'torustree-dedibuf-rename-location-filename'  , 'torustree#yggdrasil#rename_file'                         ] ,
			\ [ 'torustree-prompt-delete-location'            , "torustree#land#delete('location')"                       ] ,
			\ [ 'torustree-prompt-delete-circle'              , "torustree#land#delete('circle')"                         ] ,
			\ [ 'torustree-prompt-delete-torus'               , "torustree#land#delete('torus')"                          ] ,
			\ [ 'torustree-dedibuf-delete-location'           , "torustree#yggdrasil#delete('location')"                  ] ,
			\ [ 'torustree-dedibuf-delete-circle'             , "torustree#yggdrasil#delete('circle')"                    ] ,
			\ [ 'torustree-dedibuf-delete-torus'              , "torustree#yggdrasil#delete('torus')"                     ] ,
			\ [ 'torustree-prompt-copy-location'              , "torustree#land#copy('location')"                         ] ,
			\ [ 'torustree-prompt-copy-circle'                , "torustree#land#copy('circle')"                           ] ,
			\ [ 'torustree-prompt-copy-torus'                 , "torustree#land#copy('torus')"                            ] ,
			\ [ 'torustree-prompt-move-location'              , "torustree#land#move('location')"                         ] ,
			\ [ 'torustree-prompt-move-circle'                , "torustree#land#move('circle')"                           ] ,
			\ [ 'torustree-dedibuf-copy-move-location'        , "torustree#yggdrasil#copy_move('location')"               ] ,
			\ [ 'torustree-dedibuf-copy-move-circle'          , "torustree#yggdrasil#copy_move('circle')"                 ] ,
			\ [ 'torustree-dedibuf-copy-move-torus'           , "torustree#yggdrasil#copy_move('torus')"                  ] ,
			\ [ 'torustree-dedibuf-reorganize'                , 'torustree#yggdrasil#reorganize'                          ] ,
			\ [ 'torustree-dedibuf-reorg-tabwin'              , 'torustree#mirror#reorg_tabwin'                           ] ,
			\ [ 'torustree-dedibuf-grep-edit'                 , 'torustree#shadow#grep_edit'                              ] ,
			\ [ 'torustree-dedibuf-narrow'                    , 'torustree#shadow#narrow_file'                            ] ,
			\ [ 'torustree-dedibuf-narrow-circle'             , 'torustree#shadow#narrow_circle'                          ] ,
			\ [ 'torustree-prompt-find'                       , 'torustree#sailing#find'                                  ] ,
			\ [ 'torustree-dedibuf-find'                      , 'torustree#frigate#find'                                  ] ,
			\ [ 'torustree-dedibuf-async-find'                , 'torustree#frigate#async_find'                            ] ,
			\ [ 'torustree-prompt-mru'                        , 'torustree#sailing#mru'                                   ] ,
			\ [ 'torustree-dedibuf-mru'                       , 'torustree#frigate#mru'                                   ] ,
			\ [ 'torustree-dedibuf-locate'                    , 'torustree#frigate#locate'                                ] ,
			\ [ 'torustree-prompt-occur'                      , 'torustree#sailing#occur'                                 ] ,
			\ [ 'torustree-dedibuf-occur'                     , 'torustree#frigate#occur'                                 ] ,
			\ [ 'torustree-dedibuf-grep'                      , 'torustree#frigate#grep'                                  ] ,
			\ [ 'torustree-prompt-outline'                    , 'torustree#sailing#outline'                               ] ,
			\ [ 'torustree-dedibuf-outline'                   , 'torustree#frigate#outline'                               ] ,
			\ [ 'torustree-prompt-switch-default-register'    , 'torustree#codex#switch_default_register'                 ] ,
			\ [ 'torustree-prompt-yank-plain-linewise-after'  , 'torustree#codex#yank_plain'                              ] ,
			\ [ 'torustree-prompt-yank-plain-charwise-after'  , "torustree#codex#yank_plain('charwise-after')"            ] ,
			\ [ 'torustree-prompt-yank-plain-linewise-before' , "torustree#codex#yank_plain('linewise-before')"           ] ,
			\ [ 'torustree-prompt-yank-plain-charwise-before' , "torustree#codex#yank_plain('charwise-before')"           ] ,
			\ [ 'torustree-prompt-yank-list-linewise-after'   , 'torustree#codex#yank_list'                               ] ,
			\ [ 'torustree-prompt-yank-list-charwise-after'   , "torustree#codex#yank_list('charwise-after')"             ] ,
			\ [ 'torustree-prompt-yank-list-linewise-before'  , "torustree#codex#yank_list('linewise-before')"            ] ,
			\ [ 'torustree-prompt-yank-list-charwise-before'  , "torustree#codex#yank_list('charwise-before')"            ] ,
			\ [ 'torustree-dedibuf-yank-plain'                , "torustree#clipper#yank('plain')"                         ] ,
			\ [ 'torustree-dedibuf-yank-list'                 , "torustree#clipper#yank('list')"                          ] ,
			\ [ 'torustree-dedibuf-undo-list'                 , 'torustree#triangle#undolist'                             ] ,
			\ [ 'torustree-dedibuf-command'                   , 'torustree#mandala#command'                               ] ,
			\ [ 'torustree-dedibuf-async'                     , 'torustree#mandala#async'                                 ] ,
			\ [ 'torustree-mandala-add'                       , "torustree#cylinder#add('furtive')"                       ] ,
			\ [ 'torustree-mandala-delete'                    , 'torustree#cylinder#delete'                               ] ,
			\ [ 'torustree-mandala-forward'                   , 'torustree#cylinder#forward'                              ] ,
			\ [ 'torustree-mandala-backward'                  , 'torustree#cylinder#backward'                             ] ,
			\ [ 'torustree-mandala-switch'                    , 'torustree#cylinder#switch'                               ] ,
			\ [ 'torustree-layout-zoom'                       , 'torustree#mosaic#zoom'                                   ] ,
			\ [ 'torustree-layout-tabs-locations'             , "torustree#mosaic#tabs('location')"                       ] ,
			\ [ 'torustree-layout-tabs-circles'               , "torustree#mosaic#tabs('circle')"                         ] ,
			\ [ 'torustree-layout-tabs-toruses'               , "torustree#mosaic#tabs('torus')"                          ] ,
			\ [ 'torustree-layout-split-locations'            , "torustree#mosaic#split('location')"                      ] ,
			\ [ 'torustree-layout-split-circles'              , "torustree#mosaic#split('circle')"                        ] ,
			\ [ 'torustree-layout-split-toruses'              , "torustree#mosaic#split('torus')"                         ] ,
			\ [ 'torustree-layout-vsplit-locations'           , "torustree#mosaic#split('location', 'vertical')"          ] ,
			\ [ 'torustree-layout-vsplit-circles'             , "torustree#mosaic#split('circle', 'vertical')"            ] ,
			\ [ 'torustree-layout-vsplit-toruses'             , "torustree#mosaic#split('torus', 'vertical')"             ] ,
			\ [ 'torustree-layout-main-top-locations'         , "torustree#mosaic#split('location', 'main_top')"          ] ,
			\ [ 'torustree-layout-main-top-circles'           , "torustree#mosaic#split('circle', 'main_top')"            ] ,
			\ [ 'torustree-layout-main-top-toruses'           , "torustree#mosaic#split('torus', 'main_top')"             ] ,
			\ [ 'torustree-layout-main-left-locations'        , "torustree#mosaic#split('location', 'main_left')"         ] ,
			\ [ 'torustree-layout-main-left-circles'          , "torustree#mosaic#split('circle', 'main_left')"           ] ,
			\ [ 'torustree-layout-main-left-toruses'          , "torustree#mosaic#split('torus', 'main_left')"            ] ,
			\ [ 'torustree-layout-grid-locations'             , "torustree#mosaic#split_grid('location')"                 ] ,
			\ [ 'torustree-layout-grid-circles'               , "torustree#mosaic#split_grid('circle')"                   ] ,
			\ [ 'torustree-layout-grid-toruses'               , "torustree#mosaic#split_grid('torus')"                    ] ,
			\ [ 'torustree-layout-tab-win-torus'              , "torustree#pyramid#steps('torus')"                        ] ,
			\ [ 'torustree-layout-tab-win-circle'             , "torustree#pyramid#steps('circle')"                       ] ,
			\ [ 'torustree-layout-rotate-counter-clockwise'   , 'torustree#mosaic#rotate_counter_clockwise'               ] ,
			\ [ 'torustree-layout-rotate-clockwise'           , 'torustree#mosaic#rotate_clockwise'                       ] ,
			\ [ 'torustree-spiral-cursor'                     , 'torustree#spiral#cursor'                                 ] ,
			\ [ 'torustree-debug-fresh-torustree'                 , 'torustree#void#fresh_torustree'                              ] ,
			\ [ 'torustree-debug-clear-echo-area'             , 'torustree#status#clear'                                  ] ,
			\ [ 'torustree-debug-clear-messages'              , 'torustree#status#clear_messages'                         ] ,
			\ [ 'torustree-debug-clear-signs'                 , 'torustree#chakra#clear'                                  ] ,
			\ [ 'torustree-debug-prompt-history-circuit'      , 'torustree#waterclock#history_circuit'                    ] ,
			\ [ 'torustree-debug-dedibuf-history-circuit'     , 'torustree#whirl#history_circuit'                         ] ,
			\ ]
lockvar! s:plugs_normal

if exists('s:plugs_visual')
	unlockvar! s:plugs_visual
endif
let s:plugs_visual = [
			\ [ 'torustree-dedibuf-narrow', 'torustree#shadow#narrow_file' ],
			\ ]
lockvar! s:plugs_visual

if exists('s:plugs_expr')
	unlockvar! s:plugs_expr
endif
let s:plugs_expr = [
			\ [ 'torustree-dedibuf-narrow-operator', 'torustree#shadow#narrow_file_operator' ],
			\ ]
lockvar! s:plugs_expr

" ---- maps

if exists('s:maps_level_0_normal')
	unlockvar! s:maps_level_0_normal
endif
let s:maps_level_0_normal = [
			\ [ '?'            , 'torustree-help-mappings'                      ] ,
			\ [ '<m-m>'        , 'torustree-menu-main'                          ] ,
			\ [ '='            , 'torustree-menu-meta'                          ] ,
			\ [ 'i'            , 'torustree-info'                               ] ,
			\ [ '<m-$>'        , 'torustree-sync-up'                            ] ,
			\ [ '$'            , 'torustree-sync-down'                          ] ,
			\ [ 'r'            , 'torustree-prompt-read-torustree'                  ] ,
			\ [ 'w'            , 'torustree-prompt-write-torustree'                 ] ,
			\ [ 'R'            , 'torustree-prompt-read-session'                ] ,
			\ [ 'W'            , 'torustree-prompt-write-session'               ] ,
			\ [ '<pageup>'     , 'torustree-previous-location'                  ] ,
			\ [ '<pagedown>'   , 'torustree-next-location'                      ] ,
			\ [ '<c-pageup>'   , 'torustree-previous-circle'                    ] ,
			\ [ '<c-pagedown>' , 'torustree-next-circle'                        ] ,
			\ [ '<s-pageup>'   , 'torustree-previous-torus'                     ] ,
			\ [ '<s-pagedown>' , 'torustree-next-torus'                         ] ,
			\ [ '<home>'       , 'torustree-history-newer'                      ] ,
			\ [ '<end>'        , 'torustree-history-older'                      ] ,
			\ [ '<c-home>'     , 'torustree-history-newer-in-circle'            ] ,
			\ [ '<c-end>'      , 'torustree-history-older-in-circle'            ] ,
			\ [ '<s-home>'     , 'torustree-history-newer-in-torus'             ] ,
			\ [ '<s-end>'      , 'torustree-history-older-in-torus'             ] ,
			\ [ '<c-^>'        , 'torustree-alternate-anywhere'                 ] ,
			\ [ '<m-^>'        , 'torustree-alternate-same-circle'              ] ,
			\ [ '<m-c-^>'      , 'torustree-alternate-same-torus-other-circle'  ] ,
			\ [ '^'            , 'torustree-alternate-menu'                     ] ,
			\ [ 'ah'           , 'torustree-prompt-add-here'                    ] ,
			\ [ 'af'           , 'torustree-prompt-add-file'                    ] ,
			\ [ 'ab'           , 'torustree-prompt-add-buffer'                  ] ,
			\ [ 'a*'           , 'torustree-prompt-add-glob'                    ] ,
			\ [ 'at'           , 'torustree-prompt-add-tree'                    ] ,
			\ ]
lockvar! s:maps_level_0_normal

if exists('s:maps_level_1_normal')
	unlockvar! s:maps_level_1_normal
endif
let s:maps_level_1_normal = [
			\ [ '<cr>'             , 'torustree-prompt-location'                  ],
			\ [ '<c-cr>'           , 'torustree-prompt-circle'                    ],
			\ [ '<s-cr>'           , 'torustree-prompt-torus'                     ],
			\ [ '<m-cr>'           , 'torustree-prompt-multi-switch'              ],
			\ [ '<space>'          , 'torustree-dedibuf-location'                 ],
			\ [ '<c-space>'        , 'torustree-dedibuf-circle'                   ],
			\ [ '<s-space>'        , 'torustree-dedibuf-torus'                    ],
			\ [ 'x'                , 'torustree-prompt-index'                     ],
			\ [ '<c-x>'            , 'torustree-prompt-index-circles'             ],
			\ [ 'X'                , 'torustree-dedibuf-index'                    ],
			\ [ '<m-x>'            , 'torustree-dedibuf-index-tree'               ],
			\ [ '<m-s-x>'          , 'torustree-dedibuf-index-circles'            ],
			\ [ 'h'                , 'torustree-prompt-history'                   ],
			\ [ '<m-h>'            , 'torustree-dedibuf-history'                  ],
			\ [ 'e'                , 'torustree-prompt-frecency'                  ],
			\ [ '<m-e>'            , 'torustree-dedibuf-frecency'                 ],
			\ [ s:batch .. 'o'     , 'torustree-dedibuf-reorder-location'         ],
			\ [ s:batch .. '<c-o>' , 'torustree-dedibuf-reorder-circle'           ],
			\ [ s:batch .. 'O'     , 'torustree-dedibuf-reorder-torus'            ],
			\ [ 'n'                , 'torustree-prompt-rename-location'           ],
			\ [ '<c-n>'            , 'torustree-prompt-rename-circle'             ],
			\ [ 'N'                , 'torustree-prompt-rename-torus'              ],
			\ [ '<m-n>'            , 'torustree-prompt-rename-file'               ],
			\ [ s:batch .. 'n'     , 'torustree-dedibuf-rename-location'          ],
			\ [ s:batch .. '<c-n>' , 'torustree-dedibuf-rename-circle'            ],
			\ [ s:batch .. 'N'     , 'torustree-dedibuf-rename-torus'             ],
			\ [ s:batch .. '<m-n>' , 'torustree-dedibuf-rename-location-filename' ],
			\ [ 'd'                , 'torustree-prompt-delete-location'           ],
			\ [ '<c-d>'            , 'torustree-prompt-delete-circle'             ],
			\ [ 'D'                , 'torustree-prompt-delete-torus'              ],
			\ [ s:batch .. 'd'     , 'torustree-dedibuf-delete-location'          ],
			\ [ s:batch .. '<c-d>' , 'torustree-dedibuf-delete-circle'            ],
			\ [ s:batch .. 'D'     , 'torustree-dedibuf-delete-torus'             ],
			\ [ 'c'                , 'torustree-prompt-copy-location'             ],
			\ [ '<m-c>'            , 'torustree-prompt-copy-circle'               ],
			\ [ 'C'                , 'torustree-prompt-copy-torus'                ],
			\ [ 'm'                , 'torustree-prompt-move-location'             ],
			\ [ 'M'                , 'torustree-prompt-move-circle'               ],
			\ [ s:batch .. 'c'     , 'torustree-dedibuf-copy-move-location'       ],
			\ [ s:batch .. '<m-c>' , 'torustree-dedibuf-copy-move-circle'         ],
			\ [ s:batch .. 'C'     , 'torustree-dedibuf-copy-move-torus'          ],
			\ ]
lockvar! s:maps_level_1_normal

if exists('s:maps_level_2_normal')
	unlockvar! s:maps_level_2_normal
endif
let s:maps_level_2_normal = [
			\ [ 'b'                  , 'torustree-prompt-buffer'                     ] ,
			\ [ '<m-b>'              , 'torustree-dedibuf-buffer'                    ] ,
			\ [ '<c-b>'              , 'torustree-dedibuf-buffer-all'                ] ,
			\ [ 'v'                  , 'torustree-prompt-tabwin'                     ] ,
			\ [ '<m-v>'              , 'torustree-dedibuf-tabwin-tree'               ] ,
			\ [ '<c-v>'              , 'torustree-dedibuf-tabwin'                    ] ,
			\ [ "'"                  , 'torustree-prompt-marker'                     ] ,
			\ [ 'j'                  , 'torustree-prompt-jump'                       ] ,
			\ [ ','                  , 'torustree-prompt-change'                     ] ,
			\ [ 't'                  , 'torustree-prompt-tag'                        ] ,
			\ [ "<m-'>"              , 'torustree-dedibuf-marker'                    ] ,
			\ [ '<m-j>'              , 'torustree-dedibuf-jump'                      ] ,
			\ [ ';'                  , 'torustree-dedibuf-change'                    ] ,
			\ [ '<m-t>'              , 'torustree-dedibuf-tag'                       ] ,
			\ [ '<m-r>'              , 'torustree-dedibuf-reorganize'                ] ,
			\ [ '<c-r>'              , 'torustree-dedibuf-reorg-tabwin'              ] ,
			\ [ '<m-g>'              , 'torustree-dedibuf-grep-edit'                 ] ,
			\ [ '-%'                 , 'torustree-dedibuf-narrow'                    ] ,
			\ [ '--'                 , 'torustree-dedibuf-narrow-operator'           ] ,
			\ [ '-c'                 , 'torustree-dedibuf-narrow-circle'             ] ,
			\ [ 'f'                  , 'torustree-prompt-find'                       ] ,
			\ [ '<m-f>'              , 'torustree-dedibuf-find'                      ] ,
			\ [ s:async .. 'f'       , 'torustree-dedibuf-async-find'                ] ,
			\ [ 'u'                  , 'torustree-prompt-mru'                        ] ,
			\ [ '<m-u>'              , 'torustree-dedibuf-mru'                       ] ,
			\ [ 'l'                  , 'torustree-dedibuf-locate'                    ] ,
			\ [ 'o'                  , 'torustree-prompt-occur'                      ] ,
			\ [ '<m-o>'              , 'torustree-dedibuf-occur'                     ] ,
			\ [ 'g'                  , 'torustree-dedibuf-grep'                      ] ,
			\ [ '<c-o>'              , 'torustree-prompt-outline'                    ] ,
			\ [ '<s-o>'              , 'torustree-dedibuf-outline'                   ] ,
			\ [ '<c-y>'              , 'torustree-prompt-switch-default-register'    ] ,
			\ [ 'y'                  , 'torustree-prompt-yank-plain-linewise-after'  ] ,
			\ [ 'p'                  , 'torustree-prompt-yank-plain-charwise-after'  ] ,
			\ [ 'Y'                  , 'torustree-prompt-yank-plain-linewise-before' ] ,
			\ [ 'P'                  , 'torustree-prompt-yank-plain-charwise-before' ] ,
			\ [ '<m-y>'              , 'torustree-dedibuf-yank-plain'                ] ,
			\ [ '<m-p>'              , 'torustree-dedibuf-yank-list'                 ] ,
			\ [ '<c-u>'              , 'torustree-dedibuf-undo-list'                 ] ,
			\ [ ':'                  , 'torustree-dedibuf-command'                   ] ,
			\ [ s:async .. '&'       , 'torustree-dedibuf-async'                     ] ,
			\ [ '<tab>'              , 'torustree-mandala-add'                       ] ,
			\ [ '<backspace>'        , 'torustree-mandala-delete'                    ] ,
			\ [ '<left>'             , 'torustree-mandala-backward'                  ] ,
			\ [ '<right>'            , 'torustree-mandala-forward'                   ] ,
			\ [ '<up>'               , 'torustree-mandala-switch'                    ] ,
			\ [ s:layout .. 'z'      , 'torustree-layout-zoom'                       ] ,
			\ [ s:layout .. 't'      , 'torustree-layout-tabs-locations'             ] ,
			\ [ s:layout .. '<c-t>'  , 'torustree-layout-tabs-circles'               ] ,
			\ [ s:layout .. 'T'      , 'torustree-layout-tabs-toruses'               ] ,
			\ [ s:layout .. 's'      , 'torustree-layout-split-locations'            ] ,
			\ [ s:layout .. '<c-s>'  , 'torustree-layout-split-circles'              ] ,
			\ [ s:layout .. 'S'      , 'torustree-layout-split-toruses'              ] ,
			\ [ s:layout .. 'v'      , 'torustree-layout-vsplit-locations'           ] ,
			\ [ s:layout .. '<c-v>'  , 'torustree-layout-vsplit-circles'             ] ,
			\ [ s:layout .. 'V'      , 'torustree-layout-vsplit-toruses'             ] ,
			\ [ s:layout .. 'm'      , 'torustree-layout-main-top-locations'         ] ,
			\ [ s:layout .. '<c-m>'  , 'torustree-layout-main-top-circles'           ] ,
			\ [ s:layout .. 'M'      , 'torustree-layout-main-top-toruses'           ] ,
			\ [ s:layout .. 'l'      , 'torustree-layout-main-left-locations'        ] ,
			\ [ s:layout .. '<c-l>'  , 'torustree-layout-main-left-circles'          ] ,
			\ [ s:layout .. 'L'      , 'torustree-layout-main-left-toruses'          ] ,
			\ [ s:layout .. 'g'      , 'torustree-layout-grid-locations'             ] ,
			\ [ s:layout .. '<c-g>'  , 'torustree-layout-grid-circles'               ] ,
			\ [ s:layout .. 'G'      , 'torustree-layout-grid-toruses'               ] ,
			\ [ s:layout .. '&'      , 'torustree-layout-tab-win-circle'             ] ,
			\ [ s:layout .. '<M-&>'  , 'torustree-layout-tab-win-torus'              ] ,
			\ [ s:layout .. '<up>'   , 'torustree-layout-rotate-counter-clockwise'   ] ,
			\ [ s:layout .. '<down>' , 'torustree-layout-rotate-clockwise'           ] ,
			\ ]
lockvar! s:maps_level_2_normal

if exists('s:maps_level_2_visual')
	unlockvar! s:maps_level_2_visual
endif
let s:maps_level_2_visual = [
			\ [ '--', 'torustree-dedibuf-narrow' ]
			\ ]
lockvar! s:maps_level_2_visual

if exists('s:maps_level_20_normal')
	unlockvar! s:maps_level_20_normal
endif
let s:maps_level_20_normal = [
			\ [ s:debug .. 'Z'     , 'torustree-debug-fresh-torustree'             ] ,
			\ [ s:debug .. 'e'     , 'torustree-debug-clear-echo-area'         ] ,
			\ [ s:debug .. 'm'     , 'torustree-debug-clear-messages'          ] ,
			\ [ s:debug .. 's'     , 'torustree-debug-clear-signs'             ] ,
			\ [ s:debug .. 'h'     , 'torustree-debug-prompt-history-circuit'  ] ,
			\ [ s:debug .. '<m-h>' , 'torustree-debug-dedibuf-history-circuit' ] ,
			\ ]
lockvar! s:maps_level_20_normal

" ---- public interface

fun! torustree#geode#fetch (varname, conversion = 'no-conversion')
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
