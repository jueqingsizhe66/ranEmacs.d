;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.


;; "When several buffers visit identically-named files,
;; Emacs must give the buffers distinct names. The usual method
;; for making buffer names unique adds ‘<2>’, ‘<3>’, etc. to the end
;; of the buffer names (all but one of them).
;; The forward naming method includes part of the file's directory
;; name at the beginning of the buffer name
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Turn on recent file mode so that you can more easily switch to
;; recently edited files when you first start emacs
(setq recentf-save-file (concat user-emacs-directory ".recentf"))
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 40)


;; ido-mode allows you to more easily navigate choices. For example,
;; when you want to switch buffers, ido presents you with a list
;; of buffers in the the mini-buffer. As you start to type a buffer's
;; name, ido will narrow down the list of buffers to match the text
;; you've typed in
;; http://www.emacswiki.org/emacs/InteractivelyDoThings
(ido-mode t)

;; This allows partial matches, e.g. "tl" will match "Tyrion Lannister"
(setq ido-enable-flex-matching t)

;; Turn this behavior off because it's annoying
(setq ido-use-filename-at-point nil)

;; Don't try to match file across all "work" directories; only match files
;; in the current directory displayed in the minibuffer
(setq ido-auto-merge-work-directories-length -1)

;; Includes buffer names of recently open files, even if they're not
;; open now
(setq ido-use-virtual-buffers t)

;; This enables ido in all contexts where it could be useful, not just
;; for selecting buffer and file names
(ido-ubiquitous-mode 1)

;; Shows a list of buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)


