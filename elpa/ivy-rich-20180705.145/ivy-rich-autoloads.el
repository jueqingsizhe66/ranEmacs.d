;;; ivy-rich-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "ivy-rich" "ivy-rich.el" (23391 65516 0 0))
;;; Generated autoloads from ivy-rich.el

(autoload 'ivy-rich-switch-buffer-transformer "ivy-rich" "\
Transform CANDIDATE to more readable format.

Currently the transformed format is

| Buffer name | Buffer indicators | Major mode | Project | Path (Based on project root) |.

\(fn CANDIDATE)" nil nil)

(defvar ivy-rich-mode nil "\
Non-nil if Ivy-Rich mode is enabled.
See the `ivy-rich-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `ivy-rich-mode'.")

(custom-autoload 'ivy-rich-mode "ivy-rich" nil)

(autoload 'ivy-rich-mode "ivy-rich" "\
Toggle ivy-rich mode globally.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ivy-rich-autoloads.el ends here
