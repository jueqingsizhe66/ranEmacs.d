;; Load `custome.el' file
;; If it doesn't exist, copy from the template, then load it.
; (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;
; (let ((custom-template-file (expand-file-name "custom-template.el" user-emacs-directory)))
;   (if (and (file-exists-p custom-template-file) (not (file-exists-p custom-file)))
;       (copy-file custom-template-file custom-file)))
;
; (if (file-exists-p custom-file)
;     (load custom-file))
;
(provide 'init-custom)
