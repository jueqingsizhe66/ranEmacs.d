;;; setup-eww.el --- browse internet                 -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Ye Zhaoliang

;; Author: Ye Zhaoliang <yzl@DESKTOP-MVNHR6D>
;; Keywords: news, 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (eval-after-load "eww"                                                     ;;
;;   '(progn (define-key eww-mode-map "f" 'eww-lnum-follow)                   ;;
;;           (define-key eww-mode-map "F" 'eww-lnum-universal)))              ;;
;;                                                                            ;;
;; (with-eval-after-load 'eww                                                 ;;
;;   (custom-set-variables                                                    ;;
;;    '(eww-search-prefix " https://cn.bing.com/search?q="))                  ;;
;;                                                                            ;;
;;   (define-key eww-mode-map "H" 'eww-back-url)                              ;;
;;   ;; (define-key eww-mode-map (kbd "H") 'eww-back-url)                     ;;
;;   (define-key eww-mode-map (kbd "L") 'eww-forward-url)                     ;;
;;                                                                            ;;
;;   (define-key eww-mode-map (kbd "b") 'eww-history-browse)                  ;;
;;   (define-key eww-mode-map (kbd "B") 'eww-bookmark-browse)                 ;;
;;   (define-key eww-mode-map (kbd "a") 'eww-add-bookmark)                    ;;
;;   (define-key eww-mode-map (kbd "r") 'eww-reload)                          ;;
;;   (define-key eww-mode-map (kbd "c") 'eww-browse-with-external-browser)    ;;
;;   (define-key eww-mode-map (kbd "i") 'eww)                                 ;;
;;   (define-key eww-mode-map (kbd "m") 'eww-lnum-follow)                     ;;
;;   (define-key eww-mode-map (kbd "z") 'eww-lnum-universal)                  ;;
;;                                                                            ;;
;;                                                                            ;;
;;   (define-key eww-mode-map (kbd "<C-S-iso-lefttab>") 'eww-previous-buffer) ;;
;;   (define-key eww-mode-map (kbd "<C-tab>")           'eww-next-buffer)     ;;
;;   )                                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cl-lib)

(defun eww-tag-pre (dom)
  (let ((shr-folding-mode 'none)
        (shr-current-font 'default))
    (shr-ensure-newline)
    (insert (eww-fontify-pre dom))
    (shr-ensure-newline)))

(defun eww-fontify-pre (dom)
  (with-temp-buffer
    (shr-generic dom)
    (let ((mode (eww-buffer-auto-detect-mode)))
      (when mode
        (eww-fontify-buffer mode)))
    (buffer-string)))

(defun eww-fontify-buffer (mode)
  (delay-mode-hooks (funcall mode))
  (font-lock-default-function mode)
  (font-lock-default-fontify-region (point-min)
                                    (point-max)
                                    nil))

(defun eww-buffer-auto-detect-mode ()
  (let* ((map '((ada ada-mode)
                (awk awk-mode)
                (c c-mode)
                (cpp c++-mode)
                (clojure clojure-mode lisp-mode)
                (csharp csharp-mode java-mode)
                (css css-mode)
                (dart dart-mode)
                (delphi delphi-mode)
                (emacslisp emacs-lisp-mode)
                (erlang erlang-mode)
                (fortran fortran-mode)
                (fsharp fsharp-mode)
                (go go-mode)
                (groovy groovy-mode)
                (haskell haskell-mode)
                (html html-mode)
                (java java-mode)
                (javascript javascript-mode)
                (json json-mode javascript-mode)
                (latex latex-mode)
                (lisp lisp-mode)
                (lua lua-mode)
                (matlab matlab-mode octave-mode)
                (objc objc-mode c-mode)
                (perl perl-mode)
                (php php-mode)
                (prolog prolog-mode)
                (python python-mode)
                (r r-mode)
                (ruby ruby-mode)
                (rust rust-mode)
                (scala scala-mode)
                (shell shell-script-mode)
                (smalltalk smalltalk-mode)
                (sql sql-mode)
                (swift swift-mode)
                (visualbasic visual-basic-mode)
                (xml sgml-mode)))
         (language (language-detection-string
                    (buffer-substring-no-properties (point-min) (point-max))))
         (modes (cdr (assoc language map)))
         (mode (cl-loop for mode in modes
                        when (fboundp mode)
                        return mode)))
    (message (format "%s" language))
    (when (fboundp mode)
      mode)))

(setq shr-external-rendering-functions
      '((pre . eww-tag-pre)))

; https://github.com/dakrone/eos/blob/master/eos-web.org
(use-package eww
  :defer t
  :init
  (setq browse-url-browser-function
        '((".*google.*maps.*" . browse-url-generic)
          ;; Github goes to firefox, but not gist
          ("http.*\/\/github.com" . browse-url-generic)
          ("groups.google.com" . browse-url-generic)
          ("docs.google.com" . browse-url-generic)
          ("melpa.org" . browse-url-generic)
          ("build.*\.elastic.co" . browse-url-generic)
          (".*-ci\.elastic.co" . browse-url-generic)
          ("internal-ci\.elastic\.co" . browse-url-generic)
          ("zendesk\.com" . browse-url-generic)
          ("salesforce\.com" . browse-url-generic)
          ("stackoverflow\.com" . browse-url-generic)
          ("apache\.org\/jira" . browse-url-generic)
          ("thepoachedegg\.net" . browse-url-generic)
          ("zoom.us" . browse-url-generic)
          ("t.co" . browse-url-generic)
          ("twitter.com" . browse-url-generic)
          ("\/\/a.co" . browse-url-generic)
          ("youtube.com" . browse-url-generic)
          ("amazon.com" . browse-url-generic)
          ("slideshare.net" . browse-url-generic)
          ("." . eww-browse-url)))
  (setq shr-external-browser 'browse-url-generic)
  (setq browse-url-generic-program (executable-find "firefox"))
  (add-hook 'eww-mode-hook #'toggle-word-wrap)
  (add-hook 'eww-mode-hook #'visual-line-mode)
  :config
  (use-package s :ensure t)
  (define-key eww-mode-map "o" 'eww)
  (define-key eww-mode-map "O" 'eww-browse-with-external-browser)
  (define-key eww-mode-map "a" 'eww-add-bookmark)
  (define-key eww-mode-map "b" 'eww-history-browse)
  (define-key eww-mode-map "r" 'eww-reload)
  (define-key eww-mode-map "m" 'eww-lnum-follow)
  (define-key eww-mode-map "B" 'eww-bookmark-browse)
  (define-key eww-mode-map "<C-tab>" 'eww-next-buffer)
  (define-key eww-mode-map "<C-S-tab>" 'eww-previous-buffer)

  ;; 有时候不ut
  (use-package eww-lnum
    :ensure t
    :config
    (bind-key "f" #'eww-lnum-follow eww-mode-map)
    (bind-key "U" #'eww-lnum-universal eww-mode-map))
  ;; open link in eww pages
  ;; 你的最爱
  (use-package link-hint
    :ensure t
    :bind ("C-c f" . link-hint-open-link))
  )

(global-set-key (kbd "C-x m") 'browse-url-at-point)
