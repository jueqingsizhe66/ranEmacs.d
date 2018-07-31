;;; sesman-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "sesman" "sesman.el" (23391 65264 0 0))
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

\(fn &optional WHICH)" t nil)

(autoload 'sesman-show-session-info "sesman" "\
Display session(s) info.
When WHICH is nil, show info for current session; when a single universal
argument or 'linked, show info for all linked sessions; when a double universal
argument or 'all, show info for all sessions.

\(fn &optional WHICH)" t nil)

(autoload 'sesman-show-links "sesman" "\
Display links active in the current context.

\(fn)" t nil)

(autoload 'sesman-link-with-buffer "sesman" "\
Associate SESSION with BUFFER.
BUFFER defaults to current buffer. On universal argument, or if BUFFER is 'ask,
ask for buffer.

\(fn &optional BUFFER SESSION)" t nil)

(autoload 'sesman-link-with-directory "sesman" "\
Associate a SESSION with DIR.
DIR defaults to `default-directory'. On universal argument, or if DIR is 'ask,
ask for directory.

\(fn &optional DIR SESSION)" t nil)

(autoload 'sesman-link-with-project "sesman" "\
Link the SESSION with PROJECT.
PROJECT defaults to current project. On universal argument, or if PROJECT is
'ask, ask for the project.

\(fn &optional PROJECT SESSION)" t nil)

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
