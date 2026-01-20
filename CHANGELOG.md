
# Version 3.8

Changes of keys :

- g:torustree_config.project_markers -> g:torustree_config.project.markers
- g:torustree_config.auto_chdir_project -> g:torustree_config.project.auto_chdir
- new key : g:torustree_config.storage.torustree.folder
- g:torustree_config.file -> g:torustree_config.storage.torustree.name
- g:torustree_config.autoread -> g:torustree_config.storage.torustree.autoread
- g:torustree_config.autowrite -> g:torustree_config.storage.torustree.autowrite
- g:torustree_config.session_dir -> g:torustree_config.storage.session.folder
- g:torustree_config.session_file -> g:torustree_config.storage.session.name
- g:torustree_config.autoread_session -> g:torustree_config.storage.session.autoread
- g:torustree_config.autowrite_session -> g:torustree_config.storage.session.autowrite
- g:torustree_config.backups -> g:torustree_config.storage.backups

# Version 3.7

Manage as many sessions files as you want.

Load & store all sessions from a session directory.

Default session file has changed :

- vim : '~/.vim/torustree/session/default.vim'
- nvim : '~/.local/share/nvim/torustree/session/default.vim'

# 2023 may 26

Little change in config :

g:torustree_config.display.message -> g:torustree_config.display.dedibuf_msg
