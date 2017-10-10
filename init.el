;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)

; (add-to-list 'package-archives
;              '("marmalade" . "http://marmalade-repo.org/packages/") t)
;
; (add-to-list 'package-archives
;              '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(add-to-list 'package-archives 
             '("org" . "http://orgmode.org/elpa/") t)

;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                          ("marmalade" . "http://marmalade-repo.org/packages/")
;;                          ("melpa" . "http://melpa-stable.milkbox.net/packages/")))


;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; Define he following variables to remove the compile-log warnings
;; when defining ido-ubiquitous
(defvar ido-cur-item nil)
(defvar ido-default-item nil)
(defvar ido-cur-list nil)
(defvar predicate nil)
(defvar inherit-input-method nil)

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; allow ido usage in as many contexts as possible. see    ;; customizations/navigation.el line 23 for a description
    ;; of ido
    ido-ubiquitous

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; git integration
    magit

    expand-region
    
   ;; auto-complete
    dracula-theme ;; color schme
    hlinum
    which-key
    restclient;;;restclinet mode
    browse-kill-ring

     neotree;;file list
     all-the-icons   ;;;you need to download fonts

     session
     markdown-mode+
     evil-surround
     ivy
     ivy-rich
     cal-china-x
    ;;complete anything
     company
     key-chord
     iy-go-to-char
     ace-jump-mode

     htmlize
     highlight-escape-sequences
     move-text

     flycheck
     flycheck-pos-tip
     flycheck-clojure
    ; use-package
     org-journal
     org-bullets
     org-tree-slide
     org-autolist
     ;;music
     emms
    ))

;; on OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")


;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")
;;for magnars folders
(add-to-list 'load-path "~/.emacs.d/customizations/magnars/")

(load "font-lock+.el")
;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; For editing lisps
(load "elisp-editing.el")
(load "scheme-editing.el")

;; Langauage-specific
(load "setup-clojure.el")
(load "setup-js.el")

(load "fortran-editing.el")
(load "fortran-index-args.el")

;; music
(load "setup-emms.el")
;;(require 'server)

(server-start)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("e297f54d0dc0575a9271bb0b64dad2c05cff50b510a518f5144925f627bb5832" default)))
 '(describe-char-unidata-list
   (quote
    (name old-name general-category decomposition numeric-value iso-10646-comment uppercase lowercase titlecase)))
 '(git-gutter:handled-backends (quote (svn hg git)))
 '(ispell-dictionary "british")
 '(ispell-program-name "C:\\Program Files (x86)\\Aspell\\bin\\aspell.exe")
 '(muse-project-alist
   (quote
    (("WikiPlanner"
      ("~/.emacs.d/GTD/myPlan/" :default "index" :major-mode planner-mode :visit-link planner-visit-link)))))
 '(package-selected-packages
   (quote
    (org-alert org-mind-map spaceline dired-narrow dired-ranger dired-rainbow dired-icon dired-subtree emms sotclojure sotlisp ox-reveal org-tree-slide pretty-symbols org-journal org-autolist org-babel-eval-in-repl org-bullets request-deferred fortpy web-mode flycheck-pos-tip flycheck-clojure counsel-projectile spacemacs-theme w3m use-package engine-mode simplezen zencoding-mode js2-mode move-text highlight-escape-sequences htmlize dired-details+ dired+ ace-jump-mode paredit-menu iy-go-to-char key-chord string-edit flycheck-perl6 company-anaconda company cal-china-x image+ 2048-game 0xc ivy-rich all-the-icons-ivy all-the-icons-dired ivy-dired-history ivy smart-mode-line mo-git-blame evil-surround markdown-mode+ scheme-complete chicken-scheme 0blayout org-plus-contrib cl-lib-highlight tagedit smex rainbow-delimiters projectile paredit magit ido-ubiquitous exec-path-from-shell clojure-mode-extra-font-locking cider)))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-document-title ((t (:inherit default :weight bold :foreground "#b2b2b2" :font "Source Sans Pro" :height 1.5 :underline nil))))
 '(org-done ((t (:foreground "PaleGreen" :weight normal :strike-through t))))
 '(org-headline-done ((((class color) (min-colors 16) (background dark)) (:foreground "LightSalmon" :strike-through t))))
 '(org-level-1 ((t (:inherit default :weight bold :foreground "#b2b2b2" :font "Source Sans Pro" :height 1.75))))
 '(org-level-2 ((t (:inherit default :weight bold :foreground "#b2b2b2" :font "Source Sans Pro" :height 1.5))))
 '(org-level-3 ((t (:inherit default :weight bold :foreground "#b2b2b2" :font "Source Sans Pro" :height 1.25))))
 '(org-level-4 ((t (:inherit default :weight bold :foreground "#b2b2b2" :font "Source Sans Pro" :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :foreground "#b2b2b2" :font "Source Sans Pro"))))
 '(org-level-6 ((t (:inherit default :weight bold :foreground "#b2b2b2" :font "Source Sans Pro"))))
 '(org-level-7 ((t (:inherit default :weight bold :foreground "#b2b2b2" :font "Source Sans Pro"))))
 '(org-level-8 ((t (:inherit default :weight bold :foreground "#b2b2b2" :font "Source Sans Pro"))))
 '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))