;; Enhances M-x to allow easier execution of commands. Provides
;; a filterable list of possible commands in the minibuffer
;; http://www.emacswiki.org/emacs/Smex
(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;; projectile everywhere!
(projectile-global-mode)
(global-set-key (kbd "M-x") 'counsel-M-x)

;; moved to setup-ivy.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;Ivy-based interface to standard commands                  ;;
;;                                                             ;;
;; (global-unset-key (kbd "\C-s"))                             ;;
;; (global-set-key (kbd "\C-s") 'swiper)                       ;;
;; (global-set-key (kbd "M-x") 'counsel-M-x)                   ;;
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)         ;;
;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)  ;;
;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)  ;;
;; (global-set-key (kbd "<f1> l") 'counsel-find-library)       ;;
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol) ;;
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)       ;;
;;                                                             ;;
;; ;;Ivy-based interface to shell and system tools             ;;
;;                                                             ;;
;; (global-set-key (kbd "C-c g") 'counsel-git)                 ;;
;; (global-set-key (kbd "C-c j") 'counsel-git-grep)            ;;
;; (global-set-key (kbd "C-c k") 'counsel-ag)                  ;;
;; (global-set-key (kbd "C-x l") 'counsel-locate)              ;;
;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; <2018-09-22 16:49> company with emacs-wgrep  https://github.com/mhayashi1120/Emacs-wgrep
;; to edit buffer, then apply buffer to the file
(require 'wgrep)
(setq wgrep-auto-save-buffer t)
;; You can change the default key binding to switch to wgrep.
(setq wgrep-enable-key "r")
(setq wgrep-change-readonly-file t)
;;<2018-08-18 21:52>
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;Ivy-resume and other commands
;(require 'persp-projectiles)
;;(define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project)
;    ivy-resume resumes the last Ivy-based completion.

(global-set-key (kbd "C-c C-r") 'ivy-resume)


;; setting for ace-jump-mode 
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)


(global-set-key (kbd "M-o") 'ace-window)
(defvar aw-dispatch-alist
  '((?x aw-delete-window "Delete Window")
	(?m aw-swap-window "Swap Windows")
	(?M aw-move-window "Move Window")
	(?j aw-switch-buffer-in-window "Select Buffer")
	(?n aw-flip-window)
	(?u aw-switch-buffer-other-window "Switch Buffer Other Window")
	(?c aw-split-window-fair "Split Fair Window")
	(?v aw-split-window-vert "Split Vert Window")
	(?b aw-split-window-horz "Split Horz Window")
	(?o delete-other-windows "Delete Other Windows")
	(?? aw-show-dispatch-help))
  "List of actions for `aw-dispatch-default'.")

;; for firefox
(setq browse-url-firefox-program
      "C:/Program Files (x86)/Mozilla Firefox/firefox.exe")
(setq browse-url-generic-program "google-chrome")
(setq browse-url-browser-function 'browse-url-generic)

(setq browse-url-chrome-program
      "c:/Users/YeZhao/AppData/Local/Google/Chrome/Application/chrome.exe")

;; when you use M-x apropos , it will generate the realted topic into ones

(setq apropos-sort-by-scores t) 
 

;;for window-numbering
(setq window-numbering-assign-func
      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))



;; http://manuel-uberti.github.io//emacs/2018/05/25/display-version/
;; only works on ubuntu system(with gnome-shell)
(defun mu--os-version ()
  "Call `lsb_release' to retrieve OS version."
  (replace-regexp-in-string
   "Description:\\|[\t\n\r]+" ""
   (with-temp-buffer
     (and (eq 0
              (call-process "lsb_release" nil '(t nil) nil "-d"))
          (buffer-string)))))

(defun mu--gnome-version ()
  "Call `gnome-shell' to retrieve GNOME version."
  (with-temp-buffer
    (and (eq 0
             (call-process "gnome-shell" nil '(t nil) nil "--version"))
         (buffer-string))))

;;;###autoload
(defun mu-display-version ()
  "Display Emacs version and system details in a temporary buffer."
  (interactive)
  (let ((buffer-name "*version*"))
    (with-help-window buffer-name
      (with-current-buffer buffer-name
        (insert (emacs-version) "\n")
        (insert "\nRepository revision: " emacs-repository-version "\n")
        (when (and system-configuration-options
                   (not (equal system-configuration-options "")))
          (insert "\nConfigured using:\n"
                  system-configuration-options))
        (insert "\n\nOperating system: " (mu--os-version) "\n")
        (insert "Window system: " (getenv "XDG_SESSION_TYPE") "\n")
        (insert "Desktop environment: " (mu--gnome-version))))))


;;; moody

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package moody                                ;;
;;   :config                                         ;;
;;   (setq x-underline-at-descent-line t)            ;;
;;   (moody-replace-mode-line-buffer-identification) ;;
;;   (moody-replace-vc-mode))                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for helpful
;; http://xenodium.com/#basic-imenu-in-helpful-mode
(defun helpful--create-imenu-index ()
  "Create an `imenu' index for helpful."
  (beginning-of-buffer)
  (let ((imenu-items '()))
    (while (progn
             (beginning-of-line)
             ;; Not great, but determine if looking at heading:
             ;; 1. if it has bold face.
             ;; 2. if it is capitalized.
             (when (and (eq 'bold (face-at-point))
                        (string-match-p
                         "[A-Z]"
                         (buffer-substring (line-beginning-position)
                                           (line-end-position))))
               (add-to-list 'imenu-items
                            (cons (buffer-substring (line-beginning-position)
                                                    (line-end-position))
                                  (line-beginning-position))))
             (= 0 (forward-line 1))))
    imenu-items))

(defun helpful-mode-hook-function ()
  "A hook function for `helpful-mode'."
  (setq imenu-create-index-function #'helpful--create-imenu-index))

(add-hook 'helpful-mode-hook
          #'helpful-mode-hook-function)


;;; http://xenodium.com/#actionable-urls-in-emacs-buffers

(use-package goto-addr
  :hook ((compilation-mode . goto-address-mode)
         (prog-mode . goto-address-prog-mode)
         (eshell-mode . goto-address-mode)
         (shell-mode . goto-address-mode))
  :bind (:map goto-address-highlight-keymap
              ("<RET>" . goto-address-at-point)
              ("M-<RET>" . newline))
  :commands (goto-address-prog-mode
             goto-address-mode))
