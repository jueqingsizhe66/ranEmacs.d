;;; beginend-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "beginend" "beginend.el" (23429 20964 0 0))
;;; Generated autoloads from beginend.el

(autoload 'beginend-setup-all "beginend" "\
Use beginend on all compatible modes.
For example, this activates function `beginend-dired-mode' in `dired' and
function `beginend-message-mode' in `message-mode'.  All affected minor
modes are described in `beginend-modes'.

\(fn)" nil nil)

(autoload 'beginend-unsetup-all "beginend" "\
Remove beginend from all compatible modes in `beginend-modes'.

\(fn)" nil nil)

(defvar beginend-global-mode nil "\
Non-nil if Beginend-Global mode is enabled.
See the `beginend-global-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `beginend-global-mode'.")

(custom-autoload 'beginend-global-mode "beginend" nil)

(autoload 'beginend-global-mode "beginend" "\
Toggle beginend mode.
Interactively with no argument, this command toggles the mode.  A positive
prefix argument enables the mode, any other prefix argument disables it.
From Lisp, argument omitted or nil enables the mode, `toggle' toggles the
state.

When beginend mode is enabled, modes such as `dired-mode', `message-mode'
and `compilation-mode' will have their \\[beginning-of-buffer] and
\\[end-of-buffer] keys adapted to go to meaningful places.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; beginend-autoloads.el ends here
