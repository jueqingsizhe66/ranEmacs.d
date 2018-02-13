;;; setup-git.el ---                                 -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Ye Zhaoliang

;; Author: Ye Zhaoliang <Administrator@PC-20150406GRVY>
;; Keywords: abbrev, abbrev, abbrev, 


;(global-git-gutter-mode +1)




(require 'git-gutter)

;; If you enable global minor mode
(global-git-gutter-mode t)


;Other case, you want to use git-gutter for some files, you can use git-gutter-mode. Following example of enabling git-gutter for some mode.

(add-hook 'ruby-mode-hook 'git-gutter-mode)
(add-hook 'python-mode-hook 'git-gutter-mode)
(add-hook 'perl-mode-hook 'git-gutter-mode)
(add-hook 'java-mode-hook 'git-gutter-mode)

;; If you would like to use git-gutter.el and linum-mode
(git-gutter:linum-setup)

;; If you enable git-gutter-mode for some modes
(add-hook 'ruby-mode-hook 'git-gutter-mode)

(global-set-key (kbd "C-x C-g") 'git-gutter)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

;; Jump to next/previous hunk
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)

;; Stage current hunk
(global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

;; Revert current hunk
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

;; Mark current hunk
(global-set-key (kbd "C-x v SPC") #'git-gutter:mark-hunk)

;;If you set git-gutter:update-interval seconds larger than 0, git-gutter updates diff information in real-time by idle timer.

(custom-set-variables
 '(git-gutter:update-interval 2))


(custom-set-variables
 '(git-gutter:modified-sign "  ") ;; two space
 '(git-gutter:added-sign "++")    ;; multiple character is OK
 '(git-gutter:deleted-sign "--"))

(set-face-background 'git-gutter:modified "purple") ;; background color
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")


;; first character should be a space
(custom-set-variables
 '(git-gutter:lighter " GG"))

(custom-set-variables
 '(git-gutter:window-width 2)
 '(git-gutter:modified-sign "☁")
 '(git-gutter:added-sign "☀")
 '(git-gutter:deleted-sign "☂"))


;; Use for 'Git'(`git`), 'Mercurial'(`hg`), 'Bazaar'(`bzr`), and 'Subversion'(`svn`) projects
(custom-set-variables
 '(git-gutter:handled-backends '(git hg bzr svn)))



;;git-gutter.el can display an additional separator character at the right of the changed signs. This is mostly useful when running emacs in a console.

(custom-set-variables
 '(git-gutter:separator-sign "|"))
(set-face-foreground 'git-gutter:separator "yellow")


;; ignore all spaces
(custom-set-variables
 '(git-gutter:diff-option "-w"))

;;diff information is updated at hooks in git-gutter:update-hooks.

(add-to-list 'git-gutter:update-hooks 'focus-in-hook)

;; Magit
(global-set-key (kbd "C-x m") 'magit-status-fullscreen)
(autoload 'magit-status-fullscreen "magit")



;; magit
(global-set-key (kbd "C-x g") 'magit-status)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Visit a git-controlled file and issue M-x git-timemachine (or bind it to a keybinding of your choice). If you just need to toggle the time machine you can use M-x git-timemachine-toggle. ;;
;;                                                                                                                                                                                            ;;
;; Use the following keys to navigate historic version of the file                                                                                                                            ;;
;;                                                                                                                                                                                            ;;
;;     p Visit previous historic version                                                                                                                                                      ;;
;;     n Visit next historic version                                                                                                                                                          ;;
;;     w Copy the abbreviated hash of the current historic version                                                                                                                            ;;
;;     W Copy the full hash of the current historic version                                                                                                                                   ;;
;;     g Goto nth revision                                                                                                                                                                    ;;
;;     q Exit the time machine.                                                                                                                                                               ;;
;;     b Run magit-blame on the currently visited revision (if magit available).                                                                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "git-timemachine.el")
