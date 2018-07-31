;;; sotclojure-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "sotclojure" "sotclojure.el" (23391 65259 0
;;;;;;  0))
;;; Generated autoloads from sotclojure.el

(autoload 'sotclojure-mode "sotclojure" "\
Toggle SoTclojure mode on or off.
With a prefix argument ARG, enable SoTclojure mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil, and toggle it if ARG is `toggle'.
\\{sotclojure-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "sotclojure-on" "sotclojure-on.el" (23391 65259
;;;;;;  0 0))
;;; Generated autoloads from sotclojure-on.el

(autoload 'sotclojure-turn-on-everywhere "sotclojure-on" "\
Call-once function to turn on sotclojure everywhere.
Calls `sotclojure-mode' on all `clojure-mode' buffers, and sets
up a hook and abbrevs.

\(fn)" nil nil)

(eval-after-load 'sotlisp '(speed-of-thought-hook-in #'sotclojure-turn-on-everywhere #'sotclojure-turn-off-everywhere))

;;;***

;;;### (autoloads nil nil ("sotclojure-pkg.el") (23391 65259 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; sotclojure-autoloads.el ends here
