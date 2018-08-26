;; avoid ridiculous ruby indentation
(setq ruby-deep-indent-paren nil)

(defun ruby--jump-to-test ()
  (find-file
   (replace-regexp-in-string
    "/lib/" "/test/"
    (replace-regexp-in-string
     "/\\([^/]+\\).rb$" "/test_\\1.rb"
     (buffer-file-name)))))

(defun ruby--jump-to-lib ()
  (find-file
   (replace-regexp-in-string
    "/test/" "/lib/"
    (replace-regexp-in-string
     "/test_\\([^/]+\\).rb$" "/\\1.rb"
     (buffer-file-name)))))

(defun ruby-jump-to-other ()
  (interactive)
  (if (string-match-p "/test/" (buffer-file-name))
      (ruby--jump-to-lib)
    (ruby--jump-to-test)))

;(define-key ruby-mode-map (kbd "C-c t") 'ruby-jump-to-other)
(add-hook 'ruby-mode-hook 'ruby-refactor-mode-launch)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Extract to Method (C-c C-r e)        ;;
;; Extract Local Variable (C-c C-r v)   ;;
;; Extract Constant (C-c C-r c)         ;;
;; Add Parameter (C-c C-r p)            ;;
;; Extract to Let (C-c C-r l)           ;;
;; Convert Post Conditional (C-c C-r o) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'setup-ruby-mode)
