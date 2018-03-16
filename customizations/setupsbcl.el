(setq inferior-lisp-program "~/.emacs.d/customizations/sbcl/sbcl.exe");设置优先使用哪种Common Lisp实现
;(add-to-list 'load-path "~/.emacs.d/customizations/slime/");设置Slime路径
;(require 'slime)
;(slime-setup)
;(require 'slime-autoloads)
(add-to-list 'load-path "~/.emacs.d/customizations//slime")
(require 'slime)
(require 'slime-autoloads)
(setq slime-contribs '(slime-fancy));让slime变得更好看，比如把sbcl的*变成CL-USER>
