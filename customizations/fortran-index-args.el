;;; fortran-index-args.el --- Index arguments in fortran subroutines

;; Copyright (C) 2012 François Févotte
;; Author:  François Févotte <fevotte@gmail.com>
;; Version: 0.1

;; This file is NOT part of Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;; Commentary:


;;; Code:

;; List of overlays created by `fia/make-overlay'
(defvar fia/overlays)

(defun fia/display ()
  "Display an index before each argument to the previous subroutine.
Indices are displayed in overlays; the buffer is actually left
untouched.  Call `fia/cleanup' to return to normal appearance."
  (interactive)
  (fia/cleanup)
  (let ((index 1)
        (beg (max (fia/get-open-paren "call")
                  (fia/get-open-paren "subroutine")))
        end)
    (when (= beg (point-min))
      (error "Could not find beginning of subroutine"))
    (goto-char (1- beg))
    (forward-sexp)
    (setq end (point))
    (goto-char beg)
    (while (< (point) end)
      (fia/skip-blanks)
      (setq beg (point))
      (while (and (< (point) end)
                  (not (looking-at "\s*,")))
        (condition-case nil
            (forward-sexp)
          (error (setq end (point)))))
      (fia/make-overlay beg (point) index)
      (setq index (1+ index))
      (fia/skip-blanks)
      (fia/skip-comma))))

(defun fia/cleanup ()
  "Clean up arguments indexing.
Remove all overlays put by `fia/display', and return to normal
buffer appearance."
  (interactive)
  (if (boundp 'fia/overlays)
      (mapc 'delete-overlay fia/overlays)
    (make-local-variable 'fia/overlays))
  (setq fia/overlays nil))

(defun fia/toggle ()
  "Toggle indexing of subroutine arguments"
  (interactive)
  (if (and (boundp 'fia/overlays)
           fia/overlays)
      (fia/cleanup)
    (fia/display)))

(defun fia/make-overlay (beg end index)
  "Helper function to create overlays showing indices in front of
fortran arguments to subroutines.

BEG and END are the boundaries of the argument. INDEX is its
position in the argument list."
  (let ((o (make-overlay beg end nil nil t)))
    (overlay-put o 'before-string (format "%3d:" index))
    (overlay-put o 'face 'highlight)
    (setq fia/overlays (cons o fia/overlays))))

(defun fia/get-open-paren (s)
  "Helper function to retrieve the first open paren after a
keyword.

S is typically \"SUBROUTINE\" or \"CALL\", to look for an
argument list."
  (save-excursion
    (if (search-backward s nil t)
        (progn
          (search-forward "(")
          (point))
      (point-min))))

;; TODO: account for possible comment lines interspersed with the arguments
;; list.
(defun fia/skip-blanks ()
  "Advance point, skipping blank characters.
Also move past end of lines, and resume skipping blanks after
the 6th character of the following line."
  (skip-syntax-forward "-")
  (when (eolp)
    (forward-char 7))
  (skip-syntax-forward "-"))

(defun fia/skip-comma ()
  "Advance point if there's a comma immediately after it."
  (when (looking-at ",")
    (forward-char)))


(provide 'fortran-index-args)

;;; fortran-index-args.el ends here
