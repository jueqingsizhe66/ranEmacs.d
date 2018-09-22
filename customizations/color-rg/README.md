<img src="./screenshot/color-rg.png">

# What is color-rg?
color-rg is a search and refactoring tool based on ripgrep.

I'm a big fan of color-moccur.el, this extension's name is a tribute to color-moccur.el!

## Installation
Clone or download this repository (path of the folder is the `<path-to-color-rg>` used below).

In your `~/.emacs`, add the following two lines:
```Elisp
(add-to-list 'load-path "<path-to-color-rg>") ; add color-rg to your load-path
(require 'color-rg)
```

If you use Mac, you also need to install [exec-path-from-shell](https://github.com/purcell/exec-path-from-shell)

## Usage
Bind your favorite key to functions:

| Function                      | Description                                  |
| :--------                     | :----                                        |
| color-rg-search-input         | Search user's input with current directory   |
| color-rg-search-symbol        | Search current symbol with current directory |
| color-rg-search-project       | Search user's input in project               |
| color-rg-search-project-rails | Search user's input in rails project         |

### Keymap for view mode

| Key        | Description                                     |
| :--------: | :----                                           |
| C-a        | Jump to first editable position of current line |
| j          | Jump to next match keyword                      |
| k          | Jump to previous match keyword                  |
| h          | Jump to next match file                         |
| l          | Jump to previous match file                     |
| RET        | Open file relative to match line                |
| r          | Replace all matches                             |
| f          | Filter results match regexp                     |
| F          | Filter results not match regexp                 |
| x          | Filter results match file extension             |
| X          | Filter results not match file extension         |
| D          | Delete current line from results                |
| s          | Re-search with new keyword and default argument |
| d          | Re-search with new directory                    |
| i          | Toggle to include or exclude the ignore files   |
| c          | Toggle to smart case or case sensitive          |
| t          | Re-search pattern as literal                    |
| m          | Re-search with customized rg argument           |
| e          | Enable edit mode                                |
| q          | Quit                                            |

### Keymap for edit mode

| Key        | Description                                     |
| :--------: | :----                                           |
| C-a        | Jump to first editable position of current line |
| C-c C-j    | Jump to next match keyword                      |
| C-c C-k    | Jump to previous match keyword                  |
| C-c C-h    | Jump to next match file                         |
| C-c C-l    | Jump to previous match file                     |
| C-c C-RET  | Open file relative to match line                |
| C-c C-d    | Delete current line                             |
| C-c C-r    | Recover current line                            |
| C-c C-R    | Recover buffer content                          |
| C-c C-q    | Quit                                            |
| C-c C-c    | Apply changed line to files                     |

### Work with isearch
Add this into your emacs config file:
```
(define-key isearch-mode-map (kbd "M-s M-s") 'isearch-toggle-color-rg)
```
When using `isearch-forward', type "M-s M-s" to search current isearch string with color-rg.

### Contributors

Thanks all [contributors](https://github.com/manateelazycat/color-rg/graphs/contributors) help this project.

Below is list of outstanding contributors:

[Xie Peng](https://github.com/pengpengxp) - Main contributor, wrote many patches to improve regexp/literal search.
