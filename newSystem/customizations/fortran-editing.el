
;;;;;;;;;;;;
;; fortran
;;;;;;;;;;;;
(autoload 'fortpy-setup "fortpy" nil t)
;; Standard fortpy.el setting
(add-hook 'f90-mode-hook 'fortpy-setup)
(setq fortpy-complete-on-percent t)
(setq fortpy-complete-on-bracket t)


;;;http://fcode.cn/codetools-81-1.html
(setq auto-mode-alist
    (append '(("\\.f90\\'" . f90-mode)
             ("\\.f95\\'" . f90-mode))
     auto-mode-alist))
;(add-hook \'f90-mode-hook (lambda () (abbrev-mode 1)))

