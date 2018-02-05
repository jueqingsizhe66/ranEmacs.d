;; Customizations relating to editing a buffer.

;; Key binding to use "hippie expand" for text autocompletion
;; http://www.emacswiki.org/emacs/HippieExpand
(global-set-key (kbd "M-/") 'hippie-expand)

;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; Highlights matching parenthesis
(show-paren-mode 1)

;; Highlight current line
(global-hl-line-mode 1)

;;(cua-mode 1)
;; Interactive search key bindings. By default, C-s runs
;; isearch-forward, so this swaps the bindings.
;(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Don't use hard tabs
(setq-default indent-tabs-mode nil)

;; When you visit a file, point goes to the last place where it
;; was when you previously visited the same file.
;; http://www.emacswiki.org/emacs/SavePlace
(require 'saveplace)
(setq-default save-place t)
;; keep track of saved places in ~/.emacs.d/places
(setq save-place-file (concat user-emacs-directory "places"))

;; Emacs can automatically create backup files. This tells Emacs to
;; put all backups in ~/.emacs.d/backups. More info:
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Backup-Files.html
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
(setq auto-save-default nil)


;; comments
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

;; yay rainbows!
;;(global-rainbow-delimiters-mode t)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; use 2 spaces for tabs
(defun die-tabs ()
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))

;; fix weird os x kill error
(defun ns-get-pasteboard ()
  "Returns the value of the pasteboard, or nil for unsupported formats."
  (condition-case nil
      (ns-get-selection-internal 'CLIPBOARD)
    (quit nil)))

(setq electric-indent-mode nil)






;; init expand-region
(require 'expand-region)
(global-unset-key (kbd "M--"))
(global-set-key (kbd "M-=") 'er/expand-region)
(global-set-key (kbd "M--") 'er/contract-region)

;; subsititude by compltee
;; init auto-complete
;;(require 'auto-complete-config)
;;(ac-config-default)



;; Rename file and buffer added on 2016/09/16

(defun rename-this-buffer-and-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (cond ((get-buffer new-name)
               (error "A buffer named '%s' already exists!" new-name))
              (t
               (rename-file filename new-name 1)
               (rename-buffer new-name)
               (set-visited-file-name new-name)
               (set-buffer-modified-p nil)
               (message "File '%s' successfully renamed to '%s'" name (file-name-nondirectory new-name))))))))

(global-set-key (kbd "C-c r") 'rename-this-buffer-and-file)

;; 璁剧疆瀛椾綋涓庣獥鍙ｅぇ灏
;; (set-default-font "Monaco 12")
;; (global-set-key (kbd "<f2>") 'toggle-frame-fullscreen)
(require 'hlinum)
(hlinum-activate)
(set-face-attribute 'linum nil :background nil)
(set-face-foreground 'linum "#f8f8f2")
(setq linum-format "%d ")
;; (set-face-attribute 'hl-line nil :foreground nil :background "#330")
(set-face-attribute 'hl-line nil :foreground nil :background "#353535")

;; 2017/7/13
(browse-kill-ring-default-keybindings)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; (("C-c m t" . mc/mark-all-like-this)            ;;
   ;;  ("C-c m m" . mc/mark-all-like-this-dwim)       ;;
   ;;  ("C-c m l" . mc/edit-lines)                    ;;
   ;;  ("C-c m e" . mc/edit-ends-of-lines)            ;;
   ;;  ("C-c m a" . mc/edit-beginnings-of-lines)      ;;
   ;;  ("C-c m n" . mc/mark-next-like-this)           ;;
   ;;  ("C-c m p" . mc/mark-previous-like-this)       ;;
   ;;  ("C-c m s" . mc/mark-sgml-tag-pair)            ;;
   ;;  ("C-c m d" . mc/mark-all-like-this-in-defun))) ;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(require 'evil-surround)
(global-evil-surround-mode 1)



;; company anything!
(add-hook 'after-init-hook 'global-company-mode)


(require 'key-chord)
(key-chord-mode 1)
;; Move to char similar to "f" in vim, f+g forward  d+f backward
(key-chord-define-global "tt" 'iy-go-to-char)
(key-chord-define-global "aa" 'iy-go-to-char-backward)


;;; add semicolon to end of line
;;(key-chord-define js-mode-map ";;" "\C-e;")
;(yas-minor-mode 1)
;;(yas-reload-all)
;;(yas-minor-mode)
;;(require 'yasnippet)


;; for move-text  which will define the M-up and M-down
;; to call move-text-up and move-text-down function
(move-text-default-bindings)



;; Jump to a definition in the current file. (This is awesome)
;;(global-set-key (kbd "C-x C-i") 'ido-imenu)



;(setq speed-of-thought-mode t)
(speed-of-thought-mode t)


(defun my/insert-line-before (times)
  "Insert a  newline(s) above the line containing the cursor."
  (interactive "p")
  (save-excursion 
    (move-beginning-of-line 1)
    (newline times))
  )

(global-set-key (kbd "C-c i") 'my/insert-line-before)



