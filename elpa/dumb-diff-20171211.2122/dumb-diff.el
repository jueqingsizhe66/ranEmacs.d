;;; dumb-diff.el --- fast arbitrary diffs -*- lexical-binding: t; -*-
;; Copyright (C) 2017 jack angers
;; Author: jack angers
;; Version: 0.1.0
;; Package-Version: 20171211.2122
;; Package-Requires: ((emacs "24.3"))
;; Keywords: programming, diff

;; Dumb Diff is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; Dumb Diff is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with Dumb Diff.  If not, see http://www.gnu.org/licenses.

;;; Commentary:

;; Dumb Diff is an Emacs package for fast arbitrary diffs.

;;; Code:

(defgroup dumb-diff nil
  "Easy fast arbitrary diffs"
  :group 'tools
  :group 'convenience)

(defcustom dumb-diff-bin-path
  "diff"
  "The path to the binary for your diff program."
  :group 'dumb-diff
  :type 'string)

(defcustom dumb-diff-bin-args
  "-u"
  "The args to use with your diff program."
  :group 'dumb-diff
  :type 'string)

(defcustom dumb-diff-buf1-name
  "*Dumb Diff - 1*"
  "Name for Dumb Diff compare buffer 1."
  :group 'dumb-diff
  :type 'string)

(defcustom dumb-diff-buf2-name
  "*Dumb Diff - 2*"
  "Name for Dumb Diff compare buffer 2."
  :group 'dumb-diff
  :type 'string)

(defcustom dumb-diff-buf-result-name
  "*Dumb Diff - Result*"
  "Name for Dumb Diff result buffer."
  :group 'dumb-diff
  :type 'string)

(defcustom dumb-diff-msg-empty
  "Press `C-c C-c` to view the diff for the buffers above"
  "Content of result buffer when there is nothing to compare."
  :group 'dumb-diff
  :type 'string)

(defcustom dumb-diff-msg-no-difference
  "(no difference)"
  "Content of result buffer when there is no difference."
  :group 'dumb-diff
  :type 'string)

(defcustom dumb-diff-on-set-show-diff-only
  t
  "When non-nil will only show the diff result buffer if you used a set-region-as-bufferN."
  :group 'dumb-diff
  :type 'boolean)

(defcustom dumb-diff-clear-buffers-on-quit
  t
  "When non-nil will clear dumb diff's comparison and result buffers (so they're clean next time)."
  :group 'dumb-diff
  :type 'boolean)

(defvar dumb-diff--saved-window-config nil)
(defvar dumb-diff--show-comparison-buffers t)
(defvar dumb-diff-hunk-header-re-unified "^@@ -\\([0-9]+\\)\\(?:,\\([0-9]+\\)\\)? \\+\\([0-9]+\\)\\(?:,\\([0-9]+\\)\\)? @@") ;; from diff-mode

;;;###autoload
(defun dumb-diff ()
  "Create and focus the Dumb Diff interface: two buffers for comparison on top and one for the diff result on bottom."
  (interactive)

  (when (null dumb-diff--saved-window-config)
    (setq dumb-diff--saved-window-config (current-window-configuration)))

  (let ((buf1 (get-buffer-create dumb-diff-buf1-name))
        (buf2 (get-buffer-create dumb-diff-buf2-name))
        (buf-result (get-buffer-create dumb-diff-buf-result-name)))

    (delete-other-windows)
    (split-window-below)
    (when dumb-diff--show-comparison-buffers
      (split-window-right)
      (switch-to-buffer buf1)
      (other-window 1)
      (switch-to-buffer buf2)
      (other-window 1))
    (switch-to-buffer buf-result)
    (dumb-diff--refresh)))

;;;###autoload
(defun dumb-diff-set-region-as-buffer1 (start end)
  "Inject the START and END region into the first 'original' buffer for comparison."
  (interactive "r")
  (dumb-diff-set-buffer-by-name dumb-diff-buf1-name start end)
  (message "%s" "Selected region copied to Dumb Diff 1"))

;;;###autoload
(defun dumb-diff-set-region-as-buffer2 (start end)
  "Inject the START and END region into the second 'new' buffer for comparison."
  (interactive "r")
  (dumb-diff-set-buffer-by-name dumb-diff-buf2-name start end)
  (message "%s" "Selected region copied to Dumb Diff 2"))

;;;###autoload
(defun dumb-diff-quit ()
  "Quit dumb diff and restore previous window layout."
  (interactive)
  (setq dumb-diff--show-comparison-buffers t) ; reset for next time
  (when dumb-diff-clear-buffers-on-quit
    (dumb-diff-clear-buffers))
  (when dumb-diff--saved-window-config
    (set-window-configuration dumb-diff--saved-window-config)))

;;;###autoload
(defun dumb-diff-git-file ()
  "Get file git diff for current file."
  (interactive)
  (let* ((cmd-tmpl "git diff %s")
         (git-diff-cmd (format cmd-tmpl (buffer-file-name)))
         (file-name (car (last (split-string (buffer-file-name) "/"))))
         (buffer-title (concat "Dumb Diff via git on " file-name " | " (format-time-string "%D @ %H:%M:%S"))))
    (shell-command git-diff-cmd buffer-title)
    (let ((buf (get-buffer buffer-title)))
      (with-current-buffer buf
          (diff-mode)
          (switch-to-buffer-other-window buf)
          (while (re-search-forward dumb-diff-hunk-header-re-unified nil t)
            (funcall-interactively 'diff-refine-hunk))
          (when (= (buffer-size) 0)
            (kill-buffer buf))))))

(defun dumb-diff-set-buffer-by-name (name start end)
  "Injected into buffer NAME the string from region START to END."
  (setq dumb-diff--show-comparison-buffers (not dumb-diff-on-set-show-diff-only))
  (let ((buf (get-buffer-create name))
        (text (buffer-substring-no-properties start end)))
    (with-current-buffer buf
      (erase-buffer)
      (insert text))))

(defun dumb-diff-select-result ()
  "Switch to the result buffer."
  (interactive)
  (let ((buf (get-buffer-create dumb-diff-buf-result-name)))
    (switch-to-buffer buf)
    (with-current-buffer buf
      ; on EVERY hunk do "refine" so we get word diffs!
      (while (re-search-forward dumb-diff-hunk-header-re-unified nil t)
        (funcall-interactively 'diff-refine-hunk)))))


(defun dumb-diff-get-buffer-contents (b)
  "Return the results of buffer B."
  (with-current-buffer b
    (buffer-string)))

(defun dumb-diff-write-to-file (f c)
  "Write to file F the contents of C."
  (with-temp-file f
    (insert c)))

(defun dumb-diff-string-replace (old new str)
  "Replace OLD with NEW in STR."
  (replace-regexp-in-string (regexp-quote old) new str nil 'literal))

(defun dumb-diff-clear-buffers ()
  "Clear the contents of all dumb-diff buffers."
  (dolist (x (list dumb-diff-buf1-name dumb-diff-buf2-name dumb-diff-buf-result-name))
    (with-current-buffer (get-buffer-create x)
      (erase-buffer))))

(defun dumb-diff--refresh ()
  "Run `diff` command, update result buffer, and select it."
  (let* ((buf1 (get-buffer-create dumb-diff-buf1-name))
         (buf2 (get-buffer-create dumb-diff-buf2-name))
         (buf-result (get-buffer-create dumb-diff-buf-result-name))
         (dd-f1 (make-temp-file "dumb-diff-buf1"))
         (dd-f2 (make-temp-file "dumb-diff-buf2"))
         (txt-f1 (dumb-diff-get-buffer-contents buf1))
         (txt-f2 (dumb-diff-get-buffer-contents buf2))
         (is-blank (and (= (length txt-f1) 0)
                        (= (length txt-f2) 0))))

    ;; write buffer contents to temp file for comparison
    (dumb-diff-write-to-file dd-f1 txt-f1)
    (dumb-diff-write-to-file dd-f2 txt-f2)

    ;; ensure compare buffers have major mode enabled
    (dolist (x (list buf2 buf1))
      (with-current-buffer x
        (funcall 'dumb-diff-mode)))

    (let* ((cmd (format "%s %s %s %s" dumb-diff-bin-path dumb-diff-bin-args dd-f1 dd-f2))
           (raw-result1 (shell-command-to-string cmd))
           (has-diff (> (length raw-result1) 0))
           (raw-result2 (dumb-diff-string-replace dd-f1 dumb-diff-buf1-name raw-result1))
           (raw-result3 (dumb-diff-string-replace dd-f2 dumb-diff-buf2-name raw-result2))
           (result (if has-diff
                       raw-result3
                     (if is-blank
                         dumb-diff-msg-empty
                       dumb-diff-msg-no-difference))))

      (with-current-buffer buf-result
        (if has-diff
            (funcall 'diff-mode)
          (funcall 'text-mode))
        (erase-buffer)
        (insert result)
        (goto-char (point-min))))
    (dumb-diff-select-result)))

(defvar dumb-diff-mode-map (make-sparse-keymap)
  "Keymap for `dumb-diff-mode'.")

(defun dumb-diff-mode-keymap ()
  "Define keymap for `dumb-diff-mode'."
  (define-key dumb-diff-mode-map (kbd "C-c C-c") 'dumb-diff))

(define-derived-mode dumb-diff-mode
  fundamental-mode
  "Dumb Diff"
  (dumb-diff-mode-keymap))

(provide 'dumb-diff)
;;; dumb-diff.el ends here
