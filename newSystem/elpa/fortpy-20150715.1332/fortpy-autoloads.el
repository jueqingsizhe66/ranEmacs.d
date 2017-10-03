;;; fortpy-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "fortpy" "fortpy.el" (22991 33511 0 0))
;;; Generated autoloads from fortpy.el

(autoload 'fortpy-start-dedicated-server "fortpy" "\
Start Fortpy server dedicated to this buffer.
This is useful, for example, when you want to use different
`sys.path' for some buffer.  When invoked as an interactive
command, it asks you how to start the Fortpy server.  You can edit
the command in minibuffer to specify the way Fortpy server run.

If you want to setup how Fortpy server is started programmatically
per-buffer/per-project basis, make `fortpy-server-command' and
`fortpy-server-args' buffer local and set it in `python-mode-hook'.
See also: `fortpy-server-args'.

\(fn COMMAND)" t nil)

(autoload 'fortpy-complete "fortpy" "\
Complete code at point.

\(fn &key (expand ac-expand-on-auto-complete))" t nil)

(autoload 'fortpy-ac-setup "fortpy" "\
Add Fortpy AC sources to `ac-sources'.

If auto-completion is all you need, you can call this function instead
of `fortpy-setup', like this::

   (add-hook 'python-mode-hook 'fortpy-ac-setup)

Note that this function calls `auto-complete-mode' if it is not
already enabled, for people who don't call `global-auto-complete-mode'
in their Emacs configuration.

\(fn)" t nil)

(autoload 'fortpy-add-custom-font-lock-keywords "fortpy" "\
Adds font-lock keywords to the f90 mode for the XML documentation strings.

\(fn)" t nil)

(autoload 'helm-fortpy-related-names "fortpy" "\
Find related names of the object at point using `helm' interface.

\(fn)" t nil)

(autoload 'fortpy-setup "fortpy" "\
Fully setup fortpy.el for current buffer.
It setups `ac-sources' (calls `fortpy-ac-setup') and turns
`fortpy-mode' on.

This function is intended to be called from `python-mode-hook',
like this::

       (add-hook 'python-mode-hook 'fortpy-setup)

You can also call this function as a command, to quickly test
what fortpy can do.

\(fn)" t nil)

(autoload 'fortpy-install-server "fortpy" "\
This command installs Fortpy server script fortpyepcserver.py in a
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
   responsible for keeping Fortpy.el and Python modules compatible.

\(fn)" t nil)

(autoload 'fortpy:install-server-block "fortpy" "\
Blocking version `fortpy-install-server'.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("fortpy-pkg.el") (22991 33511 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; fortpy-autoloads.el ends here
