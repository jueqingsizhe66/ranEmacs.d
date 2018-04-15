;;; org-wild-notifier-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "org-wild-notifier" "org-wild-notifier.el"
;;;;;;  (23243 33536 0 0))
;;; Generated autoloads from org-wild-notifier.el

(autoload 'org-wild-notifier-check "org-wild-notifier" "\
Parse agenda view and notify about upcomming events.

\(fn)" t nil)

(defvar org-wild-notifier-mode nil "\
Non-nil if Org-Wild-Notifier mode is enabled.
See the `org-wild-notifier-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `org-wild-notifier-mode'.")

(custom-autoload 'org-wild-notifier-mode "org-wild-notifier" nil)

(autoload 'org-wild-notifier-mode "org-wild-notifier" "\
Toggle org notifications globally.
When enabled parses your agenda once a minute and emits notifications
if needed.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; org-wild-notifier-autoloads.el ends here
