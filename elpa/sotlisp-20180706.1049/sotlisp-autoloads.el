;;; sotlisp-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "sotlisp" "sotlisp.el" (23368 15433 0 0))
;;; Generated autoloads from sotlisp.el

(defvar speed-of-thought-mode nil "\
Non-nil if Speed-Of-Thought mode is enabled.
See the `speed-of-thought-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `speed-of-thought-mode'.")

(custom-autoload 'speed-of-thought-mode "sotlisp" nil)

(autoload 'speed-of-thought-mode "sotlisp" "\
Toggle Speed-Of-Thought mode on or off.
With a prefix argument ARG, enable Speed-Of-Thought mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil, and toggle it if ARG is `toggle'.
\\{speed-of-thought-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'speed-of-thought-hook-in "sotlisp" "\
Add functions ON and OFF to `speed-of-thought-mode' hooks.
If `speed-of-thought-mode' is already on, call ON.

\(fn ON OFF)" nil nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; sotlisp-autoloads.el ends here
