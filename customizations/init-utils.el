(eval-when-compile
  (require 'init-const)
  (require 'init-custom))

;; Display available keybindings in popup
(use-package which-key
  :diminish which-key-mode
  :bind (:map help-map ("C-h" . which-key-C-h-dispatch))
  :hook (after-init . which-key-mode))

;; Youdao Dictionay
(use-package youdao-dictionary
  :bind (("C-c y" . youdao-dictionary-search-at-point)
         ("C-c Y" . youdao-dictionary-search-at-point-tooltip))
  :config
  ;; Cache documents
  (setq url-automatic-caching t)

  ;; Enable Chinese word segmentation support (支持中文分词)
  (setq youdao-dictionary-use-chinese-word-segmentation t))

;; Search tools: `wgrep', `ag' and `rg'
(use-package wgrep
  :init
  (setq wgrep-auto-save-buffer t)
  (setq wgrep-change-readonly-file t))

(use-package ag
  :defines projectile-command-map
  :init
  (with-eval-after-load 'projectile
    (bind-key "s S" #'ag-project projectile-command-map))
  :config
  (setq ag-highlight-search t)
  (setq ag-reuse-buffers t)
  (use-package wgrep-ag))

(use-package rg
  :hook (after-init . rg-enable-default-bindings)
  :config
  (setq rg-group-result t)
  (setq rg-show-columns t)

  (cl-pushnew '("tmpl" . "*.tmpl") rg-custom-type-aliases)

  (use-package wgrep-ag
    :hook (rg-mode . wgrep-ag-setup))

  (with-eval-after-load 'projectile
    (defalias 'projectile-ripgrep 'rg-project)
    (bind-key "s R" #'rg-project projectile-command-map))

  (when (fboundp 'ag)
    (bind-key "a" #'ag rg-global-map))

  (with-eval-after-load 'counsel
    (bind-keys :map rg-global-map
               ("c r" . counsel-rg)
               ("c s" . counsel-ag)
               ("c p" . counsel-pt)
               ("c f" . counsel-fzf))))


(defun move-file (new-location)
  "Write this file to NEW-LOCATION, and delete the old one."
  (interactive (list (if buffer-file-name
                         (read-file-name "Move file to: ")
                       (read-file-name "Move file to: "
                                       default-directory
                                       (expand-file-name (file-name-nondirectory (buffer-name))
                                                         default-directory)))))
  (when (file-exists-p new-location)
    (delete-file new-location))
  (let ((old-location (buffer-file-name)))
    (write-file new-location t)
    (when (and old-location
               (file-exists-p new-location)
               (not (string-equal old-location new-location)))
      (delete-file old-location))))

(defvar my/move-file-here-start-dir (expand-file-name "~/"))
(defun my/move-file-here ()
  "Move file from somewhere else to here.
The file is taken from a start directory set by
`my/move-file-here-start-dir' and moved to the current directory
if invoked in dired, or else the directory containing current
buffer. The user is presented with a list of files in the start
directory, from which to select the file to move, sorted by most
recent first.
The short filename is copied to clipboard.
Quickly move a file to the current directory | Pragmatic Emacs
http://pragmaticemacs.com/emacs/quickly-move-a-file-to-the-current-directory/
"
  (interactive)
  (let (file-list target-dir file-list-sorted start-file start-file-full)
    ;; clean directories from list but keep times
    (setq file-list
          (-remove (lambda (x) (nth 1 x))
                   (directory-files-and-attributes my/move-file-here-start-dir)))

    ;; get target directory
    ;; http://ergoemacs.org/emacs/emacs_copy_file_path.html
    (setq target-dir
          (if (equal major-mode 'dired-mode)
              (expand-file-name default-directory)
            (if (null (buffer-file-name))
                (user-error "ERROR: current buffer is not associated with a file.")
              (file-name-directory (buffer-file-name)))))

    ;; sort list by most recent
    ;; http://stackoverflow.com/questions/26514437/emacs-sort-list-of-directories-files-by-modification-date
    (setq file-list-sorted
          (mapcar #'car
                  (sort file-list
                        #'(lambda (x y) (time-less-p (nth 6 y) (nth 6 x))))))

    ;; use ivy to select start-file
    (setq start-file (ivy-read
                      (concat "Move selected file to " target-dir ":")
                      file-list-sorted
                      :re-builder #'ivy--regex
                      :sort nil
                      :initial-input nil))

    ;; add full path to start file and end-file
    (setq start-file-full
          (expand-file-name start-file my/move-file-here-start-dir))
    (setq end-file
          (expand-file-name (file-name-nondirectory start-file) target-dir))
    (rename-file start-file-full end-file)
    ;; copy short filename to clipboard
    (kill-new start-file)
    (gui-set-selection 'PRIMARY start-file)
    (message "moved %s to %s" start-file-full end-file)))

(defun align-whitespace  (start  end)
       "Align            columns by whitespace"
       (interactive      "r")
       (align-regexp     start   end
       "\\(\\s-*\\)\\s-" 1       0  t))
(provide 'init-utils)
