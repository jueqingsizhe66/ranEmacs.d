;;; setup-find-file-in-project.el ---                -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Ye Zhaoliang

;; Author: Ye Zhaoliang <YeZhao@DESKTOP-YeZhao>
;; Keywords: abbrev, abbrev, abbrev, 


(require 'find-file-in-project)
(if (eq system-type 'windows-nt)
    (setq ffip-find-executable "c:\\\\cygwin\\\\bin\\\\find"))
