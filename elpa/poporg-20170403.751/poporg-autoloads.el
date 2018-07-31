;;; poporg-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "poporg" "poporg.el" (23391 65290 0 0))
;;; Generated autoloads from poporg.el

(autoload 'poporg-dwim "poporg" "\
Single overall command for poporg (a single keybinding may do it all).

If the current buffer is an edit buffer, run `poporg-edit-exit'.

If the region is active, edit it in an empty buffer.  Otherwise, find a nearby
string or comment using `poporg-find-string-or-comment' and edit that in an
empty buffer.  If there is an active edit nearby, pop to its other buffer and
edit that instead.

\(fn)" t nil)

(autoload 'poporg-update "poporg" "\
Update the contents of the original buffer.

If prefix argument WITH-SAVE is non-nil, save the original buffer too.

Also update the overlay.

\(fn WITH-SAVE)" t nil)

(autoload 'poporg-update-and-save "poporg" "\
Update and save the original buffer; update the region.

\(fn)" t nil)

(autoload 'poporg-edit-exit "poporg" "\
Exit the edit buffer, replacing the original region.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; poporg-autoloads.el ends here
