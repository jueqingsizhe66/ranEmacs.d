;;; fortpy.el --- a Fortran auto-completion for Emacs

;; Copyright (C) 2012 Conrad W Rosenbrock
;; Adapted from the jedi.el script written by Takafumi Arakaki.

;; Author: Conrad Rosenbrock <rosenbrockc at gmail.com>
;; Package-Requires: ((epc "0.1.0") (auto-complete "1.4") (python-environment "0.0.2") (pos-tip "0.4.5"))
;; Version: 1.1

;; This file is NOT part of GNU Emacs.

;; fortpy.el is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; fortpy.el is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with fortpy.el.
;; If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(eval-when-compile
  (require 'cl))
(require 'ring)

(require 'epc)
(require 'auto-complete)
;;We use the python-environment API for virtualenv to simplify the
;;installation of the EPC server and other modules to virtualenv
(require 'python-environment)
(declare-function pos-tip-show "pos-tip")

(defgroup fortpy nil
  "Auto-completion for Fortran 2003."
  :group 'completion
  :prefix "fortpy:")

(defgroup fortpy-faces nil
  "Faces for XML documentation highlighting in f90 mode"
  :tag "Color Scheme"
  :group 'fortpy
  :link '(custom-group-link "fortpy")
  :prefix "fortpy-faces-"
  )

(defface fortpy-xml-doc-face
  '((((background light)) (:foreground "#518751"))
    (((background dark)) (:foreground "#518751")))
  "Face to highlight XML keywords in documentation tags."
  :group 'fortpy-faces)

(defface fortpy-xml-doc-link-face
  '((((background light)) (:foreground "#858751"))
    (((background dark)) (:foreground "#858751")))
  "Face to highlight XML links (e.g. CREF, QUIRK, TODO) in documentation tags."
  :group 'fortpy-faces)

(defface fortpy-xml-doc-attribute-face
  '((((background light)) (:foreground "#876951"))
    (((background dark)) (:foreground "#876951")))
  "Face to highlight XML attributes in the documentation tags."
  :group 'fortpy-faces)

(defface fortpy-xml-doc-value-face
  '((((background light)) (:foreground "#875187"))
    (((background dark)) (:foreground "#875187")))
  "Face to highlight XML attribute values in the documentation tags."
  :group 'fortpy-faces)

(defface fortpy-xml-doc-error-face
  '((((background light)) (:foreground "#9E1919" :background "#FAE8E8" :weight bold))
    (((background dark)) (:foreground "#9E1919" :background "#FAE8E8" :weight bold)))
  "Face to highlight bad use of !! in comments that break the documentation parser."
  :group 'fortpy-faces)

(defface fortpy-percent-face
  '((((background light)) (:foreground "#FF5252" :height 75))
    (((background dark)) (:foreground "#FF5252" :height 75)))
  "Face to make the '%' character small and stick out more."
  :group 'fortpy-faces)

(defface fortpy-operator-face
  '((((background light)) (:foreground "#599EE3"))
    (((background dark)) (:foreground "#599EE3")))
  "Face to make the '%' character small and stick out more."
  :group 'fortpy-faces)

(defface fortpy-doc-comment-face
 '((((background light)) (:foreground "#1B5C3B"))
    (((background dark)) (:foreground "#1B5C3B")))
  "Face to highlight XML docstart comment !! in documentation tags."
  :group 'fortpy-faces)

(defcustom fortpy-regex-xml-tags "!?<\\(/?\\(summary\\|usage\\|comments\\|parameter\\|errors\\|group\\|member\\|local\\|prereq\\|instance\\|outcome\\|mapping\\|run\\|skip\\|global\\|revision\\|dimension\\)\\)[^>]*>"
  "Regex for matching recognized XML tags in the documentation."
  :group 'fortpy-faces)

(defcustom fortpy-regex-xml-doc-links "\\(@CREF\\|QUIRK\\|TODO\\)"
  "Regex for matching XML documentation links."
  :group 'fortpy-faces)

(defconst fortpy:regex-xml-attribute "\\([a-zA-z]+\\)=\""
  "Regex for matching XML attributes.")

(defconst fortpy:regex-xml-value "=\"\\([A-Za-z0-9_ ,./]+\\)\""
  "Regex for matching XML attribute values.")

(defconst fortpy:regex-percent "%"
  "Regex for matching % in Fortran.")

(defconst fortpy:regex-operator "[-*+/]"
  "Regex for matching mathematical logic operators in Fortran.")

(defconst fortpy:regex-doc-comment "!!"
  "Regex for matching the start of an XML documentation comment")

(defconst fortpy:version "1.0.3")

(defvar fortpy:source-dir (if load-file-name
                            (file-name-directory load-file-name)
                          default-directory))

(defvar fortpy:epc nil)
(make-variable-buffer-local 'fortpy:epc)

(defvar fortpy:server-script
  (convert-standard-filename
   (expand-file-name "fortpyepcserver.py" fortpy:source-dir))
  "Full path to Fortpy server script file ``fortpyepcserver.py``.")


;;; Configuration variables

(defcustom fortpy-environment-root nil
  "Name of Python environment to use.
If it is nil, `python-environment-default-root-name' is used.

You can specify a full path instead of a name (relative path).
In that case, `python-environment-directory' is ignored and
Python virtual environment is created at the specified path."
  :group 'fortpy)

(defcustom fortpy-environment-virtualenv nil
  "``virtualenv`` command to use.  A list of string.
If it is nil, `python-environment-virtualenv' is used instead.

You must set non-`nil' value to `fortpy-environment-root' in order
to make this setting work."
  :group 'fortpy)

(defun fortpy:-env-server-command ()
  (let* ((getbin (lambda (x) (python-environment-bin x fortpy-environment-root)))
         (script (or (funcall getbin "fortpyepcserver")
                     (funcall getbin "fortpyepcserver.py"))))
    (when script
      (list script))))

(defcustom fortpy-server-command
  (or (fortpy:-env-server-command)
      (list "python" fortpy:server-script))
  "Command used to run Fortpy server.

.. NOTE::

   If you used `fortpy-install-server' (recommended) to install
   Python server fortpyepcserver.py, you don't need to mess around
   with fortpyepcserver.py.  Fortpy.el handles everything
   automatically.

If you install Python server fortpyepcserver.py using
`fortpy-install-server' command, `fortpy-server-command' should be
automatically set to::

    '(\"~/.emacs.d/.python-environments/default/bin/fortpyepcserver.py\")

Otherwise, it is set to::

    '(\"python\" \"FORTPY:SOURCE-DIR/fortpyepcserver.py\")

.. NOTE:: If you installed fortpyepcserver.py manually, then you
   have to set `fortpy-server-command' appropriately.

   If you can run ``fortpyepcserver.py --help`` in your shell, then
   you can simply set::

       (setq fortpy-server-command '(\"fortpyepcserver.py\"))

   Otherwise, you need to find where you installed
   fortpyepcserver.py then set the path directly::

       (setq fortpy-server-command '(\"PATH/TO/fortpyepcserver.py\"))

If you want to use a specific version of Python, setup
`fortpy-environment-virtualenv' variable appropriately and
reinstall fortpyepcserver.py.

If you want to pass some arguments to the Fortpy server command,
use `fortpy-server-args' instead of appending them
`fortpy-server-command'."
  :group 'fortpy)

(defcustom fortpy-server-args nil
  "Command line arguments to be appended to `fortpy-server-command'.

If you want to add some special `sys.path' when starting Fortpy
server, do something like this::

    (setq fortpy-server-args
          '(\"--sys-path\" \"MY/SPECIAL/PATH\"
            \"--sys-path\" \"MY/OTHER/SPECIAL/PATH\"))

If you want to include some virtualenv, do something like the
following.  Note that actual environment variable ``VIRTUAL_ENV``
is treated automatically so you don't need to pass it.  Also,
you need to start Fortpy EPC server with the same python version
that you use for the virtualenv.::

    (setq fortpy-server-args
          '(\"--virtual-env\" \"SOME/VIRTUAL_ENV_1\"
            \"--virtual-env\" \"SOME/VIRTUAL_ENV_2\"))

To see what other arguments Fortpy server can take, execute the
following command::

    python fortpyepcserver.py --help


**Advanced usage**

Sometimes you want to configure how Fortpy server is started per
buffer.  To do that, you should make this variable buffer local
in `python-mode-hook' and set it to some buffer specific variable,
like this::

  (defun my-fortpy-server-setup ()
    (let ((cmds (GET-SOME-PROJECT-SPECIFIC-COMMAND))
          (args (GET-SOME-PROJECT-SPECIFIC-ARGS)))
      (when cmds (set (make-local-variable 'fortpy-server-command) cmds))
      (when args (set (make-local-variable 'fortpy-server-args) args))))

  (add-hook 'python-mode-hook 'my-fortpy-server-setup)

Note that Fortpy server run by the same command is pooled.  So,
there is only one Fortpy server for the same set of command.  If
you want to check how many EPC servers are running, use the EPC
GUI: M-x `epc:controller'.  You will see a table of EPC connections
for Fortpy.el and other EPC applications.

If you want to start a new ad-hoc server for the current buffer,
use the command `fortpy-start-dedicated-server'."
  :group 'fortpy)

(defcustom fortpy-complete-on-percent nil
  "Non-`nil' means automatically start completion after inserting a percent.
To make this option work, you need to use `fortpy-setup' instead of
`fortpy-ac-setup' to start Fortpy."
  :group 'fortpy)

(defcustom fortpy-complete-on-bracket nil
  "Non-`nil' means automatically start completion after inserting a '('.
To make this option work, you need to use `fortpy-setup' instead of
`fortpy-ac-setup' to start Fortpy."
  :group 'fortpy)

(defcustom fortpy-tooltip-method '(pos-tip popup)
  "Configuration for `fortpy:tooltip-show'.
This is a list which may contain symbol(s) `pos-tip' and/or
`popup'.  It determines tooltip method to use.  Setting this
value to nil means to use minibuffer instead of tooltip."
  :group 'fortpy)

(defcustom fortpy-get-in-function-call-timeout 3000
  "Cancel request to server for call signature after this period
specified in in millisecond."
  :group 'fortpy)

(defcustom  fortpy-get-in-function-call-delay 1000
  "How long Fortpy should wait before showing call signature
tooltip in millisecond."
  :group 'fortpy)

(defcustom fortpy-goto-definition-config
  '((nil nil        nil)
    (t   nil        nil)
    (nil definition nil)
    (t   definition nil)
    (nil nil        t  )
    (t   nil        t  )
    (nil definition t  )
    (t   definition t  ))
  "Configure how prefix argument modifies `fortpy-goto-definition' behavior.

Each element of the list is arguments (list) passed to
`fortpy-goto-definition'.  Note that this variable has no effect on
`fortpy-goto-definition' when it is used as a lisp function

The following setting is default (last parts are omitted).
Nth element is used as the argument when N universal prefix
arguments (``C-u``) are given.::

    (setq fortpy-goto-definition-config
          '((nil nil        nil)        ; C-.
            (t   nil        nil)        ; C-u C-.
            (nil definition nil)        ; C-u C-u C-.
            (t   definition nil)        ; C-u C-u C-u C-.
            ...))

For example, if you want to follow \"substitution path\" by default,
use the setting like this::

    (setq fortpy-goto-definition-config
          '((nil definition nil)
            (t   definition nil)
            (nil nil        nil)
            (t   nil        nil)
            (nil definition t  )
            (t   definition t  )
            (nil nil        t  )
            (t   nil        t  )))

You can rearrange the order to have most useful sets of arguments
at the top."
  :group 'fortpy)

(defcustom fortpy-doc-mode 'rst-mode
  "Major mode to use when showing document."
  :group 'fortpy)

(defcustom fortpy-doc-hook '(view-mode)
  "The hook that's run after showing a document."
  :type 'hook
  :group 'fortpy)

(defcustom fortpy-doc-display-buffer 'display-buffer
  "A function to be called with a buffer to show document."
  :group 'fortpy)

(defcustom fortpy-install-imenu nil
  "[EXPERIMENTAL] If `t', use Fortpy to create `imenu' index.
To use this feature, you need to install the developmental
version (\"dev\" branch) of Fortpy."
  :group 'fortpy)

(defcustom fortpy-imenu-create-index-function 'fortpy:create-nested-imenu-index
  "`imenu-create-index-function' for Fortpy.el.
It must be a function that takes no argument and return an object
described in `imenu--index-alist'.
This can be set to `fortpy:create-flat-imenu-index'.
Default is `fortpy:create-nested-imenu-index'."
  :group 'fortpy)

(defcustom fortpy-use-shortcuts nil
  "If non-`nil', enable the following shortcuts:

| ``M-.``  `fortpy-goto-definition'
| ``M-,``  `fortpy-goto-definition-pop-marker'
"
  :group 'fortpy)

(defcustom fortpy-goto-definition-marker-ring-length 16
  "Length of marker ring to store `fortpy-goto-definition' call positions"
  :group 'fortpy)


;;; Internal variables

(defvar fortpy:get-in-function-call--d nil
  "Bounded to deferred object while requesting get-in-function-call.")

(defvar fortpy:defined-names--singleton-d nil
  "Bounded to deferred object while requesting defined_names.")


;;; Fortpy mode

(defvar fortpy-mode-map (make-sparse-keymap))

(defun fortpy:handle-post-command ()
  (fortpy:get-in-function-call-when-idle))

(defun fortpy:period-face ()
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (string-equal face "font-lock-string-face")))

(defun fortpy:period-percent ()
  "Inserts a '%' instead of a period unless the previous character is a number."
  (interactive)
  (let (start end line index startchar relpt)
    (setq start (line-beginning-position))
    (setq end (line-end-position))
    (setq line (buffer-substring-no-properties start end))
    (setq index (string-match-p "!" line))
    ;;ignore this function if we are inside of a comment region.
    (if (or (not index) (< (- (point) start) index))
        (if (or (equal (string-match-p "[0-9([:blank:]=\"']" (string (preceding-char))) 0)
                (looking-back "[[:blank:](=][.][[:alnum:]._\"]*" start)
                (fortpy:period-face))
            (insert ".")
          (if fortpy-complete-on-percent
              (fortpy-percent-complete)
            (insert "%")))
      (insert "."))))

(define-minor-mode fortpy-mode
  "Fortpy mode.
When `fortpy-mode' is on, call signature is automatically shown as
toolitp when inside of function call.

\\{fortpy-mode-map}"
  :keymap fortpy-mode-map
  :group 'fortpy
  (let ((map fortpy-mode-map))
    (when fortpy-use-shortcuts
      (define-key map (kbd "M-.") 'fortpy-goto-definition)
      (define-key map (kbd "M-,") 'fortpy-goto-definition-pop-marker))
    (if fortpy-complete-on-percent
        (define-key map "%" 'fortpy-percent-complete)
      (define-key map "%" nil))
    (if fortpy-complete-on-bracket
        (define-key map "(" 'fortpy-bracket-complete)
      (define-key map "(" nil))
    (define-key map (kbd ".") 'fortpy:period-percent))
  (fortpy-add-custom-font-lock-keywords)
  (if fortpy-mode
      (progn
        (when fortpy-install-imenu
          (add-hook 'after-change-functions 'fortpy:after-change-handler nil t)
          (fortpy:defined-names-deferred)
          (setq imenu-create-index-function fortpy-imenu-create-index-function))
        (add-hook 'post-command-hook 'fortpy:handle-post-command nil t)
        (add-hook 'kill-buffer-hook 'fortpy:server-pool--gc-when-idle nil t))
    (remove-hook 'post-command-hook 'fortpy:handle-post-command t)
    (remove-hook 'after-change-functions 'fortpy:after-change-handler t)
    (remove-hook 'kill-buffer-hook 'fortpy:server-pool--gc-when-idle t)
    (fortpy:server-pool--gc-when-idle)))

;; Define keybinds.
(let ((map fortpy-mode-map))
  (define-key map (kbd "<C-tab>") 'fortpy-complete)
  (define-key map (kbd "M-?") 'fortpy-show-doc)
;;  Instead of adding these globally, they are controlled by fortpy-use-shortcuts
;;  if shortcuts are disabled, then they will have to use M-x.
;;  (define-key map (kbd "M-.") 'fortpy-goto-definition)
;;  (define-key map (kbd "M-,") 'fortpy-goto-definition-pop-marker)
  (define-key map [?\H-.] (lambda () 
                           (interactive) 
                           (insert "!!<summary></summary>") 
                           (backward-char 10)))
  (define-key map (kbd "H-y") (lambda () 
                               (interactive) 
                               (insert "!!<local name=\"\"></local>") 
                               (backward-char 10)))
  (define-key map (kbd "H-i") (lambda () 
                                (interactive) 
                                (insert "!!<member name=\"\"></member>") 
                                (backward-char 11)))
  (define-key map (kbd "H-p") (lambda () 
                               (interactive) 
                               (insert "!!<parameter name=\"\"></parameter>") 
                               (backward-char 14)))
  (define-key map [?\H-'] (lambda () 
                           (interactive) 
                           (insert "!!<comments></comments>") 
                           (backward-char 11)))
  (define-key map [?\H-,] (lambda () 
                           (interactive) 
                           (insert "@CREF[]") 
                           (backward-char 1)))
  (eval-after-load 'helm '(define-key map (kbd "C-c /") 'helm-fortpy-related-names)))


;;; EPC utils

(defun fortpy:epc--live-p (mngr)
  "Return non-nil when MNGR is an EPC manager object with a live
connection."
  (let ((proc (ignore-errors
                (epc:connection-process (epc:manager-connection mngr)))))
    (and (processp proc)
         ;; Same as `process-live-p' in Emacs >= 24:
         (memq (process-status proc) '(run open listen connect stop)))))

(defmacro fortpy:-with-run-on-error (body &rest run-on-error)
  (declare (indent 1))
  `(let ((something-happened t))
     (unwind-protect
         (prog1 ,body
           (setq something-happened nil))
       (when something-happened
         ,@run-on-error))))

(defun fortpy:epc--start-epc (server-prog server-args)
  "Same as `epc:start-epc', but set query-on-exit flag for
associated processes to nil."
  (let ((mngr (fortpy:-with-run-on-error
                  (epc:start-epc server-prog server-args)
                (display-warning 'fortpy "\
Failed to start Fortpy EPC server.
*** You may need to run \"M-x fortpy-install-server\". ***
This could solve the problem especially if you haven't run the command yet
since Fortpy.el installation or update and if the server complains about
Python module imports." :error))))
    (set-process-query-on-exit-flag (epc:connection-process
                                     (epc:manager-connection mngr))
                                    nil)
    (set-process-query-on-exit-flag (epc:manager-server-process mngr) nil)
    mngr))


;;; Server pool

(defvar fortpy:server-pool--table (make-hash-table :test 'equal)
  "A hash table that holds a pool of EPC server instances.")

(defun fortpy:server-pool--start (command)
  "Get an EPC server instance from server pool by COMMAND as a
key, or start new one if there is none."
  (let ((cached (gethash command fortpy:server-pool--table)))
    (if (and cached (fortpy:epc--live-p cached))
        cached
      (let* ((default-directory "/")
             (mngr (fortpy:epc--start-epc (car command) (cdr command))))
        (puthash command mngr fortpy:server-pool--table)
        (fortpy:server-pool--gc-when-idle)
        mngr))))

(defun fortpy:-get-servers-in-use ()
  "Return a list of non-nil `fortpy:epc' in all buffers."
  (loop with mngr-list
        for buffer in (buffer-list)
        for mngr = (with-current-buffer buffer fortpy:epc)
        when (and mngr (not (memq mngr mngr-list)))
        collect mngr into mngr-list
        finally return mngr-list))

(defvar fortpy:server-pool--gc-timer nil)

(defun fortpy:server-pool--gc ()
  "Stop unused servers."
  (let ((servers-in-use (fortpy:-get-servers-in-use)))
    (maphash
     (lambda (key mngr)
       (unless (memq mngr servers-in-use)
         (remhash key fortpy:server-pool--table)
         (epc:stop-epc mngr)))
     fortpy:server-pool--table))
  ;; Clear timer so that GC is started next time
  ;; `fortpy:server-pool--gc-when-idle' is called.
  (setq fortpy:server-pool--gc-timer nil))

(defun fortpy:server-pool--gc-when-idle ()
  "Run `fortpy:server-pool--gc' when idle."
  (unless fortpy:server-pool--gc-timer
    (setq fortpy:server-pool--gc-timer
          (run-with-idle-timer 10 nil 'fortpy:server-pool--gc))))


;;; Server management

(defun fortpy:start-server ()
  (if (fortpy:epc--live-p fortpy:epc)
      (message "Fortpy server is already started!")
    (setq fortpy:epc (fortpy:server-pool--start
                    (append fortpy-server-command fortpy-server-args))))
  fortpy:epc)

(defun fortpy-stop-server ()
  "Stop Fortpy server.  Use this command when you want to restart
Fortpy server (e.g., when you changed `fortpy-server-command' or
`fortpy-server-args').  Fortpy server will be restarted automatically
later when it is needed."
  (interactive)
  (if fortpy:epc
      (epc:stop-epc fortpy:epc)
    (message "Fortpy server is already killed."))
  (setq fortpy:epc nil)
  ;; It could be non-nil due to some error.  Rescue it in that case.
  (setq fortpy:get-in-function-call--d nil)
  (setq fortpy:defined-names--singleton-d nil))

(defun fortpy:get-epc ()
  (if (fortpy:epc--live-p fortpy:epc)
      fortpy:epc
    (fortpy:start-server)))

;;;###autoload
(defun fortpy-start-dedicated-server (command)
  "Start Fortpy server dedicated to this buffer.
This is useful, for example, when you want to use different
`sys.path' for some buffer.  When invoked as an interactive
command, it asks you how to start the Fortpy server.  You can edit
the command in minibuffer to specify the way Fortpy server run.

If you want to setup how Fortpy server is started programmatically
per-buffer/per-project basis, make `fortpy-server-command' and
`fortpy-server-args' buffer local and set it in `python-mode-hook'.
See also: `fortpy-server-args'."
  (interactive
   (list (split-string-and-unquote
          (read-string "Run Fortpy server: "
                       (mapconcat
                        #'identity
                        (append fortpy-server-command
                                fortpy-server-args)
                        " ")))))
  ;; Reset `fortpy:epc' so that a new server is created when COMMAND is
  ;; new.  If it is already in the server pool, the server instance
  ;; already in the pool is picked up by `fortpy:start-server'.
  (setq fortpy:epc nil)
  ;; Set `fortpy-server-command', so that this command is used
  ;; when restarting EPC server of this buffer.
  (set (make-local-variable 'fortpy-server-command) command)
  (set (make-local-variable 'fortpy-server-args) nil)
  (fortpy:start-server))

(defun fortpy:-buffer-file-name ()
  "Return `buffer-file-name' without text properties."
  (when (stringp buffer-file-name)
    (substring-no-properties buffer-file-name)))

(defun fortpy:call-deferred (method-name)
  "Call ``Script(...).METHOD-NAME`` and return a deferred object."
  (let ((source      (buffer-substring-no-properties (point-min) (point-max)))
        (line        (count-lines (point-min) (min (1+ (point)) (point-max))))
        (column      (current-column))
        (source-path (fortpy:-buffer-file-name)))
    (epc:call-deferred (fortpy:get-epc)
                       method-name
                       (list source line column source-path))))


;;; Completion

(defvar fortpy:complete-reply nil
  "Last reply to `fortpy:complete-request'.")

(defvar fortpy:complete-request-point 0
  ;; It is passed to `=', so do not initialize this value by `nil'.
  "The point where `fortpy:complete-request' is called.")

(defun fortpy:complete-request ()
  "Request ``Script(...).complete`` and return a deferred object.
`fortpy:complete-reply' is set to the reply sent from the server."
  (setq fortpy:complete-request-point (point))
  (deferred:nextc (fortpy:call-deferred 'complete)
    (lambda (reply)
      (setq fortpy:complete-reply reply))))

;;;###autoload
(defun* fortpy-complete (&key (expand ac-expand-on-auto-complete))
  "Complete code at point."
  (interactive)
  (lexical-let ((expand expand))
    (deferred:nextc (fortpy:complete-request)
      (lambda ()
        (let ((ac-expand-on-auto-complete expand))
          (ac-start :triggered 'command))))))
;; Calling `auto-complete' or `ac-update-greedy' instead of `ac-start'
;; here did not work.

(defun fortpy-percent-complete ()
  "Insert percent and complete code at point."
  (interactive)
  (insert "%")
  (unless (or (ac-cursor-on-diable-face-p)
              ;; don't complete if the percent is immediately after int literal
              (looking-back "\\(\\`\\|[^._[:alnum:]]\\)[0-9]+%"))
    (fortpy-complete :expand nil)))

(defun fortpy-bracket-complete ()
  "Insert bracket and complete code at point."
  (interactive)
  (insert "(")
  (unless (or (ac-cursor-on-diable-face-p)
              ;;don't complete if the bracket is immediately after 
              ;; +-/*= since that falls under arithmetic
              ;;and we are trying to complete function signatures.
              (looking-back "\\(\\`\\|[^._[:alnum:]]\\)[\\s-+\\-\/*=]+"))
    (fortpy-get-bracket-complete)))


;;; AC source

(defun fortpy:ac-direct-matches ()
  (mapcar
   (lambda (x)
     (destructuring-bind (&key word doc description symbol)
         x
       (popup-make-item word
                        :symbol symbol
                        :document (unless (equal doc "") doc)
                        :summary description)))
   fortpy:complete-reply))

(defun fortpy:ac-direct-prefix ()
  (or (ac-prefix-default)
      (when (= fortpy:complete-request-point (point))
        fortpy:complete-request-point)))

;; (makunbound 'ac-source-fortpy-direct)
(ac-define-source fortpy-direct
  '((candidates . fortpy:ac-direct-matches)
    (prefix . fortpy:ac-direct-prefix)
    (init . fortpy:complete-request)
    (requires . -1)))

;;;###autoload
(defun fortpy-ac-setup ()
  "Add Fortpy AC sources to `ac-sources'.

If auto-completion is all you need, you can call this function instead
of `fortpy-setup', like this::

   (add-hook 'python-mode-hook 'fortpy-ac-setup)

Note that this function calls `auto-complete-mode' if it is not
already enabled, for people who don't call `global-auto-complete-mode'
in their Emacs configuration."
  (interactive)
  (add-to-list 'ac-sources 'ac-source-fortpy-direct)
  (unless auto-complete-mode
    (auto-complete-mode)))

;;;###autoload
(defun fortpy-add-custom-font-lock-keywords()
  "Adds font-lock keywords to the f90 mode for the XML documentation strings."
  (interactive)
  (font-lock-add-keywords nil
                          `((,fortpy-regex-xml-tags 1 'fortpy-xml-doc-face prepend)
                            (,fortpy-regex-xml-doc-links 1 'fortpy-xml-doc-link-face prepend)
                            (,fortpy:regex-doc-comment (0 'fortpy-doc-comment-face t)
                                            (,fortpy:regex-xml-value nil nil
                                               (1 'fortpy-xml-doc-value-face t))
                            )
                            (,fortpy:regex-doc-comment ,fortpy:regex-xml-attribute nil nil 
			  		       (1 'fortpy-xml-doc-attribute-face t)
                            )
                            (,fortpy:regex-percent . 'fortpy-percent-face)
                            (,fortpy:regex-operator . 'fortpy-operator-face)
                            ))
  )


;;; Call signature (get_in_function_call)

(defface fortpy:highlight-function-argument
  '((t (:inherit bold)))
  "Face used for the argument at point in a function's argument list"
  :group 'fortpy)

(defun* fortpy:get-in-function-call--construct-call-signature
    (&key params index call_name description)
  (let ((current-arg (nth index params)))
    (when (and current-arg (null fortpy-tooltip-method))
      (setf (nth index params)
            (propertize current-arg 'face 'fortpy:highlight-function-argument)))
    (concat call_name "(" (mapconcat #'identity params ", ") ")\n\n" description )))

(defun fortpy:get-in-function-call--tooltip-show (args)
  (when (and args (not ac-completing))
    (let (
          (reply (getf args :reply))
          (replytype (getf args :replytype))
          )
      (cond
       ((equal replytype "signature")
        (fortpy:tooltip-show
         (apply #'fortpy:get-in-function-call--construct-call-signature reply)))
       ((equal replytype "completion")
        (setq fortpy:complete-reply reply))
       ))))

(defun fortpy:get-reparse-buffer-file-response (reply)
  (when reply
    (message (concat "Fortpy Reparse: " reply))
  ))

(defun fortpy-reparse-buffer-file ()
  "Manually reparse the current buffer file."
  (interactive)
  (message "Fortpy Reparse: Working...")
  (deferred:nextc
    (fortpy:call-deferred 'reparse_module)
    #'fortpy:get-reparse-buffer-file-response))

(defun fortpy-get-in-function-call ()
  "Manually show call signature tooltip."
  (interactive)
  (deferred:nextc
    (fortpy:call-deferred 'get_in_function_call)
    #'fortpy:get-in-function-call--tooltip-show))

(defun fortpy:get-in-function-call-when-idle ()
  "Show tooltip when Emacs is ilde."
  (unless fortpy:get-in-function-call--d
    (setq fortpy:get-in-function-call--d
          (deferred:try
            (deferred:$
              (deferred:wait-idle fortpy-get-in-function-call-delay)
              (deferred:nextc it
                (lambda ()
                  (when fortpy-mode         ; cursor may be moved
                    (deferred:timeout
                      fortpy-get-in-function-call-timeout
                      nil
                      (fortpy:call-deferred 'get_in_function_call)))))
              (deferred:nextc it #'fortpy:get-in-function-call--tooltip-show))
            :finally
            (lambda ()
              (setq fortpy:get-in-function-call--d nil))))))

(defun fortpy-get-bracket-complete ()
  "Manually show call signature tooltip after '('."
  (interactive)
  (deferred:nextc
    (fortpy:call-deferred 'bracket_complete)
    #'fortpy:get-bracket-complete--tooltip-show))

(defun fortpy:get-bracket-complete--tooltip-show (args)
  (message (getf args :call_name))
  (when (and args (not ac-completing))
    (fortpy:tooltip-show
     (apply #'fortpy:get-in-function-call--construct-call-signature args))))

(defun fortpy:tooltip-show (string)
  (cond
   ((and (memq 'pos-tip fortpy-tooltip-method) window-system
         (featurep 'pos-tip))
    (pos-tip-show (fortpy:string-fill-paragraph string)
                  'popup-tip-face nil nil 0))
   ((and (memq 'popup fortpy-tooltip-method)
         (featurep 'popup))
    (popup-tip string))
   (t (when (stringp string)
        (let ((message-log-max nil))
          (message string))))))

(defun fortpy:string-fill-paragraph (string &optional justify)
  (with-temp-buffer
    (erase-buffer)
    (insert string)
    (goto-char (point-min))
    (fill-paragraph justify)
    (buffer-string)))


;;; Goto

(defvar fortpy:goto-definition--index nil)
(defvar fortpy:goto-definition--cache nil)
(defvar fortpy:goto-definition--marker-ring
  (make-ring fortpy-goto-definition-marker-ring-length)
  "Marker ring that stores `fortpy-goto-definition' call positions")

(defun fortpy-goto-definition (&optional other-window deftype use-cache index)
  "Goto the definition of the object at point.

See `fortpy-goto-definition-config' for how this function works
when universal prefix arguments \(``C-u``) are given.  If
*numeric* prefix argument(s) \(e.g., ``M-0``) are given, goto
point of the INDEX-th result.  Note that you cannot mix universal
and numeric prefixes.  It is Emacs's limitation.  If you mix both
kinds of prefix, you get numeric prefix.

When used as a lisp function, popup a buffer when OTHER-WINDOW is
non-nil.  DEFTYPE must be either `assignment' (default) or
`definition'.  When USE-CACHE is non-nil, use the locations of
the last invocation of this command.  If INDEX is specified, goto
INDEX-th result."
  (interactive
   (if (integerp current-prefix-arg)
       (list nil nil nil current-prefix-arg)
     (nth (let ((i (car current-prefix-arg)))
            (if i (floor (log i 4)) 0))
          fortpy-goto-definition-config)))
  (cond
   ((and (or use-cache index)
         fortpy:goto-definition--cache)
    (setq fortpy:goto-definition--index (or index 0))
    (fortpy:goto-definition--nth other-window))
   ((and (eq last-command 'fortpy-goto-definition)
         (> (length fortpy:goto-definition--cache) 1))
    (fortpy-goto-definition-next other-window))
   (t
    (setq fortpy:goto-definition--index (or index 0))
    (lexical-let ((other-window other-window))
      (deferred:nextc (fortpy:call-deferred
                       (case deftype
                         ((assignment nil) 'goto)
                         (definition 'get_definition)
                         (t (error "Unsupported deftype: %s" deftype))))
        (lambda (reply)
          (fortpy:goto-definition--callback reply other-window)))))))

(defun fortpy:goto-definition-push-marker ()
  "Push point onto goto-definition marker ring."
  (ring-insert fortpy:goto-definition--marker-ring (point-marker)))

(defun fortpy-goto-definition-pop-marker ()
  "Goto the last point where `fortpy-goto-definition' was called."
  (interactive)
  (if (ring-empty-p fortpy:goto-definition--marker-ring)
      (error "Fortpy marker ring is empty, can't pop")
    (let ((marker (ring-remove fortpy:goto-definition--marker-ring 0)))
      (switch-to-buffer (or (marker-buffer marker)
                            (error "Buffer has been deleted")))
      (goto-char (marker-position marker))
      ;; Cleanup the marker so as to avoid them piling up.
      (set-marker marker nil nil))))

(defun fortpy-goto-definition-next (&optional other-window)
  "Goto the next cached definition.  See: `fortpy-goto-definition'."
  (interactive "P")
  (let ((len (length fortpy:goto-definition--cache))
        (n (1+ fortpy:goto-definition--index)))
    (setq fortpy:goto-definition--index (if (>= n len) 0 n))
    (fortpy:goto-definition--nth other-window)))

(defun fortpy:goto-definition--callback (reply other-window)
  (if (not reply)
      (message "Definition not found.")
    (setq fortpy:goto-definition--cache reply)
    (fortpy:goto-definition--nth other-window t)))

(defun fortpy:goto--line-column (line column)
  "Like `goto-char' but specify the position by LINE and COLUMN."
  (goto-char (point-min))
  (forward-line (1- line))
  (forward-char column))

;; TODO: this method is looking for a missing module in the __builtin__
;; set before throwing an error for non-existent files. If fortpy needs
;; to work over SSH with tramp, this will need some serious work;
;; probably the other goto methods also need a revamp before that works.
(defun fortpy:goto-definition--nth (other-window &optional try-next)
  (let* ((len (length fortpy:goto-definition--cache))
         (n fortpy:goto-definition--index)
         (next (lambda ()
                 (when (< n (1- len))
                   (incf fortpy:goto-definition--index)
                   (fortpy:goto-definition--nth other-window)
                   t))))
    (destructuring-bind (&key line_nr column module_path module_name
                              &allow-other-keys)
        (nth n fortpy:goto-definition--cache)
      (cond
       ((equal module_name "__builtin__")
        (unless (and try-next (funcall next))
          (message "Cannot see the definition of __builtin__.")))
       ((not (and module_path (file-exists-p module_path)))
        (unless (and try-next (funcall next))
          (message "File '%s' does not exist." module_path)))
       (t
        (fortpy:goto-definition-push-marker)
        (funcall (if other-window #'find-file-other-window #'find-file)
                 module_path)
        (fortpy:goto--line-column line_nr column)
        (fortpy:goto-definition--notify-alternatives len n))))))

(defun fortpy:goto-definition--notify-alternatives (len n)
  (unless (= len 1)
    (message
     "%d-th point in %d candidates.%s"
     (1+ n)
     len
     ;; Note: It must be `last-command', not `last-command' because
     ;;       this function is called in deferred at the first time.
     (if (eq last-command 'fortpy-goto-definition)
         (format "  Type %s to go to the next point."
                 (key-description
                  (car (where-is-internal 'fortpy-goto-definition))))
       ""))))


;;; Full name

(defun fortpy:get-full-name-deferred ()
  (deferred:$
    (fortpy:call-deferred 'get_definition)
    (deferred:nextc it
      (lambda (reply)
        (loop for def in reply
              do (destructuring-bind (&key full_name &allow-other-keys)
                     def
                   (when full_name
                     (return full_name))))))))

(defun* fortpy:get-full-name-sync (&key (timeout 500))
  (epc:sync
   (fortpy:get-epc)
   (deferred:timeout timeout nil (fortpy:get-full-name-deferred))))


;;; Related names

(defun fortpy:related-names--source (name candidates)
  `((name . ,name)
    (candidates . ,candidates)
    (recenter)
    (type . file-line)))

(defun fortpy:related-names--to-file-line (reply)
  (mapcar
   (lambda (x)
     (destructuring-bind
         (&key line_nr column module_name module_path description)
         x
       (format "%s:%s: %s - %s" module_path line_nr
               module_name description)))
   reply))

(defun fortpy:related-names--helm (helm)
  (lexical-let ((helm helm))
    (deferred:nextc
      (let ((to-file-line #'fortpy:related-names--to-file-line))
        (deferred:parallel
          (deferred:nextc (fortpy:call-deferred 'related_names) to-file-line)
          (deferred:nextc (fortpy:call-deferred 'goto)          to-file-line)))
      (lambda (candidates-list)
        (funcall
         helm
         :sources (list (fortpy:related-names--source "Fortpy Related Names"
                                                    (car candidates-list))
                        (fortpy:related-names--source "Fortpy Goto"
                                                    (cadr candidates-list)))
         :buffer (format "*%s fortpy:related-names*" helm))))))

;;;###autoload
(defun helm-fortpy-related-names ()
  "Find related names of the object at point using `helm' interface."
  (interactive)
  (fortpy:related-names--helm 'helm))


;;; Show document (get-definition)

(defvar fortpy:doc-buffer-name "*fortpy:doc*")

(defun fortpy-show-doc ()
  "Show the documentation of the object at point."
  (interactive)
  (deferred:nextc (fortpy:call-deferred 'get_definition)
    (lambda (reply)
      (with-current-buffer (get-buffer-create fortpy:doc-buffer-name)
        (loop with has-doc = nil
              with first = t
              with inhibit-read-only = t
              initially (erase-buffer)
              for def in reply
              do (destructuring-bind
                     (&key doc desc_with_module line_nr module_path
                           &allow-other-keys)
                     def
                   (unless (or (null doc) (equal doc ""))
                     (if first
                         (setq first nil)
                       (insert "\n\n---\n\n"))
                     (insert "Docstring for " desc_with_module "\n\n" doc)
                     (setq has-doc t)))
              finally do
              (if (not has-doc)
                  (message "Document not found.")
                (progn
                  (goto-char (point-min))
                  (when (fboundp fortpy-doc-mode)
                    (funcall fortpy-doc-mode))
                  (run-hooks 'fortpy-doc-hook)
                  (funcall fortpy-doc-display-buffer (current-buffer)))))))))


;;; Defined names (imenu)

(defvar fortpy:defined-names--cache nil)
(make-variable-buffer-local 'fortpy:defined-names--cache)

(defun fortpy:defined-names-deferred ()
  (deferred:nextc
    (epc:call-deferred
     (fortpy:get-epc)
     'defined_names
     (list (buffer-substring-no-properties (point-min) (point-max))
           (fortpy:-buffer-file-name)))
    (lambda (reply)
      (setq fortpy:defined-names--cache reply))))

(defun fortpy:defined-names--singleton-deferred ()
  "Like `fortpy:defined-names-deferred', but make sure that only
one request at the time is emitted."
  (unless fortpy:defined-names--singleton-d
    (setq fortpy:defined-names--singleton-d
          (deferred:watch (fortpy:defined-names-deferred)
            (lambda (_) (setq fortpy:defined-names--singleton-d nil))))))

(defun fortpy:defined-names--sync ()
  (unless fortpy:defined-names--cache
    (epc:sync (fortpy:get-epc) (fortpy:defined-names--singleton-deferred)))
  fortpy:defined-names--cache)

(defun fortpy:after-change-handler (&rest _)
  (unless (or (ac-menu-live-p) (ac-inline-live-p))
    (fortpy:defined-names--singleton-deferred)))

(defun fortpy:imenu-make-marker (def)
  (destructuring-bind (&key line_nr column &allow-other-keys) def
    (save-excursion (fortpy:goto--line-column line_nr column)
                    (point-marker))))

(defun fortpy:create-nested-imenu-index--item (def)
  (cons (plist-get def :name) (fortpy:imenu-make-marker def)))

(defun fortpy:create-nested-imenu-index ()
  "`imenu-create-index-function' for Fortpy.el.
See also `fortpy-imenu-create-index-function'."
  (when (called-interactively-p 'interactive) (fortpy:defined-names--sync))
  (fortpy:create-nested-imenu-index-1))

(defun fortpy:create-nested-imenu-index-1 (&optional items)
  (loop for (def . subdefs) in (or items fortpy:defined-names--cache)
        if subdefs
        collect (append
                 (list (plist-get def :local_name)
                       (fortpy:create-nested-imenu-index--item def))
                 (fortpy:create-nested-imenu-index-1 subdefs))
        else
        collect (fortpy:create-nested-imenu-index--item def)))

(defun fortpy:create-flat-imenu-index ()
  "`imenu-create-index-function' for Fortpy.el to create flatten index.
See also `fortpy-imenu-create-index-function'."
  (when (called-interactively-p 'interactive) (fortpy:defined-names--sync))
  (fortpy:create-flat-imenu-index-1))

(defun fortpy:create-flat-imenu-index-1 (&optional items)
  (loop for (def . subdefs) in (or items fortpy:defined-names--cache)
        collect (cons (plist-get def :local_name) (fortpy:imenu-make-marker def))
        when subdefs
        append (fortpy:create-flat-imenu-index-1 subdefs)))


;;; Meta info

(defun fortpy-show-setup-info ()
  "Show installation and configuration info in a buffer.
Paste the result of this function when asking question or
reporting bug.  This command also tries to detect errors when
communicating with Fortpy EPC server.  If you have some problem you
may find some information about communication error."
  (interactive)
  (let (epc get-epc-error version-reply)
    (condition-case err
        (setq epc (fortpy:get-epc))
      (error (setq get-epc-error err)))
    (when epc
      (setq version-reply
            (condition-case err
                (epc:sync
                 epc
                 (deferred:$
                   (deferred:timeout 500
                     '(:timeout nil)
                     (epc:call-deferred epc 'get_fortpy_version nil))
                   (deferred:error it
                     (lambda (err) `(:error ,err)))))
              (error `(:sync-error ,err)))))
    (let ((standard-output (get-buffer-create "*fortpy-show-setup-info*")))
      (with-current-buffer standard-output
        (emacs-lisp-mode)
        (erase-buffer)
        (insert ";; Emacs Lisp version:\n")
        (pp `(:emacs-version ,emacs-version
              :fortpy-version ,fortpy:version
              :python-environment-version ,python-environment-version))
        (insert ";; Python version:\n")
        (pp version-reply)
        (when get-epc-error
          (insert "\n;; EPC error:\n")
          (pp `(:get-epc-error ,get-epc-error)))
        (insert ";; Command line:\n")
        (pp `(:virtualenv
              ,(executable-find (car python-environment-virtualenv))
              :virtualenv-version
              ,(ignore-errors (fortpy:-virtualenv-version))))
        (insert ";; Customization:\n")
        (pp (fortpy:-list-customization))
        (display-buffer standard-output)))))

(defun fortpy:-list-defcustoms ()
  (loop for sym being the symbols
        for name = (symbol-name sym)
        when (and (or (string-prefix-p "fortpy:" name)
                      (string-prefix-p "python-environment-" name))
                  (custom-variable-p sym))
        collect sym))

(defun fortpy:-list-customization ()
  (loop for sym in (sort (fortpy:-list-defcustoms)
                         (lambda (x y)
                           (string< (symbol-name x)
                                    (symbol-name y))))
        collect (cons sym (symbol-value sym))))

(defun fortpy:-virtualenv-version ()
  "Return output of virtualenv --version"
  (with-temp-buffer
    (erase-buffer)
    (call-process (executable-find (car python-environment-virtualenv))
                  nil t nil
                  "--version")
    (buffer-string)))

(defun fortpy:get-fortpy-version-request ()
  "Request version of Python modules and return a deferred object."
  (epc:call-deferred (fortpy:get-epc) 'get_fortpy_version nil))

(defun fortpy-show-version-info ()
  "Show version info of Python modules used by the server.
Paste the result of this function in bug report."
  (interactive)
  (deferred:nextc (fortpy:get-fortpy-version-request)
    (lambda (reply)
      (let ((standard-output (get-buffer-create "*fortpy:version*")))
        (with-current-buffer standard-output
          (emacs-lisp-mode)
          (erase-buffer)
          (pp `(:emacs-version ,emacs-version :fortpy-version ,fortpy:version))
          (pp reply)
          (display-buffer standard-output))))))

(defun fortpy:print-fortpy-version ()
  (pp (epc:sync (fortpy:get-epc) (fortpy:get-fortpy-version-request))))


;;; Setup

;;;###autoload
(defun fortpy-setup ()
  "Fully setup fortpy.el for current buffer.
It setups `ac-sources' (calls `fortpy-ac-setup') and turns
`fortpy-mode' on.

This function is intended to be called from `python-mode-hook',
like this::

       (add-hook 'python-mode-hook 'fortpy-setup)

You can also call this function as a command, to quickly test
what fortpy can do."
  (interactive)
  (fortpy-ac-setup)
  (fortpy-mode 1))


;;; Virtualenv setup
(defvar fortpy:install-server--command
  `("pip" "install" "--upgrade" ,(convert-standard-filename fortpy:source-dir)))

;;;###autoload
(defun fortpy-install-server ()
  "This command installs Fortpy server script fortpyepcserver.py in a
Python environment dedicated to Emacs.  By default, the
environment is at ``~/.emacs.d/.python-environments/default/``.
This environment is automatically created by ``virtualenv`` if it
does not exist.

Run this command (i.e., type ``M-x fortpy-install-server RET``)
whenever Fortpy.el shows a message to do so.  It is a good idea to
run this every time after you update Fortpy.el to sync version of
Python modules used by Fortpy.el and Fortpy.el itself.

You can modify the location of the environment by changing
`fortpy-environment-root' and/or `python-environment-directory'.  More
specifically, Fortpy.el will install Python modules under the directory
``PYTHON-ENVIRONMENT-DIRECTORY/FORTPY-ENVIRONMENT-ROOT``.  Note that you
need command line program ``virtualenv``.  If you have the command in
an unusual location, use `python-environment-virtualenv' to specify the
location.

.. NOTE:: fortpyepcserver.py is installed in a virtual environment but it
   does not mean Fortpy.el cannot recognize the modules in virtual
   environment you are using for your Python development.  Fortpy
   EPC server recognize the virtualenv it is in (i.e., the
   environment variable ``VIRTUAL_ENV`` in your Emacs) and then
   add modules in that environment to its ``sys.path``.  You can
   also add ``--virtual-env PATH/TO/ENV`` to `fortpy-server-args'
   to include modules of virtual environment even you launch
   Emacs outside of the virtual environment.

.. NOTE:: It is highly recommended to use this command to install
   Python modules for Fortpy.el.  You still can install Python
   modules used by Fortpy.el manually.  However, you are then
   responsible for keeping Fortpy.el and Python modules compatible."
  (interactive)
  (deferred:$
    (python-environment-run fortpy:install-server--command
                            fortpy-environment-root
                            fortpy-environment-virtualenv)
    (deferred:watch it
      (lambda (_)
        (setq-default fortpy-server-command (fortpy:-env-server-command))))))

;;;###autoload
(defun fortpy:install-server-block ()
  "Blocking version `fortpy-install-server'."
  (prog1
      (python-environment-run-block fortpy:install-server--command
                                    fortpy-environment-root
                                    fortpy-environment-virtualenv)
    (setq-default fortpy-server-command (fortpy:-env-server-command))))


;;; Debugging

(defun fortpy-pop-to-epc-buffer ()
  "Open the buffer associated with EPC server process.
Use this command to see the output (e.g., traceback) of the server process."
  (interactive)
  (pop-to-buffer (process-buffer (epc:manager-server-process fortpy:epc))))

(defun fortpy-toggle-log-traceback ()
  "Toggle on/off traceback logging for EPC server for the current buffer.
When there is an error during traceback logging is enabled, traceback
is printed in the EPC buffer.  You can use `fortpy-pop-to-epc-buffer' to
open that buffer.

You can also pass ``--log-traceback`` option to fortpyepcserver.py
to start server with traceback logging turned on.  This is useful when
there is a problem in communication (thus this command does not work).
You can use `fortpy-start-dedicated-server' to restart EPC server for the
current buffer with specific arguments."
  (interactive)
  (deferred:$
    (epc:call-deferred (fortpy:get-epc) 'toggle_log_traceback nil)
    (deferred:nextc it
      (lambda (flag)
        (message "Traceback logging is %s" (if flag "enabled" "disabled"))))))

(defvar fortpy:server-command--backup nil)
(defvar fortpy:server-args--backup nil)

(defun fortpy-toggle-debug-server ()
  "Setup `fortpy-server-command' and `fortpy-server-args' to debug
server using pdb or ipdb.

When this command is called, it essentially execute the following
code::

  (fortpy-stop-server)
  (setq fortpy-server-command (list \"cat\" \"fortpy-port.log\" )
        fortpy-server-args nil)

It means to pass the port number recorded in the file
fortpy-port.log to EPC client.

To start Fortpy server in terminal and record port to the file,
use the following command::

   python fortpyepcserver.py --port-file fortpy-port.log --pdb

This command will be copied in the kill-ring (clipboard) when
this command is called.  You can use `--ipdb` instead of `--pdb`
to use ipdb instead of pdb.

Calling this command again restores the original setting of
`fortpy-server-command' and `fortpy-server-args' then stops the
running server."
  (interactive)
  (if fortpy:server-command--backup
      (progn
        (setq fortpy-server-command fortpy:server-command--backup
              fortpy:server-command--backup nil
              fortpy-server-args fortpy:server-args--backup)
        (fortpy-stop-server)
        (message "Quit debugging.  Original setting restored."))
    (setq fortpy:server-command--backup fortpy-server-command
          fortpy:server-args--backup fortpy-server-args
          fortpy-server-command (list "cat" (expand-file-name
                                           "fortpy-port.log" fortpy:source-dir))
          fortpy-server-args nil)
    (fortpy-stop-server)
    (kill-new "python fortpyepcserver.py --port-file fortpy-port.log --ipdb")
    (message "Now, start server with: --port-file fortpy-port.log --ipdb.\
 (command is copied in the kill-ring)")))


(provide 'fortpy)

;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:

;;; fortpy.el ends here
