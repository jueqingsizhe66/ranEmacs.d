;;; wc-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "wc-mode" "wc-mode.el" (23291 47246 0 0))
;;; Generated autoloads from wc-mode.el

(autoload 'wc-mode "wc-mode" "\
Toggle wc mode With no argument, this command toggles the
mode.  Non-null prefix argument turns on the mode.  Null prefix
argument turns off the mode.

When Wc mode is enabled on a buffer, it counts the current words
in the buffer and keeps track of a differential of added or
subtracted words.

A goal of number of words added/subtracted can be set while using
this mode. Upon completion of the goal, the modeline text will
highlight indicating that the goal has been reached.

Commands:
\\{wc-mode-map}

Entry to this mode calls the value of `wc-mode-hook' if that
value is non-nil.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; wc-mode-autoloads.el ends here
