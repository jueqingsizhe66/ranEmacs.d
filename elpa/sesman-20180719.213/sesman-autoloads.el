;;; sesman-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "sesman" "sesman.el" (23378 65121 0 0))
;;; Generated autoloads from sesman.el

(autoload 'sesman-start "sesman" "\
Start sesman session.

\(fn)" t nil)

(autoload 'sesman-restart "sesman" "\
Restart sesman session.

\(fn)" t nil)

(autoload 'sesman-quit "sesman" "\
Terminate sesman session.
When WHICH is nil, kill only the current session; when a single universal
argument or 'linked, kill all linked session; when a double universal argument,
t or 'all, kill all sessions.

\(fn WHICH)" t nil)

(autoload 'sesman-show-session-info "sesman" "\
Display session(s) info.
When WHICH is nil, show info for current session; when a single universal
argument or 'linked, show info for all linked sessions; when a double universal
argument or 'all, show info for all sessions.

\(fn WHICH)" t nil)

(autoload 'sesman-show-links "sesman" "\
Display links active in the current context.

\(fn)" t nil)

(autoload 'sesman-link-with-buffer "sesman" "\
Associate a session with current buffer.

\(fn)" t nil)

(autoload 'sesman-link-with-directory "sesman" "\
Associate a session with current directory.

\(fn)" t nil)

(autoload 'sesman-link-with-project "sesman" "\
Associate a session with current project.

\(fn)" t nil)

(autoload 'sesman-unlink "sesman" "\
Break any of the previously created links.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; sesman-autoloads.el ends here
