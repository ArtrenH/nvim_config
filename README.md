# Neovim Config

Practical shortcut reference for this config. The leader key is `<Space>`.

## File Tree

Nvim-tree is the sidebar file browser.

| Shortcut / Command | Action |
| --- | --- |
| `<Space>e` | Toggle nvim-tree |
| `<Space>E` | Toggle hidden files in nvim-tree |
| `:NvimTreeToggle` | Toggle nvim-tree command |
| `<C-w>h` | Move focus left, usually into the tree |
| `<C-w>l` | Move focus right, usually back to the file |
| `<C-w>w` | Cycle through windows |

Common keys inside nvim-tree:

| Shortcut | Action |
| --- | --- |
| `Enter` / `o` | Open file or directory |
| `<C-t>` | Open file in a new tab |
| `a` | Create file or directory |
| `d` | Delete |
| `r` | Rename |
| `x` | Cut |
| `c` | Copy |
| `p` | Paste |
| `R` | Refresh tree |
| `H` | Toggle hidden files from inside the tree |
| `I` | Toggle gitignored files from inside the tree |
| `g?` | Show all nvim-tree mappings |
| `q` | Close the tree window |

## Windows And Tabs

| Shortcut / Command | Action |
| --- | --- |
| `<C-w>h` | Move to window on the left |
| `<C-w>j` | Move to window below |
| `<C-w>k` | Move to window above |
| `<C-w>l` | Move to window on the right |
| `<C-w>w` | Cycle through windows |
| `:tabnew` | Open a new empty tab |
| `:tabedit path/to/file` | Open a file in a new tab |
| `:tabclose` | Close current tab |
| `gt` | Next tab |
| `gT` | Previous tab |
| `3gt` | Go to tab 3 |

Vim tabs are more like workspaces than browser-style file tabs. Buffers are often better for switching between files.

| Command | Action |
| --- | --- |
| `:buffers` | List open buffers |
| `:bnext` | Next buffer |
| `:bprev` | Previous buffer |
| `:buffer 3` | Switch to buffer 3 |

## LSP

These mappings are active when an LSP server attaches.

| Shortcut | Action |
| --- | --- |
| `gd` | Go to definition |
| `gi` | Go to implementation |
| `K` | Show hover documentation |
| `<Space>rn` | Rename symbol |
| `<Space>ca` | Code action |

Configured language servers include `pyright`, `rust_analyzer`, `texlab`, and `emmet_ls`.

## Completion And Snippets

Completion uses `nvim-cmp`. Snippets use UltiSnips.

| Shortcut | Action |
| --- | --- |
| `<C-n>` | Select next completion item |
| `<C-p>` | Select previous completion item |
| `<C-Space>` | Open completion menu |
| `<C-e>` | Close completion menu |
| `<CR>` | Confirm selected completion |
| `<C-f>` | Scroll completion docs down |
| `<C-S-f>` | Scroll completion docs up |
| `<Tab>` | Expand or jump forward in an UltiSnips snippet |
| `<S-Tab>` | Previous completion item, or jump backward in a snippet |

## Plugin Commands

| Command | Plugin | Action |
| --- | --- | --- |
| `:Neogit` | Neogit | Open Git UI |
| `:LazyGit` | lazygit.nvim | Open LazyGit terminal UI |
| `:Trouble diagnostics` | Trouble | Show diagnostics list |
| `:Trouble qflist` | Trouble | Show quickfix list |
| `:Mason` | Mason | Manage language servers/tools |
| `:TagbarToggle` | Tagbar | Toggle code outline |
| `:Lazy` | lazy.nvim | Manage plugins |

## Git

LazyGit provides a full-screen terminal Git UI from inside Neovim. It requires the `lazygit` executable to be installed on the system.

| Shortcut / Command | Action |
| --- | --- |
| `<Space>gg` | Open LazyGit |
| `:LazyGit` | Open LazyGit command |
| `:Neogit` | Open Neogit |

## LaTeX / VimTeX

VimTeX uses the local leader, which is also `<Space>` in this config. Common VimTeX defaults include:

| Shortcut | Action |
| --- | --- |
| `<Space>ll` | Compile / toggle compiler |
| `<Space>lv` | View PDF |
| `<Space>lk` | Stop compiler |
| `<Space>le` | Show errors |
| `<Space>lt` | Table of contents |
| `<Space>lc` | Clean auxiliary files |

Use `:map <localleader>` or `:VimtexInfo` to inspect active VimTeX mappings.

## Discovery Commands

| Command | Action |
| --- | --- |
| `:map` | Show all mappings |
| `:nmap` | Show normal-mode mappings |
| `:imap` | Show insert-mode mappings |
| `:verbose map <Space>e` | Show where a mapping was defined |
| `g?` inside nvim-tree | Show nvim-tree mappings |
