;;; setup-erc.el --- configuration for internet chat inside emacs  -*- lexical-binding: t; -*-

; Copyright (C) 2018  Ye Zhaoliang

;; Author: Ye Zhaoliang <yzl@DESKTOP-MVNHR6D>
;; Keywords: tools, local, news,
(defconst irc-channels
  '(("freenode.net" "#ubuntu-cn" "#archlinux-cn" "#emacs.tw"
     ;; "#geekhack"
     )
    ("oftc.net" "#arch-cn" "#njulug" "#wormux-cn" "#emacs-cn")
    ("esper.net" "#minecraft-cn")))
(ignore-errors (setq erc-autojoin-channels-alist irc-channels))

(defun erc-start ()
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick irc-nick
       :password irc-password :full-name irc-full-name)
  (erc-tls :server "irc.oftc.net" :port 6697 :nick irc-nick
           :password irc-password :full-name irc-full-name)
  (erc-tls :server "irc.esper.net" :port 6697 :nick irc-nick
           :password irc-password :full-name irc-full-name))


(setq erc-quit-reason-various-alist
      '(("dinner" "Having dinner...")
        ("z" "Zzz...")
        ("^$" yow)))
(setq erc-quit-reason 'erc-quit-reason-various)