; (load
;  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
; 'noerror)
;
(setq default-directory "e:/clojure-home")
; (require 'org-install)
;
; ;; The following lines are always needed. Choose your own keys.
; (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
; (add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
; (global-set-key "\C-cl" 'org-store-link)
; (global-set-key "\C-ca" 'org-agenda)
; (global-set-key "\C-cb" 'org-iswitchb)
; (setq org-src-fontify-natively t)
;

;; my personal setup, other major-mode specific setup need it.
;; It's dependent on init-site-lisp.el
(if (file-exists-p "~/.emacs.d/.custom.el") (load-file "~/.emacs.d/.custom.el"))
(if (file-exists-p "~/.emacs.d/.orgConf.el") (load-file "~/.emacs.d/.orgConf.el"))


(require 'quantified)
;;不起作用
;(if (server-running-p)
;"server-running"
;(server-start))


;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
; '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))


(eval-after-load 'dired '(require 'setup-dired))
(require 'setup-yasnippet)
(eval-after-load 'markdown-mode '(require 'setup-markdown-mode))
(require 'setup-html-mode)
(eval-after-load 'js2-mode '(require 'setup-js2-mode))
(eval-after-load 'html-mode '(require 'zencoding-mode))
(eval-after-load 'flycheck '(require 'setup-flycheck))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (eval-when-compile       ;;
;;  (require 'use-package)) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;From Sasha Chua
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package engine-mode                                                                       ;; ;;
;;   :config                                                                                      ;; ;;
;;   (progn                                                                                       ;; ;;
;;     (defengine my-blog "https://www.google.ca/search?q=site:sachachua.com+%s" :keybinding "b") ;; ;;
;;     (defengine my-photos "http://www.flickr.com/search/?w=65214961@N00&q=%s" :keybinding "f")  ;; ;;
;;     (defengine mail "https://mail.google.com/mail/u/0/#search/%s" :keybinding "m")             ;; ;;
;;     (defengine google "http://google.com/search?q=%s" :keybinding "g")                         ;; ;;
;;     (defengine emacswiki "http://google.com/search?q=site:emacswiki.org+%s" :keybinding "e")   ;; ;;
;;     (bind-key* "C-c /" 'my/engine-mode-hydra/body)                                             ;; ;;
;;     (engine-mode))                                                                             ;; ;;
;;  )                                                                                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(find-file "~/.emacs.d/GTD/newgtd.org")


;;better bookmark
;;https://github.com/howardabrams/dot-files/blob/master/emacs.org
; (setq bookmark-save-flag 1)
; (defun ha/add-bookmark (name)
;   (interactive
;    (list (let* ((filename  (file-name-base (buffer-file-name)))
;                 (project   (projectile-project-name))
;                 (func-name (which-function))
;                 (initial   (format "%s::%s:%s " project filename func-name)))
;            (read-string "Bookmark: " initial))))
;   (bookmark-set name))
;
; (global-unset-key (kbd "C-x r m"))
; (global-unset-key (kbd "C-x r b"))
; (global-set-key (kbd "C-x r b") 'helm-bookmarks)
; (global-set-key (kbd "C-x r m") 'ha/add-bookmark)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package bookmark                                                           ;;
;;   :init                                                                         ;;
;;   :config                                                                       ;;
;;   (defun ha/add-bookmark (name)                                                 ;;
;;     (interactive                                                                ;;
;;      (list (let* ((filename  (file-name-base (buffer-file-name)))               ;;
;;                   (project   (projectile-project-name))                         ;;
;;                   (func-name (which-function))                                  ;;
;;                   (initial   (format "%s::%s:%s " project filename func-name))) ;;
;;              (read-string "Bookmark: " initial))))                              ;;
;;     (bookmark-set name))                                                        ;;
;;   :bind  (("C-c b m" . ha/add-bookmark)                                         ;;
;;           ("C-x r m" . ha/add-bookmark)                                         ;;
;;           ("C-x r b" . helm-bookmarks)))                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;https://www.emacswiki.org/emacs/PrettyGreek
 (defun pretty-greek ()
  (let ((greek '("alpha" "beta" "gamma" "delta" "epsilon" "zeta" "eta" "theta" "iota" "kappa" "lambda" "mu" "nu" "xi" "omicron" "pi" "rho" "sigma_final" "sigma" "tau" "upsilon" "phi" "chi" "psi" "omega")))
    (loop for word in greek
          for code = 97 then (+ 1 code)
          do  (let ((greek-char (make-char 'greek-iso8859-7 code))) 
                (font-lock-add-keywords nil
                                        `((,(concatenate 'string "\\(^\\|[^a-zA-Z0-9]\\)\\(" word "\\)[a-zA-Z]")
                                           (0 (progn (decompose-region (match-beginning 2) (match-end 2))
                                                     nil)))))
                (font-lock-add-keywords nil 
                                        `((,(concatenate 'string "\\(^\\|[^a-zA-Z0-9]\\)\\(" word "\\)[^a-zA-Z]")
                                           (0 (progn (compose-region (match-beginning 2) (match-end 2)
                                                                     ,greek-char)
                                                     nil)))))))))  (add-hook 'lisp-mode-hook 'pretty-greek)
  (add-hook 'emacs-lisp-mode-hook 'pretty-greek)


(set-language-environment "utf-8")


;(set-language-environment "Chinese-GB")

;(set-language-environment-charset "utf-8")
;(set-language-environment-coding-systems "utf-8")



