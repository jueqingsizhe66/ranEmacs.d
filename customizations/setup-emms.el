;; =============================================================================

;; emms mode settings ===================================================
;;   ___ _ __ ___  _ __ ___  ___
;;  / _ \ '_ ` _ \| '_ ` _ \/ __|
;; |  __/ | | | | | | | | | \__ \
;;  \___|_| |_| |_|_| |_| |_|___/
;;
(require 'emms-setup)
(emms-all)
(require 'emms-i18n)
(require 'emms-history)

;; (emms-default-players)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq emms-player-list       ;;
;;       '(emms-player-mplayer  ;;
;;         emms-player-mpg321   ;;
;;         emms-player-ogg123)) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; use mplayer , that's enough!
(setq emms-player-list '(emms-player-mplayer) emms-player-mplayer-command-name "mplayer" emms-player-mplayer-parameters '("-slave"))

(setq emms-playlist-buffer-name "*Music*")

(add-hook 'emms-player-started-hook 'emms-show)
(setq emms-show-format "Now Playing: %s")
(setq emms-source-file-default-directory "H:/Classic/") ;;depend on yourself!! Change your music or movie directory

;; emms-playlist mode keys map
(global-set-key (kbd "C-c m s") 'emms-stop)
(global-set-key (kbd "C-c m P") 'emms-pause)
(global-set-key (kbd "C-c m n") 'emms-next)
(global-set-key (kbd "C-c m p") 'emms-previous)
(global-set-key (kbd "C-c m f") 'emms-show)
(global-set-key (kbd "C-c m >") 'emms-seek-forward)
(global-set-key (kbd "C-c m <") 'emms-seek-backward)

(global-set-key (kbd "C-c m S") 'emms-start)
(global-set-key (kbd "C-c m g") 'emms-playlist-mode-go)
(global-set-key (kbd "C-c m d") 'emms-play-directory-tree)
(global-set-key (kbd "C-c m h") 'emms-shuffle)
(global-set-key (kbd "C-c m e") 'emms-play-file)
(global-set-key (kbd "C-c m l") 'emms-play-playlist)
(global-set-key (kbd "C-c m r") 'emms-toggle-repeat-track)
(global-set-key (kbd "C-c m R") 'emms-toggle-repeat-playlist)

(add-hook 'emms-playlist-mode-hook
          (lambda ()
(toggle-truncate-lines 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun play-smooth-jazz ()                                              ;;
;;   "Start up some nice Jazz"                                             ;;
;;   (interactive)                                                         ;;
;;   (emms-play-streamlist "http://thejazzgroove.com/itunes.pls"))         ;;
;;                                                                         ;;
;; (defun play-smooth-Ambient ()                                           ;;
;;   "Start up some nice Ambient"                                          ;;
;;   (interactive)                                                         ;;
;;   (emms-play-streamlist "http://stereoscenic.com/pls/pill-hi-mp3.pls")) ;;
;;                                                                         ;;
;; (defun play-smooth-Trance ()                                            ;;
;;   "Start up some nice Trance"                                           ;;
;;   (interactive)                                                         ;;
;;   (emms-play-streamlist "http://www.1.fm/tunein/trance64k.pls"))        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (define-sequence 'personal-music-map "<f9> m" 'emms-play-streamlist ;;
;;   '(("a" "http://stereoscenic.com/pls/pill-hi-mp3.pls") ;; Ambient  ;;
;;     ("t" "http://www.1.fm/tunein/trance64k.pls")        ;; Trance   ;;
;;     ("j" "http://thejazzgroove.com/itunes.pls")))       ;; Jazz     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
