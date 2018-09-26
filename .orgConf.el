;;;org开始设置
(setq load-path (cons "~/.emacs.d/lisp" load-path))
(setq load-path (cons "~/.emacs.d/contrib/lisp" load-path))
(require 'org-install)
(require 'org)
;(require 'org-mouse) ;;加载这个包报错 muse变量未定义
;把下面几行加到 .emacs 文件里。后三行是为命令定义全局快捷键――请改成适合你自己的。 
;设置之后，打开 .org 扩展的文件会自动进入 org 模式;
;; The following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\|wiki\\)$" . org-mode))
(setq shr-external-browser "chromium-browser")
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
;(global-set-key "\C-c l" 'org-store-link) ;;有问题
;(global-set-key "\C-c a" 'org-agenda) ;; 有问题
;(global-set-key "\C-c b" 'org-iswitchb)  ;; 有问题
(global-set-key (kbd "C-c l") 'org-store-link)    ;;
(global-set-key (kbd "C-c a")  'org-agenda)           ;; 
(global-set-key (kbd "C-c b") 'org-iswitchb) ;; 原来是因为多了一个空格

(setq org-hide-leading-starts t)

; <2018-05-02 04:49> add by yzl
(setq org-hide-emphasis-markers t)

(setq org-log-done t)
;(setq which-func-mode t)  ;; start the which-function-mode to let you capture the template code with c-c c c!!!
; which func-mode had been obsolete , use which-function-mode instead
(setq which-function-mode t)  ;; start the which-function-mode to let you capture the template code with c-c c c!!!
(setq org-startup-indented t)  ;; or M-x org-indent-mode  to clean the org file 
(setq auto-image-file-mode t)  ;;  let emacs show image

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subTodo Entries are done,to TODO otherwise."
  (let (org-log-done org-log-states) ;; turn-off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;(setq org-doing-file "~/.emacs.d/GTD/orgBoss/newgtd.org")
;(if (boundp 'org-user-agenda-files)
;  (setq org-agenda-files org-user-agenda-files)
 (setq org-agenda-files (list
                       "~/.emacs.d/GTD/orgBoss/newgtd.org" 
                       "~/.emacs.d/GTD/orgBoss/Book/book.org"
                       "~/.emacs.d/GTD/orgBoss/Clipboard/clipboard.org"
                       "~/.emacs.d/GTD/orgBoss/DailyReview/daily.org"
                       "~/.emacs.d/GTD/orgBoss/Financial/finances.org"
                       "~/.emacs.d/GTD/orgBoss/Film/film.org"
                       "~/.emacs.d/GTD/orgBoss/IDEA/idea.org"
                       "~/.emacs.d/GTD/orgBoss/Journal/journal.org"
                       "~/.emacs.d/GTD/orgBoss/Private/privnotes.org"
                       "~/.emacs.d/GTD/orgBoss/Someday/someday.org"
                       "~/.emacs.d/GTD/orgBoss/Vocab/vocab.org"
                       "~/.emacs.d/GTD/orgBoss/Site/www.site.org"
                       "~/.emacs.d/GTD/orgBoss/writing.org"
                       "~/.emacs.d/GTD/orgBoss/Habit/habits.org"
                       "~/.emacs.d/GTD/phd1.org"
                       "~/.emacs.d/GTD/Dissertation.org"
                       "~/.emacs.d/GTD/thesis-proposal.org"
                       ;(append (file-expand-wildcards "~/.emacs.d/GTD/orgBoss/Journal/2*"))
                       ;"~/.emacs.d/GTD/orgBoss/Journal/"
                        ))  



(setq org-agenda-files (append (file-expand-wildcards "~/.emacs.d/GTD/OrgBoss/Journal/2*") org-agenda-files))
;;C-c C-w to redefine terms to different files
; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))




(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

;;;refile done!!!
;
;(add-to-list 'load-path "~/.emacs.d/chinese-pyim/")
;(require 'chinese-pyim)
;; activate the chinise-pyim

;(setq default-input-method "chinese-pyim")
;先凑合着用  直接内置的  可以使用
;(setq default-input-method "chinese-py-punct")
;(setq pyim-use-tooltop t)
;(global-set-key [C-f11] 'toggle-input-method)
;(global-set-key [C-SPC] 'toggle-input-method) ;;又一次报错提醒
;(global-set-key [C-f12] 'pyim-toggle-full-width-punctuation)

;(defun pyim-use-dict:bigdict ()
;  (interactive)
;  (setq pyim-dicts
;        '((:name "BigDict"
;                 :file "~/.emacs.d/chinese-pyim/pyim-bigdict.txt"
;                 :coding utf-8-unix)))
;  (pyim-restart-1 t))

;(require 'chinese-pyim-company)
;(setq pyi-company-predict-words-number 10)
;(require 'ibus)
;(add-hook 'after-init-hook 'ibus-mode-on)

;;; 注意路径得写对了
;(add-to-list 'load-path "/usr/share/emacs/24.3/lisp/org/")

;;<2017-10-22 15:23>  
;https://github.com/jueqingsizhe66/ranEmacs.d#73-%E5%85%B3%E4%BA%8E%E6%97%B6%E9%97%B4%E6%A0%BC%E5%BC%8F%E7%9A%84%E8%AF%B4%E6%98%8E
;M-x today
;(add-to-list 'load-path "~/.emacs.d/GTD/muse-3.20/lisp")
; (add-to-list 'load-path "~/.emacs.d/GTD/planner-3.42")
; (add-to-list 'load-path "~/.emacs.d/GTD/remember-2.0")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  (setq planner-project "WikiPlanner")                                                            ;;
;;      (setq muse-project-alist                                                                    ;;
;;            '(("WikiPlanner"                                                                      ;;
;;              ("~/.emacs.d/GTD/myPlan/"   ;; Or wherever you want your planner files to be        ;;
;;              :default "index"                                                                    ;;
;;              :major-mode planner-mode                                                            ;;
;; 	     :visit-link planner-visit-link))))                                                     ;;
;;  ;    (require 'planner)                                                                         ;;
;; ;(require 'remember)                                                                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;<2017-10-22 15:24> end
;(org-remember-insinuate) 
;; You cannot use ctrl+alt+f12 ubuntu  terminal global key
 ;(setq org-default-notes-file  "~/.emacs.d/GTD/.notes.org") 
 ;(define-key global-map [f12] 'org-remember) 
 ;(setq org-remember-templates 
 ;      '(("TODO" ?t "* TODOS %^{TO DO What(Briefly)} \n %?" "~/.emacs.d/GTD/.notes.org" "TODO") 
 ;    ("IDEA" ?i "* TODO %^{What's your IDEA (Briefly)} \n %?" "~/.emacs.d/GTD/.notes.org" "IDEA") 
 ;    ("MOVIE" ?m "* TODO %^{Enter the Movie Name}\n %?" "~/.emacs.d/GTD/.notes.org" "MOVIE") 
 ;    ("SITES" ?s "* %^{Enter the Name of the Site}\n %?" "~/.emacs.d/GTD/.notes.org" "SITES") 
 ;   ("BlogToPublish" ?b "* %^{Enter the Name of the Blog}\n %a %?" "~/.emacs.d/GTD/.notes.org" "BlogToPublish")))
 
;接下来我对Remember的配置如下:
;事先规划好 几个文件的地方
 (setq org-directory "~/.emacs.d/GTD/orgBoss/")
 (setq org-default-notes-file "~/.emacs.d/GTD/orgBoss/.notes")
 (setq remember-annotation-functions '(org-remember-annotation))
 (setq remember-handler-functions '(org-remember-handler))
 (add-hook 'remember-mode-hook 'org-remember-apply-template)
;; (define-key global-map (kbd "C-c r") 'org-remember)
 (define-key global-map (kbd "C-c c") 'org-capture)

;("j" "Journal"   "~/.emacs.d/GTD/orgBoss/Journal/journal.org" "** %^{Head Line} %U %^g\n%i%?"  )

(defvar my/org-basic-task-template
"* TODO %^{Task}
:PROPERTIES:
:Effort: %^{effort|1:00|0:05|0:15|0:30|2:00|4:00}
:END:
Captured %<%Y-%m-%d %H:%M>
%?

%i
")
(defvar org-jou-dir "~/.emacs.d/GTD/orgBoss/Journal/"
"gtd org files location")

;(setq org-default-notes-file (expand-file-name "index.org" org-agenda-dir))
(setq current-time-file (expand-file-name (format-time-string "%Y%m%d") org-jou-dir))

(defun my/expense-template ()
  (format "Hello world %s" (plist-get org-capture-plist :account)))
(setq org-capture-templates 
      '(("l" "灵感" entry (file+headline "~/.emacs.d/GTD/orgBoss/writing.org" "创意") 
                        "* %?\n %i\n %a")
;; file+datetree changed to file+olp-dateree 
        ("J" "Journal" entry (file+olp+datetree "~/.emacs.d/GTD/orgBoss/Journal/journal.org" ) 
                        "* %? [#B] \n输入于： %U\n %i\n\n %a"
                        :clock-in t :clock-resume t)
        ("j" "Journal Note"
         ;entry (file+olp+datetree (get-journal-file-today))
        ; entry (function get-journal-file-today)
        ; entry (format "%S%S\" \"~/.emacs.d/GTD/orgBoss/Journal/\"" (format-time-string "%Y%m%d"))
         ;entry (file (concat "~/.emacs.d/GTD/orgBoss/Journal/" "journal.org"))
        ; entry (file "~/.emacs.d/GTD/orgBoss/Journal/20171007")
        ; entry (file+headline current-time-file "Write it!Pls") ;; it works
         entry (file current-time-file )
         "* Event: %?\n\n  %i\n\n  From: %a"
         :empty-lines 1 )
        ("t" "Todo" entry  (file+headline "~/.emacs.d/GTD/orgBoss/newgtd.org" "Tasks")
                    "* TODO [#B] %^{Task} %T %^g
                    :PROPERTIES:
                    :Effort: %^{effort|1:00|0:30|2:00|4:00|6:00|8:00|10:00|12:00|14:00|16:00}
                    :END:
                    
                    %?

                    %i
                    "  :clock-in t :clock-resume t )
        ("T" "QuickTask" entry  (file+headline "~/.emacs.d/GTD/orgBoss/newgtd.org" "Tasks")  
                        "* TODO [#C] %^{Task} %T\nSCHEDULED:%t\n"
                        :clock-in t :clock-resume t )
        ("r" "Interrupted Task" entry  (file+headline "~/.emacs.d/GTD/orgBoss/newgtd.org" "Tasks")  
                        "* STARTED %^{Task} %T"
                        :clock-in :clock-resume)
        ("i" "IDEA" entry  (file+headline "~/.emacs.d/GTD/orgBoss/IDEA/idea.org" "IDEA")  
                        "* TODO [#A] %^{What's your IDEA (Briefly)} %T \n %?" 
                        :clock-in t :clock-resume t )
          ("C" "ClojureLearning" entry (file+olp+datetree  "~/.emacs.d/GTD/orgBoss/Clipboard/clojureLearn.org")  
                      ;  "** %^{Head Line} %U %^g\n%c\n%?"  
                         "** %^{Tip} %U \n \n %?"
                        ;:immediate-finish t
                        )
           ;; ("R" "Finance" entry  (file+olp+datetree  "~/.emacs.d/GTD/orgBoss/Financial/finances.org" )     
           ;;               "** %^{BriefDesc} %T %^g\n%?"   :clock-in t :clock-resume t :immediate-finish t ) 
          ("b" "Book" entry  (file+olp+datetree "~/.emacs.d/GTD/orgBoss/Book/book.org")   
                        "** %^{Enter the Book Name} %t :BOOK: \n%[~/.emacs.d/GTD/orgTemplate/.book_template.txt]\n")
          ("f" "Film" entry (  file+olp+datetree "~/.emacs.d/GTD/orgBoss/Film/film.org")  
                        "** %^{Enter the Film Name} %t :FILM: \n%[~/.emacs.d/GTD/orgTemplate/.film_template.txt]\n")
          ("d" "Daily Review" entry   (file+olp+datetree "~/.emacs.d/GTD/orgBoss/DailyReview/daily.org")  
                        "** %t :COACH: \n%[~/.emacs.d/GTD/orgTemplate/.daily_review.txt]\n"  :clock-in t :clock-resume t)
          ("a" "Appointment Or Meeting" entry (file+headline "~/.emacs.d/CalendarDairy/diary.org")
                        "** APP [#B] %^{Description} %^g
                        
                        %?
                        Added: %U" 
                        :clock-in :clock-resume)
        ("w" "SITES" entry  (file+headline "~/.emacs.d/GTD/orgBoss/Site/www.site.org" "SITES")  
                        "* %^{Enter the Name of the Site}\n %?" )
          ("s" "Someday"  entry   (file+olp+datetree "~/.emacs.d/GTD/orgBoss/Someday/someday.org") 
                        "** %^{Someday Heading} [#B] %U\n%?\n"  )
          ;; ("v" "Vocab"  entry (file+olp+datetree  "~/.emacs.d/GTD/orgBoss/Vocab/vocab.org" )  
          ;;                "** %^{Word?}\n%?\n"  )                                               
          ( "r" "Private" entry (file+olp+datetree "~/.emacs.d/GTD/orgBoss/Private/privnotes.org")  
                         "\n* %^{topic} [#A] %T \n%i%?\n")
          ;; ("o" "contact"  entry  (file+olp+datetree "~/.emacs.d/gtd/phone.org" )  
          ;;                "\n* %^{name} :contact:\n\n")                            
         ("q" "Quick note" entry
          (file+headline "~/.emacs.d/GTD/orgBoss/Note/notes.org" "Quick notes")
                        "* %^{Keyword?} [#B]  %^g
                         Added: %U
                         %?"
                        :clock-in t :clock-resume t                    
          )
         ("h" "Habit" entry (file "~/.emacs.d/GTD/orgBoss/Habit/habits.org")
          "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"  :clock-in t :clock-resume t )
        ("k" "work" entry (file+headline org-default-notes-file "Cocos2D-X") 
           "* Cos [#A] %?\n  %i\n %U"                                          
           :empty-lines 1)                                                     
        ("c" "code snippet" entry (file "~/.emacs.d/GTD/orgBoss/code-snippets.org")
            "* %?\n%(my/org-capture-code-snippet \"%F\")")        
))

;;; http://www.howardism.org/Technical/Emacs/capturing-content.html
;;; copy item to the clock capture item
;;; 这种方式会弹出一个buffer框，等待你`C-c C-c` 才会输入到destination clock file
;;; 这种方式可以在你需要修改的前提下
(add-to-list 'org-capture-templates
             `("B" "Item to Current Clocked Task" item
               (clock)
               "%i%?" :empty-lines 1))
;; 立即输入到对应的destination clock file head  :immediate-finish t的作用
(add-to-list 'org-capture-templates
             `("E" "Contents to Current Clocked Task" plain
               (clock)
               "%i" :immediate-finish t :empty-lines 1))

;;; 有时候甚至你还需要偷懒 ，不想敲入`C-c c B or E` 于是你使用
(defun region-to-clocked-task (start end)
  "Copies the selected text to the currently clocked in org-mode task."
  (interactive "r")
  (org-capture-string (buffer-substring-no-properties start end) "E"))  ;;; take care it will call the org-capture-template E

(global-set-key (kbd "<f9>") 'region-to-clocked-task)

;; http://ul.io/nb/2018/04/30/better-code-snippets-with-org-capture/ 
(defun my/org-capture-get-src-block-string (major-mode)
  "Given a major mode symbol, return the associated org-src block
string that will enable syntax highlighting for that language
E.g. tuareg-mode will return 'ocaml', python-mode 'python', etc..."
  (let ((mm (intern (replace-regexp-in-string "-mode" "" (format "%s" major-mode)))))
    (or (car (rassoc mm org-src-lang-modes)) (format "%s" mm))))
(defun my/org-capture-code-snippet (f)
  (with-current-buffer (find-buffer-visiting f)
    (let ((code-snippet (buffer-substring-no-properties (mark) (- (point) 1)))
          (func-name (which-function))
          (file-name (buffer-file-name))
          (line-number (line-number-at-pos (region-beginning)))
          (org-src-mode (my/org-capture-get-src-block-string major-mode)))
      (format
       "file:%s::%s
In ~%s~:
#+BEGIN_SRC %s
%s
#+END_SRC"
       file-name
       line-number
       func-name
       org-src-mode
    code-snippet))))

(defun my/org-dir-file (name)
    "Prepend name with path to the org-directory root"
    (concat org-directory name))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom agenda command definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq org-agenda-custom-commands                               ;;
;;       (quote (("N" "Notes" tags "NOTE"                         ;;
;;                ((org-agenda-overriding-header "Notes")         ;;
;;                 (org-tags-match-list-sublevels t)))            ;;
;;               ("h" "Habits" tags-todo "STYLE=\"habit\""        ;;
;;                ((org-agenda-overriding-header "Habits")        ;;
;;                 (org-agenda-sorting-strategy                   ;;
;;                  '(todo-state-down effort-up category-keep)))) ;;
;; )))                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-agenda-custom-commands
      '(("O" "Office block agenda"
         ((agenda "" ((org-agenda-ndays 1))) 
                      ;; limits the agenda display to a single day
          (tags-todo "+PRIORITY=\"A\"")
          (tags-todo "computer|office|phone")
          (tags "project+CATEGORY=\"elephants\"")
          ;(tags "review" ((org-agenda-files '("~/org/circuspeanuts.org"))))
                          ;; limits the tag search to the file circuspeanuts.org
          (todo "WAITING"))
         ((org-agenda-compact-blocks t))) ;; options set here apply to the entire block
        ;; ...other commands here
        ("g" . "Go to somewhere tags search")
        ("go" "Office" 
         (tags "@Company")
         (tags "@NCEPU"))
        ("gh" "Home" tags "@Home")
        ("gm" "School" tags "@NCEPU")

        ("p" . "Priorities")
        ("pa" "A items" tags-todo "+PRIORITY=\"A\"")
        ("pb" "B items" tags-todo "+PRIORITY=\"B\"")
        ("pc" "C items" tags-todo "+PRIORITY=\"C\"")

        ("z" . "概念宽度")
        ("zz"  "芝麻" tags "+芝麻")
        ("zj"  "橘子" tags "+橘子")
        ("zg"  "西瓜" tags "+西瓜")
        ("zd"  "大象" tags "+大象")
        ("zq"  "地球" tags "+地球")
        ("zt"  "太阳" tags "+太阳")
        ("zh"  "银河系" tags "+银河系")
        ("zy"  "宇宙" tags "+宇宙")

        ("j" "加密" tags "+crypt")
        ("s" . "重要程度" )
        ("sa"  "紧急重要" tags "+紧急重要")
        ("sb" "紧急不重要" tags "+紧急不重要")
        ("sc" "不紧急重要" tags "+不紧急重要")
        ("sd" "不紧急不重要" tags "+不紧急不重要") 

        ("d" . "数据库")
        ("do" "Oracle" tags "+Oracle")
        ("ds" "sqlite" tags "+sqlite")
        ("dm" "Mysql" tags "+Mysql")
        
        ("l" . "语言")
        ("ll" "EnglishPaper" tags "+EnglishPaper" ) 
        ("lj" "java" tags "+java")
        ("lp" "perl" tags "+perl")
        ("ln" "Linux" tags "+Linux")
        ("lm" "matlab" tags "+matlab")
        ("lf" "Fortran" tags "+Fortran")
        ("lv" "Vim" tags "+Vim" )
        ("lo" "clojure" tags "+clojure")
        ("ls" "scheme" tags "+scheme")
        ("lp" "python" tags "+python")
        ("lr" "ruby" tags "+ruby")
        ("le" "emacslisp" tags "+emacslisp")
        ("lg" "git" tags "+git")
        ("ld" "Docker" tags "+Docker")
        ("lc" "CFD" tags "+CFD")
        ("R" "Recent activity"
                ((tags "*"
                        ((org-agenda-overriding-header "Recent Activity")
                        (org-agenda-skip-function '(+org/has-child-and-last-update-before 14)))))
                nil nil)
        ))
; (setq org-capture-templates
;     '(("Todo" ?t "* TODOS %^{To Do What?(Brief Description)} %^g\n%?\nAdded: %U" "~/.emacs.d/GTD/newgtd.org" "Tasks")
;     ("IDEA" ?i "* TODO %^{What's your IDEA (Briefly)} \n %?" "~/.emacs.d/GTD/orgBoss/IDEA/idea.org" "IDEA")
;       ("Journal"   ?j "** %^{Head Line} %U %^g\n%i%?"  "~/.emacs.d/GTD/orgBoss/Journal/journal.org")
;       ("Clipboard" ?c "** %^{Head Line} %U %^g\n%c\n%?"  "~/.emacs.d/GTD/orgBoss/Clipboard/clipboard.org")
;       ("Receipt"   ?r "** %^{BriefDesc} %U %^g\n%?"   "~/.emacs.d/GTD/orgBoss/Financial/finances.org")
;       ("Book" ?b "** %^{Enter the Book Name} %t :BOOK: \n%[~/.emacs.d/GTD/orgTemplate/.book_template.txt]\n"
;          "~/.emacs.d/GTD/orgBoss/Book/book.org")
;       ("Film" ?f "** %^{Enter the Film Name} %t :FILM: \n%[~/.emacs.d/GTD/orgTemplate/.film_template.txt]\n"
;          "~/.emacs.d/GTD/orgBoss/Film/film.org")
;       ("Daily Review" ?d "** %t :COACH: \n%[~/.emacs.d/GTD/orgTemplate/.daily_review.txt]\n"
;          "~/.emacs.d/GTD/orgBoss/DailyReview/daily.org")
;     ("SITES" ?w "* %^{Enter the Name of the Site}\n %?" "~/.emacs.d/GTD/orgBoss/Site/www.site.org" "SITES")
;       ("Someday"   ?s "** %^{Someday Heading} %U\n%?\n"  "~/.emacs.d/GTD/orgBoss/Someday/someday.org")
;       ("Vocab"   ?v "** %^{Word?}\n%?\n"  "~/.emacs.d/GTD/orgBoss/Vocab/vocab.org")
;      ("Private" ?p "\n* %^{topic} %T \n%i%?\n" "~/.emacs.d/GTD/orgBoss/Private/privnotes.org")
;      ("Contact" ?p "\n* %^{Name} :CONTACT:\n%[l:/contemp.txt]\n"
;                "F:/gtd/privnotes.org")
;      )
;    )
;
;
; (setq org-remember-templates
;       '(("l" "灵感" entry (file+headline "~/.emacs.d/GTD/writing.org" "创意")
;                         "* %?\n %i\n %a")
;         ("j" "Journal" entry (file+datetree "~/.emacs.d/GTD/orgBoss/Journal/journal.org" )
;                         "* %?\n输入于： %U\n %i\n %a")
;         ("t" "Todo" entry  (file+headline "~/.emacs.d/GTD/newgtd.org" "Tasks")
;                         "* TODOS %^{To Do What?(Brief Description)} %^g\n%?\nAdded: %U" )
;         ("i" "IDEA" entry  (file+headline "~/.emacs.d/GTD/orgBoss/IDEA/idea.org" "IDEA")
;                         "* TODO %^{What's your IDEA (Briefly)} \n %?" )
;           ("c" "Clipboard" entry (file+datetree  "~/.emacs.d/GTD/orgBoss/Clipboard/clipboard.org")
;                         "** %^{Head Line} %U %^g\n%c\n%?"  )
;           ("r" "Receipt" entry  (file+datetree  "~/.emacs.d/GTD/orgBoss/Financial/finances.org" )
;                         "** %^{BriefDesc} %U %^g\n%?"   )
;           ("b" "Book" entry  (file+datetree "~/.emacs.d/GTD/orgBoss/Book/book.org")
;                         "** %^{Enter the Book Name} %t :BOOK: \n%[~/.emacs.d/GTD/orgTemplate/.book_template.txt]\n")
;           ("f" "Film" entry (  file+datetree "~/.emacs.d/GTD/orgBoss/Film/film.org")
;                         "** %^{Enter the Film Name} %t :FILM: \n%[~/.emacs.d/GTD/orgTemplate/.film_template.txt]\n")
;           ("d" "Daily Review" entry   (file+datetree "~/.emacs.d/GTD/orgBoss/DailyReview/daily.org")
;                         "** %t :COACH: \n%[~/.emacs.d/GTD/orgTemplate/.daily_review.txt]\n")
;         ("w" "SITES" entry  (file+headline "~/.emacs.d/GTD/orgBoss/Site/www.site.org" "SITES")
;                         "* %^{Enter the Name of the Site}\n %?" )
;           ("s" "Someday"  entry   (file+datetree "~/.emacs.d/GTD/orgBoss/Someday/someday.org")
;                         "** %^{Someday Heading} %U\n%?\n"  )
;           ("v" "Vocab"  entry (file+datetree  "~/.emacs.d/GTD/orgBoss/Vocab/vocab.org" )
;                         "** %^{Word?}\n%?\n"  )
;           ( "p" "Private" entry (file+datetree "~/.emacs.d/GTD/orgBoss/Private/privnotes.org")
;                          "\n* %^{topic} %T \n%i%?\n")
;          ("a" "contact"  entry  (file+datetree "~/.emacs.d/gtd/phone.org" )
;                         "\n* %^{name} :contact:\n\n")
;     ))
;
; (setq org-remember-templates
;     '(("Todo" ?t "* TODOS %^{To Do What?(Brief Description)} %^g\n%?\nAdded: %U" "~/.emacs.d/GTD/newgtd.org" "Tasks")
;     ("IDEA" ?i "* TODO %^{What's your IDEA (Briefly)} \n %?" "~/.emacs.d/GTD/orgBoss/IDEA/idea.org" "IDEA")
;       ("Journal"   ?j "** %^{Head Line} %U %^g\n%i%?"  "~/.emacs.d/GTD/orgBoss/Journal/journal.org")
;       ("Clipboard" ?c "** %^{Head Line} %U %^g\n%c\n%?"  "~/.emacs.d/GTD/orgBoss/Clipboard/clipboard.org")
;       ("Receipt"   ?r "** %^{BriefDesc} %U %^g\n%?"   "~/.emacs.d/GTD/orgBoss/Financial/finances.org")
;       ("Book" ?b "** %^{Enter the Book Name} %t :BOOK: \n%[~/.emacs.d/GTD/orgTemplate/.book_template.txt]\n"
;          "~/.emacs.d/GTD/orgBoss/Book/book.org")
;       ("Film" ?f "** %^{Enter the Film Name} %t :FILM: \n%[~/.emacs.d/GTD/orgTemplate/.film_template.txt]\n"
;          "~/.emacs.d/GTD/orgBoss/Film/film.org")
;       ("Daily Review" ?d "** %t :COACH: \n%[~/.emacs.d/GTD/orgTemplate/.daily_review.txt]\n"
;          "~/.emacs.d/GTD/orgBoss/DailyReview/daily.org")
;     ("SITES" ?w "* %^{Enter the Name of the Site}\n %?" "~/.emacs.d/GTD/orgBoss/Site/www.site.org" "SITES")
;       ("Someday"   ?s "** %^{Someday Heading} %U\n%?\n"  "~/.emacs.d/GTD/orgBoss/Someday/someday.org")
;       ("Vocab"   ?v "** %^{Word?}\n%?\n"  "~/.emacs.d/GTD/orgBoss/Vocab/vocab.org")
;      ("Private" ?p "\n* %^{topic} %T \n%i%?\n" "~/.emacs.d/GTD/orgBoss/Private/privnotes.org")
;      ("Contact" ?p "\n* %^{Name} :CONTACT:\n%[l:/contemp.txt]\n"
;                "F:/gtd/privnotes.org")
;      )
;    )
;
;
; “|”用来分隔“未完成”和“完成”两种状态的关键词，前面为未完成项，后面为完成项。如果没有“|”符号，最后一个关键词将被设为完成项，其余为未完成项。
; ! 表示时间
; 所有的TODO都只有 两种类  Undo and  done 用 |分隔
; type 相当于 #+TYP_TODO  也有两种类型
; sequence 相当于 #+SEQ_TODO   也有两种类型
; 可以写出多个sequence 等你工作 学习 继续进行修改 但是注意无论是type还是sequence都得有|
; TODO 要做 DOING正咋做 PENDING做完了再做  WAITING做了一半得等其他人完成
(setq org-todo-keywords
  '((type "工作(w!)" "学习(s!)" "休闲(l!)" "|")
    (type "REPORT(r!)" "BUG(b!)" "KNOWNCAUSE(k!)" "|" "FIXED(f!)")
    (sequence "PENDING(p!)" "TODO(t!)" "DOING(i!)" "WAITING(e!)" "|" "DONE(d!)" "CANCELED(c!)" "ABORT(a@/!)")
))
(setq org-todo-keyword-faces
  '(("工作" .      (:background "red" :foreground "white" :weight bold))
    ("学习" .      (:background "white" :foreground "red" :weight bold))
    ("休闲" .      (:foreground "MediumBlue" :weight bold)) 
    ("REPORT" .      (:background "red" :foreground "white" :weight bold))
    ("BUG" .      (:background "white" :foreground "red" :weight bold))
    ("KNOWNCAUSE" .      (:foreground "MediumBlue" :weight bold)) 
    ("FIXED" .      (:foreground "yellow" :weight bold)) 
    ("PENDING" .   (:background "Purple" :foreground "gray" :weight bold))
    ("TODO" .      (:background "DarkOrange" :foreground "black" :weight bold))
    ("DOING" .     (:background "yellow" :foreground "purple" :weight bold ))
    ("DONE" .      (:background "azure" :foreground "Darkgreen" :weight bold)) 
    ("CANCELED" . (:background "LightGray" :foreground "black"))
    ("ABORT" .     (:background "gray" :foreground "black"))
))

;;相当于设置  #+tags:  在每一个org文件中
(setq org-tag-alist '((:startgroup . nil)
                      ("@Company" . ?o)
                      ("@Home" . ?H)
                      ("@NCEPU" . ?n)
                      (:endgroup . nil)
                      (:newline)
                      (:startgroup . nil)
                      ("Oracle" . ?O)
                      ("sqlite" . ?S)
                      ("Mysql" . ?Q)
                      (:endgroup . nil)
                      (:newline)
                      (:startgroup . nil)
                      ("EnglishPaper" . ?l) 
                      ("java" . ?j)
                      ("perl" . ?p)
                      ("Linux" . ?L)
                      ("matlab" . ?m)
                      ("Fortran" . ?f)
                      ("Vim" . ?v)
                      ("clojure" . ?J)
                      ("scheme" . ?s)
                      ("python" . ?y)
                      ("ruby" . ?r)
                      ("emacslisp" . ?e)
                      ("git" . ?G)
                      ("Docker" . ?D)
                      ("CFD" . ?F)
                      (:endgroup . nil)
                      (:newline)
                      (:startgroup . nil)

                      ("crypt" . ?C)
                      (:endgroup . nil)
                      (:newline)
                      (:startgroup . nil)


                      ("芝麻" . ?z)
                      ("橘子" . ?J)
                      ("西瓜" . ?x)
                      ("大象" . ?X)
                      ("大山" . ?M)
                      ("地球" . ?E)
                      ("太阳" . ?T)
                      ("银河系" . ?Y)
                      ("宇宙" . ?Z) 
                      (:endgroup . nil)

                      (:newline)
                      (:startgroup . nil)
                      ("blockchain" . ?b)
                      ("学术" . ?u)
                      (:endgroup . nil)

                      (:newline)
                      (:startgroup . nil)
                      ("紧急重要" . ?a)
                      ("紧急不重要" . ?b)
                      ("不紧急重要" . ?c)
                      ("不紧急不重要" . ?d)
                      (:endgroup . nil)
                      ))


;;; privilege
;; 优先级范围和默认任务的优先级
(setq org-highest-priority ?A)
(setq org-lowest-priority  ?E)
(setq org-default-priority ?E) 
;; 优先级醒目外观
(setq org-priority-faces
  '((?A . (:background "red" :foreground "white" :weight bold))
    (?B . (:background "DarkOrange" :foreground "white" :weight bold))
    (?C . (:background "yellow" :foreground "DarkGreen" :weight bold))
    (?D . (:background "DodgerBlue" :foreground "black" :weight bold))
    (?E . (:background "SkyBlue" :foreground "black" :weight bold))
))



;; for idle time
(defun jump-to-org-agenda ()
  (interactive)
  (let ((buf (get-buffer "*Org Agenda*"))
        wind)
    (if buf
        (if (setq wind (get-buffer-window buf))
            (select-window wind)
          (if (called-interactively-p)
              (progn
                (select-window (display-buffer buf t t))
                (org-fit-window-to-buffer)
                ;; (org-agenda-redo)
                )
            (with-selected-window (display-buffer buf)
              (org-fit-window-to-buffer)
              ;; (org-agenda-redo)
              )))
      (call-interactively 'org-agenda-list)))
  ;;(let ((buf (get-buffer "*Calendar*")))
  ;;  (unless (get-buffer-window buf)
  ;;    (org-agenda-goto-calendar)))
  )

;; 300s =5min
(run-with-idle-timer 300 t 'jump-to-org-agenda)



;https://github.com/sachac/.emacs.d/blob/gh-pages/Sacha.org#strike-through-done-headlines
;; change "DONE" keyword style
(setq org-fontify-done-headline t)
(custom-set-faces
 '(org-done ((t (:foreground "PaleGreen"   
                 :weight normal
                 :strike-through t))))
 '(org-headline-done 
            ((((class color) (min-colors 16) (background dark)) 
               (:foreground "LightSalmon" :strike-through t)))))

(defun my/org-review-month (start-date)
  "Review the month's clocked tasks and time."
  (interactive (list (org-read-date)))
  ;; Set to the beginning of the month
  (setq start-date (concat (substring start-date 0 8) "01"))
  (let ((org-agenda-show-log t)
        (org-agenda-start-with-log-mode t)
        (org-agenda-start-with-clockreport-mode t)
        (org-agenda-clockreport-parameter-plist '(:link t :maxlevel 3)))
    (org-agenda-list nil start-date 'month)))

;; http://pages.sachachua.com/.emacs.d/Sacha.html
;; Registers allow you to jump to a file or other location quickly. To jump to a register, use C-x r j followed by the letter of the register. Using registers for all these file shortcuts is probably a bit of a waste since I can easily define my own keymap, but since I rarely go beyond register A anyway. Also, I might as well add shortcuts for refiling.
(defvar my/refile-map (make-sparse-keymap))

(defmacro my/defshortcut (key file)  
  `(progn
     (set-register ,key (cons 'file ,file))
     (define-key my/refile-map
       (char-to-string ,key)
       (lambda (prefix)
         (interactive "p")
         (let ((org-refile-targets '(((,file) :maxlevel . 6)))
               (current-prefix-arg (or current-prefix-arg '(4))))
           (call-interactively 'org-refile))))))


  (define-key my/refile-map "," 'my/org-refile-to-previous-in-file)

(my/defshortcut ?i "~/.emacs.d/GTD/newgtd.org")
(my/defshortcut ?f "~/.emacs.d/GTD/orgBoss/Film/film.org")
(my/defshortcut ?v "~/.emacs.d/GTD/orgBoss/Vocab/vocab.org")
(my/defshortcut ?s "~/.emacs.d/GTD/orgBoss/Someday/someday.org")
(my/defshortcut ?S "~/.emacs.d/GTD/orgBoss/Site/www.site.org")
(my/defshortcut ?B "~/.emacs.d/GTD/orgBoss/Book/book.org")
(my/defshortcut ?c "~/.emacs.d/GTD/orgBoss/Clipboard/clojureLearn.org")
(my/defshortcut ?b "~/.emacs.d/GTD/orgBoss/business/business.org")
(my/defshortcut ?e "~/.emacs.d/GTD/orgBoss/code/codes.org")
(my/defshortcut ?W "~/.emacs.d/GTD/orgBoss/Site/blog.org")
(my/defshortcut ?j "~/.emacs.d/GTD/orgBoss/Journal/journal.org")
(my/defshortcut ?I "~/.emacs.d/GTD/orgBoss/IDEA/idea.org")
(my/defshortcut ?d "~/.emacs.d/GTD/orgBoss/DailyReview/daily.org")
(my/defshortcut ?l "~/.emacs.d/GTD/orgBoss/learning.org")
(my/defshortcut ?q "~/.emacs.d/GTD/orgBoss/questions.org")
(my/defshortcut ?w "~/.emacs.d/GTD/writing.org")
(my/defshortcut ?p "~/.emacs.d/GTD/phd1.org")
(my/defshortcut ?D "~/.emacs.d/GTD/Dissertation.org")
(my/defshortcut ?n "~/.emacs.d/GTD/orgBoss/Note/notes.org")
(my/defshortcut ?o "~/.emacs.d/.orgConf.el")





;;; the minimum time is one tomato time:  0:30
(add-to-list 'org-global-properties
      '("Effort_ALL". " 0:30 1:00 2:00 3:00 4:00 6:00 8:00 12:00 15:00 20:00"))



(defvar my/weekly-review-line-regexp
  "^  \\([^:]+\\): +\\(Sched[^:]+: +\\)?TODO \\(.*?\\)\\(?:[      ]+\\(:[[:alnum:]_@#%:]+:\\)\\)?[        ]*$"
  "Regular expression matching lines to include.")
(defvar my/weekly-done-line-regexp
  "^  \\([^:]+\\): +.*?\\(?:Clocked\\|Closed\\):.*?\\(TODO\\|DONE\\) \\(.*?\\)\\(?:[       ]+\\(:[[:alnum:]_@#%:]+:\\)\\)?[        ]*$"
  "Regular expression matching lines to include as completed tasks.")

(defun my/quantified-get-hours (category time-summary)
  "Return the number of hours based on the time summary."
  (if (stringp category)
      (if (assoc category time-summary) (/ (cdr (assoc category time-summary)) 3600.0) 0)
    (apply '+ (mapcar (lambda (x) (my/quantified-get-hours x time-summary)) category))))

(defun _my/extract-tasks-from-agenda (string matchers prefix line-re)
  (with-temp-buffer
    (insert string)
    (goto-char (point-min))
    (while (re-search-forward line-re nil t)
      (let ((temp-list matchers))
        (while temp-list
          (if (save-match-data
                (string-match (car (car temp-list)) (match-string 1)))
              (progn
                (add-to-list (cdr (car temp-list)) (concat prefix (match-string 3)) t)
                (setq temp-list nil)))
          (setq temp-list (cdr temp-list)))))))

(ert-deftest _my/extract-tasks-from-agenda ()
  (let (list-a list-b (line-re "\\([^:]+\\):\\( \\)\\(.*\\)"))
    (_my/extract-tasks-from-agenda
     "listA: Task 1\nother: Task 2\nlistA: Task 3"
     '(("listA" . list-a)
       ("." . list-b))
     "- [ ] "
     line-re)
    (should (equal list-a '("- [ ] Task 1" "- [ ] Task 3")))
    (should (equal list-b '("- [ ] Task 2")))))

(defun _my/get-upcoming-tasks ()
  (save-window-excursion
      (org-agenda nil "W")
      (_my/extract-tasks-from-agenda (buffer-string)
                                        '(("routines" . ignore)
                                          ("business" . business-next)
                                          ("people" . relationships-next)
                                          ("tasks" . emacs-next)
                                          ("." . life-next))
                                        "  - [ ] "
                                        my/weekly-review-line-regexp)))
(defun _my/get-previous-tasks ()
  (let (string)
    (save-window-excursion
      (org-agenda nil "W")
      (org-agenda-later -1)
      (org-agenda-log-mode 16)
      (setq string (buffer-string))
      ;; Get any completed tasks from the current week as well
      (org-agenda-later 1)
      (org-agenda-log-mode 16)
      (setq string (concat string "\n" (buffer-string)))
      (_my/extract-tasks-from-agenda string
                                        '(("routines" . ignore)
                                          ("business" . business)
                                          ("people" . relationships)
                                          ("tasks" . emacs)
                                          ("." . life))
                                        "  - [X] "
                                        my/weekly-done-line-regexp))))

(defun my/org-summarize-focus-areas (date)
  "Summarize previous and upcoming tasks as a list."
  (interactive (list (org-read-date-analyze (if current-prefix-arg (org-read-date) "-fri") nil '(0 0 0))))
  (let (business relationships life business-next relationships-next life-next string emacs emacs-next
                 start end time-summary biz-time ignore base-date)
    (setq base-date (apply 'encode-time date))
    (setq start (format-time-string "%Y-%m-%d" (days-to-time (- (time-to-number-of-days base-date) 6))))
    (setq end (format-time-string "%Y-%m-%d" (days-to-time (1+ (time-to-number-of-days base-date)))))
    (setq time-summary (quantified-summarize-time start end))
    (setq biz-time (my/quantified-get-hours "Business" time-summary))
    (_my/get-upcoming-tasks)
    (_my/get-previous-tasks)
    (setq string
          (concat
           (format "- *Business* (%.1fh - %d%%)\n" biz-time (/ biz-time 1.68))
           (mapconcat 'identity business "\n") "\n"
           (mapconcat 'identity business-next "\n")
           "\n"
           (format "  - *Earn* (%.1fh - %d%% of Business)\n"
                   (my/quantified-get-hours "Business - Earn" time-summary)
                   (/ (my/quantified-get-hours "Business - Earn" time-summary) (* 0.01 biz-time)))
           (format "  - *Build* (%.1fh - %d%% of Business)\n"
                   (my/quantified-get-hours "Business - Build" time-summary)
                   (/ (my/quantified-get-hours "Business - Build" time-summary) (* 0.01 biz-time)))
           (format "  - *Connect* (%.1fh - %d%% of Business)\n"
                   (my/quantified-get-hours "Business - Connect" time-summary)
                   (/ (my/quantified-get-hours "Business - Connect" time-summary) (* 0.01 biz-time)))
           (format "- *Relationships* (%.1fh - %d%%)\n"
                   (my/quantified-get-hours '("Discretionary - Social"
                                                 "Discretionary - Family") time-summary)
                   (/ (my/quantified-get-hours '("Discretionary - Social"
                                                    "Discretionary - Family") time-summary) 1.68))
           (mapconcat 'identity relationships "\n") "\n"
           (mapconcat 'identity relationships-next "\n") "\n"
           "\n"
           (format "- *Discretionary - Productive* (%.1fh - %d%%)\n"
                   (my/quantified-get-hours "Discretionary - Productive" time-summary)
                   (/ (my/quantified-get-hours "Discretionary - Productive" time-summary) 1.68))
           (format "  - *Drawing* (%.1fh)\n"
                   (my/quantified-get-hours '("Discretionary - Productive - Drawing")  time-summary))
           (format "  - *Emacs* (%.1fh)\n"
                   (my/quantified-get-hours "Discretionary - Productive - Emacs" time-summary))
           (mapconcat 'identity emacs "\n") "\n"
           (mapconcat 'identity emacs-next "\n") "\n"
           (format "  - *Coding* (%.1fh)\n"
                   (my/quantified-get-hours "Discretionary - Productive - Coding" time-summary))
           (mapconcat 'identity life "\n") "\n"
           (mapconcat 'identity life-next "\n") "\n"
           (format "  - *Sewing* (%.1fh)\n"
                   (my/quantified-get-hours "Discretionary - Productive - Sewing" time-summary))
           (format "  - *Writing* (%.1fh)\n"
                   (my/quantified-get-hours "Discretionary - Productive - Writing" time-summary))
           (format "- *Discretionary - Play* (%.1fh - %d%%)\n"
                   (my/quantified-get-hours "Discretionary - Play" time-summary)
                   (/ (my/quantified-get-hours "Discretionary - Play" time-summary) 1.68))
           (format "- *Personal routines* (%.1fh - %d%%)\n"
                   (my/quantified-get-hours "Personal" time-summary)
                   (/ (my/quantified-get-hours "Personal" time-summary) 1.68))
           (format "- *Unpaid work* (%.1fh - %d%%)\n"
                   (my/quantified-get-hours "Unpaid work" time-summary)
                   (/ (my/quantified-get-hours "Unpaid work" time-summary) 1.68))
           (format "- *A- (Childcare)* (%.1fh - %d%% of total)\n"
                   (my/quantified-get-hours '("A-") time-summary)
                   (/ (my/quantified-get-hours '("A-") time-summary) 1.68))
           (format "- *Sleep* (%.1fh - %d%% - average of %.1f per day)\n"
                   (my/quantified-get-hours "Sleep" time-summary)
                   (/ (my/quantified-get-hours "Sleep" time-summary) 1.68)
                   (/ (my/quantified-get-hours "Sleep" time-summary) 7)
                   )))
    (if (called-interactively-p 'any)
        (insert string)
      string)))




;;; agenda view setting
;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command definitions
(setq org-agenda-show-future-repeats nil)



;;;better headder  bullet
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


;; better bullets                                                                                                ;;

(font-lock-add-keywords 'org-mode                                                                                ;; ;;
                        '(("^ +\\([-*]\\) "                                                                      ;; ;;
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "✺"))))))              ;; ;;


;(defface hi-red-b '((t (:foreground "#e50062"))) t)
;(defface hi-purple-b '((t (:foreground "#871F78"))) t)
(defface hi-purple-b '((t (:foreground "#9F5F9F"))) t)
;(defface hi-purple-b '((t (:foreground "#CC3299"))) t)
;(defface hi-purple-b '((t (:foreground "#800080"))) t)
;;; let header become better                                                                                     ;; ;;

(let* ((variable-tuple (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))                       ;; ;; ;;
                             ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))                         ;; ;; ;;
                             ((x-list-fonts "Verdana")         '(:font "Verdana"))                               ;; ;; ;;
                             ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))                          ;; ;; ;;
                             (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))           ;; ;; ;;
      ; (base-font-color     (face-foreground 'default nil 'default))                                                  ;;
       (base-font-color2    (face-foreground 'hi-purple-b nil 'default))                                               ;;
       (base-font-color     (face-foreground 'default nil 'default))                                             ;; ;; ;;
       (headline           `(:inherit default :weight bold :foreground ,base-font-color))                              ;;
       (headline2           `(:inherit default :weight bold :foreground ,base-font-color2))                             ;;
)                       ;; ;;                                                                                          ;;
                                                                                                                       ;;
                                                                                                                 ;; ;; ;;
  (custom-theme-set-faces 'user                                                                                  ;; ;; ;;
                          `(org-level-8 ((t (,@headline ,@variable-tuple))))                                     ;; ;; ;;
                          `(org-level-7 ((t (,@headline ,@variable-tuple))))                                     ;; ;; ;;
                          `(org-level-6 ((t (,@headline ,@variable-tuple))))                                     ;; ;; ;;
                          `(org-level-5 ((t (,@headline ,@variable-tuple))))                                     ;; ;; ;;
                          `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))                         ;; ;; ;;
                          `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))                        ;; ;; ;;
                          `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))                         ;; ;; ;;
                          `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))                        ;; ;; ;;
                          `(org-document-title ((t (,@headline2 ,@variable-tuple :height 1.5 :underline nil)))))) ;; ;; ;;




;;http://wenshanren.org/?p=327
;;; custom source block
(defun org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)))


;;bind key `C-c s i’ to the function org-inser-src-block
(add-hook 'org-mode-hook '(lambda ()
                            ;; turn on flyspell-mode by default
                            (flyspell-mode 0)
                            ;;(flyspell-mode 1)
                            ;; C-TAB for expanding
                            (local-set-key (kbd "C-<tab>")
                                           'yas/expand-from-trigger-key)
                            ;; keybinding for editing source code blocks
                            (local-set-key (kbd "C-c s e")
                                           'org-edit-src-code)
                            ;; keybinding for inserting code blocks
                            (local-set-key (kbd "C-c s i")
                                           'org-insert-src-block)
                            ))

;;source code syntax highlight

(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)


;;you need to set the language for running the souce code block

;;(sh . t)  new 26.1 change sh to shell
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (shell . t)
   (python . t)
   (R . t)
   (calc . t)
   (ruby . t)
   (ditaa . t)
   (dot . t)
   (octave . t)
   (sqlite . t)
   (perl . t)
   (C . t)
   (scheme . t)
   (plantuml . t)
   ))

(setq org-plantuml-jar-path (expand-file-name "~/.emacs.d/customizations/plantuml.jar"))
(setq geiser-active-implementations '(racket))
;(setq geiser-active-implementations '(chez))

(setq geiser-chez-binary "K:\\DanFriedMan\\ChezScheme\\a6nt\\bin\\a6nt\\scheme.exe")
;(setq geiser-chez-binary "K:\\DanFriedMan\\ChezScheme\\a6nt\\bin\\scheme")
(setq geiser-racket-binary "c:\\Program Files\\Racket\\Racket.exe")

(setq geiser-racket-init-file "~/.emacs.d/GTD/scheme/sicp-init.rkt")  
;(setq geiser-chez-init-file "~/.emacs.d/GTD/scheme/sicp-init.rkt")  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1. geiser-guile-binary   ;;
;; 2. geiser-racket-binary  ;;
;; 3. geiser-chicken-binary ;;
;; 4. geiser-mit-binary     ;;
;; 5. geiser-chibi-binary   ;;
;; 6. geiser-chez-binary    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ac-geiser
(require 'ac-geiser)
(add-hook 'geiser-mode-hook 'ac-geiser-setup)
(add-hook 'geiser-repl-mode-hook 'ac-geiser-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'geiser-repl-mode))

(setq geiser-repl-history-filename "~/.emacs.d/geiser-history")

;;;https://github.com/howardabrams/dot-files/blob/master/emacs-org.org           ;;
(font-lock-add-keywords            ; A bit silly but my headers are now          ;;
   'org-mode `(("^\\*+ \\(TODO\\) "  ; shorter, and that is nice canceled        ;;
                (1 (progn (compose-region (match-beginning 1) (match-end 1) "○") ;;
                          nil)))                                                 ;;
               ("^\\*+ \\(DOING\\) "                                             ;;
                (1 (progn (compose-region (match-beginning 1) (match-end 1) "●") ;;
                          nil)))                                                 ;;
               ("^\\*+ \\(CANCELED\\) "                                          ;;
                (1 (progn (compose-region (match-beginning 1) (match-end 1) "✘") ;;
                          nil)))                                                 ;;
               ("^\\*+ \\(DONE\\) "                                              ;;
                (1 (progn (compose-region (match-beginning 1) (match-end 1) "✔") ;;
                          nil)))))                                               ;;


(defvar org-journal-dir "~/.emacs.d/GTD/orgBoss/Journal/")

;;https://github.com/howardabrams/dot-files/blob/master/emacs-org.org#journaling
;;These files do not have a .org extension, but we’re talking about Emacs, so I use this code to have org-mode be the default mode for filenames consisting of nothing but numbers: 

(defun get-journal-file-today ()
  "Return filename for today's journal entry."
  (let (daily-name (format-time-string "%Y%m%d"))
    ;(format "\"%S\"" (expand-file-name (concat org-journal-dir daily-name)))
    (expand-file-name (concat org-journal-dir daily-name))
    
    ;(concat org-journal-dir daily-name)
    ))

(defun journal-file-today ()
  "Create and load a journal file based on today's date."
  (interactive)
  (find-file (get-journal-file-today)))


;add to orgmode
(add-to-list 'auto-mode-alist '(".*/[0-9]*$" . org-mode))
;(add-to-list 'auto-mode-alist '(".*/[0-9]*summary[0-9_]*$" . org-mode))

;; snippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun journal-file-insert ()                                              ;;
;;   "Insert's the journal heading based on the file's name."                 ;;
;;   (interactive)                                                            ;;
;;   (when (string-match "\\(20[0-9][0-9]\\)\\([0-9][0-9]\\)\\([0-9][0-9]\\)" ;;
;;                       (buffer-name))                                       ;;
;;     (let ((year  (string-to-number (match-string 1 (buffer-name))))        ;;
;;           (month (string-to-number (match-string 2 (buffer-name))))        ;;
;;           (day   (string-to-number (match-string 3 (buffer-name))))        ;;
;;           (datim nil))                                                     ;;
;;       (setq datim (encode-time 0 0 0 day month year))                      ;;
;;       (insert (format-time-string                                          ;;
;;                  "#+TITLE: Journal Entry- %Y-%b-%d (%A)\n\n" datim)))))    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun journal-file-insert ()
  "Insert's the journal heading based on the file's name."
  (interactive)
  (let* ((year  (string-to-number (substring (buffer-name) 0 4)))
         (month (string-to-number (substring (buffer-name) 4 6)))
         (day   (string-to-number (substring (buffer-name) 6 8)))
         (datim (encode-time 0 0 0 day month year)))

      (insert (format-time-string org-journal-date-format datim))
      (insert "\n\n  $0\n") ; Start with a blank separating line

      ;; Note: The `insert-file-contents' leaves the cursor at the
      ;; beginning, so the easiest approach is to insert these files
      ;; in reverse order:

      ;; If the journal entry I'm creating matches today's date:
      (when (equal (file-name-base (buffer-file-name))
                   (format-time-string "%Y%m%d"))
        (insert-file-contents "journal-dailies-end.org")

        ;; Insert dailies that only happen once a week:
        (let ((weekday-template (downcase
                                 (format-time-string "journal-%a.org"))))
          (when (file-exists-p weekday-template)
            (insert-file-contents weekday-template)))
        (insert-file-contents "journal-dailies.org")
        (insert "$0")

        (let ((contents (buffer-string)))
          (delete-region (point-min) (point-max))
          (yas-expand-snippet contents (point-min) (point-max))))))

(define-auto-insert "/[0-9]\\{8\\}$" [journal-file-insert])


(setq auto-insert t)
(setq auto-insert-query t)
(add-hook 'find-file-hook 'auto-insert)

;(add-to-list 'auto-insert-alist '(".*/[0-9]*$" . journal-file-insert))
;(define-auto-insert '(".*/[0-9]*$" . journal-file-insert))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defvar auto-insert-alist '())                   ;;
;; (setq auto-insert-alist                          ;;
;;       (append '(                                 ;;
;;             (".*/[0-9]*$" . journal-file-insert) ;;
;;                                                  ;;
;;             )                                    ;;
;;            auto-insert-alist))                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(global-set-key (kbd "C-c f j") 'journal-file-today)


(defun get-journal-file-yesterday ()
  "Return filename for yesterday's journal entry."
  (let* ((yesterday (time-subtract (current-time) (days-to-time 1)))
         (daily-name (format-time-string "%Y%m%d" yesterday)))
    (expand-file-name (concat org-journal-dir daily-name))))

(defun journal-file-yesterday ()
  "Creates and load a file based on yesterday's date."
  (interactive)
  (find-file (get-journal-file-yesterday)))

(global-set-key (kbd "C-c f y") 'journal-file-yesterday)
;;https://github.com/howardabrams/dot-files/blob/master/emacs-org.org#displaying-last-years-journal-entry

(defun journal-last-year-file ()
  "Returns the string corresponding to the journal entry that
happened 'last year' at this same time (meaning on the same day
of the week)."
(let* ((last-year-seconds (- (float-time) (* 365 24 60 60)))
       (last-year (seconds-to-time last-year-seconds))
       (last-year-dow (nth 6 (decode-time last-year)))
       (this-year-dow (nth 6 (decode-time)))
       (difference (if (> this-year-dow last-year-dow)
                       (- this-year-dow last-year-dow)
                     (- last-year-dow this-year-dow)))
       (target-date-seconds (+ last-year-seconds (* difference 24 60 60)))
       (target-date (seconds-to-time target-date-seconds)))
  (format-time-string "%Y%m%d" target-date)))

(defun journal-last-year ()
  "Loads last year's journal entry, which is not necessary the
same day of the month, but will be the same day of the week."
  (interactive)
  (let ((journal-file (concat org-journal-dir (journal-last-year-file))))
    (find-file journal-file)))

  (global-set-key (kbd "C-c f L") 'journal-last-year)




(defun ha/org-return (&optional ignore)                                          ;;
  "Add new list item, heading or table row with RET.                             ;;
A double return on an empty element deletes it.                                  ;;
Use a prefix arg to get regular RET. "                                           ;;
  (interactive "P")                                                              ;;
  (if ignore                                                                     ;;
      (org-return)                                                               ;;
    (cond                                                                        ;;
     ;; Open links like usual                                                    ;;
     ((eq 'link (car (org-element-context)))                                     ;;
      (org-return))                                                              ;;
     ;; lists end with two blank lines, so we need to make sure we are also not  ;;
     ;; at the beginning of a line to avoid a loop where a new entry gets        ;;
     ;; created with only one blank line.                                        ;;
     ((and (org-in-item-p) (not (bolp)))                                         ;;
      (if (org-element-property :contents-begin (org-element-context))           ;;
          (org-insert-heading)                                                   ;;
        (beginning-of-line)                                                      ;;
        (setf (buffer-substring                                                  ;;
               (line-beginning-position) (line-end-position)) "")                ;;
        (org-return)))                                                           ;;
     ((org-at-heading-p)                                                         ;;
      (if (not (string= "" (org-element-property :title (org-element-context)))) ;;
          (progn (org-end-of-meta-data)                                          ;;
                 (org-insert-heading))                                           ;;
        (beginning-of-line)                                                      ;;
        (setf (buffer-substring                                                  ;;
               (line-beginning-position) (line-end-position)) "")))              ;;
     ((org-at-table-p)                                                           ;;
      (if (-any?                                                                 ;;
           (lambda (x) (not (string= "" x)))                                     ;;
           (nth                                                                  ;;
            (- (org-table-current-dline) 1)                                      ;;
            (org-table-to-lisp)))                                                ;;
          (org-return)                                                           ;;
        ;; empty row                                                             ;;
        (beginning-of-line)                                                      ;;
        (setf (buffer-substring                                                  ;;
               (line-beginning-position) (line-end-position)) "")                ;;
        (org-return)))                                                           ;;
     (t                                                                          ;;
      (org-return)))))                                                           ;;
                                                                                 ;;
(define-key org-mode-map (kbd "RET")  #'ha/org-return)                           ;;


(setq flyspell-issue-welcome-flag t) ;; fix flyspell problem

(custom-set-variables
    '(ispell-dictionary "british")
    '(ispell-program-name "C:\\Program Files (x86)\\Aspell\\bin\\aspell.exe"))


;;;M-x reinstall many times ,finally get installed
(require 'org-journal)
(setq org-journal-dir "~/.emacs.d/GTD/orgBoss/journal/")


(setq org-export-with-sub-superscripts nil)
(setq org-export-with-section-numbers nil)
(setq org-html-include-timestamps nil)

(setq org-export-with-toc nil)
(setq org-html-toplevel-hlevel 2)
(setq org-export-htmlize-output-type 'css)


(setq user-full-name "Ye Zhaoliang")

;;ox-reveal outside emacs slide(inside emacs use org-tree-slide)
(require 'ox-reveal)
;(setq org-reveal-root "file:///~/.emacs.d/GTD/reveal.js")
;(setq org-reveal-root "~/.emacs.d/GTD/reveal.js/")
(setq org-reveal-root "file:///k:/reveal.js")
(setq org-reveal-postamble "Ye Zhaoliang")


;;org-tree-slide
; (use-package org-tree-slide
;    :ensure t
;    :init
;    (setq org-tree-slide-skip-outline-level 4)
;    (org-tree-slide-simple-profile))
(when (require 'org-tree-slide nil t)
  (global-set-key (kbd "<f7>") 'org-tree-slide-mode)
  (global-set-key (kbd "S-<f7>") 'org-tree-slide-skip-done-toggle)
  (define-key org-tree-slide-mode-map (kbd "<f8>")
    'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "<f9>")
    'org-tree-slide-move-next-tree)
  (define-key org-tree-slide-mode-map (kbd "S-<f9>")
    'org-tree-slide-content)
  (setq org-tree-slide-skip-outline-level 4)
  (setq org-reveal-hlevel 2) ;; the default is one, means only header1 is arranged horizontal
  (org-tree-slide-narrowing-control-profile)
  (setq org-tree-slide-skip-done nil)) 



;;add alert notify
(require 'org-alert)
(setq alert-default-style 'libnotify) ;; libnotify need you path *.so in ubuntu platform
;(setq alert-default-style 'x11) ;; libnotify need you path *.so in ubuntu platform
(setq alert-default-style 'fringe)
;(setq alert-default-style 'mode-line)
;(setq alert-default-style 'message)
(setq org-alert-interval 1800);;default 300s



;;add crypt tag 

(require 'epa-file)
;;base on the easyPG, org-crypt can crypt some entry or topic ,rather than
;; total file
(require 'org-crypt)                                      ;;
(org-crypt-use-before-save-magic)                         ;;
(setq org-tags-exclude-from-inheritance (quote("crypt"))) ;;
;(setq org-crypt-key nil)

;;(setq org-crypt-key "6285F68F72D6D3C2") ;;old certi 2017
;;(setq org-crypt-key "34420FBAB207AB13")  ;;new certi 20180304
(setq org-crypt-key "99643CEA883D3C92")  ;;new certi 20180304
(setq epa-file-cache-passphrase-for-symmetric-encryption t)



(defun now ()
  "Insert string for the current time formatted like '2:34 PM'."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%-I:%M %p"))
)

(defun nowTimePoint ()
  "Insert string for the current time formatted like '2:34 PM'."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%H:%M"))
)



(defun today ()
  "Insert string for today's date nicely formatted in American style,
e.g. Sunday, September 17, 2000."
  (interactive)                 ; permit invocation in minibuffer
  ;(insert (format-time-string "%A, %B %e, %Y"))
  (insert (format-time-string "<%Y-%m-%d %H:%M>"))
)


;; Get the time exactly 24 hours from now.  This produces three integers,
;; like the current-time function.  Each integers is 16 bits.  The first and second
;; together are the count of seconds since Jan 1, 1970.  When the second word
;; increments above 6535, it resets to zero and carries 1 to the high word.
;; The third integer is a count of milliseconds (on machines which can produce
;; this granularity).  The math in the defun below, then, is to accommodate the
;; way the current-time variable is structured.  That is, the number of seconds
;; in a day is 86400.  In effect, we add 65536 (= 1 in the high word) + 20864
;; to the current-time.  However, if 20864 is too big for the low word, if it
;; would create a sum larger than 65535, then we "add" 2 to the high word and
;; subtract 44672 from the low word.

(defun tomorrow-time ()
 "*Provide the date/time 24 hours from the time now in the same format as current-time."
  (setq
   now-time (current-time)              ; get the time now
   hi (car now-time)                    ; save off the high word
   lo (car (cdr now-time))              ; save off the low word
   msecs (nth 2 now-time)               ; save off the milliseconds
   )

  (if (> lo 44671)                      ; If the low word is too big for adding to,
      (setq hi (+ hi 2)  lo (- lo 44672)) ; carry 2 to the high word and subtract from the low,
    (setq hi (+ hi 1) lo (+ lo 20864))  ; else, add 86400 seconds (in two parts)
    )
  (list hi lo msecs)                    ; regurgitate the new values
  )

;(tomorrow-time)

(defun tomorrow ()
  "Insert string for tomorrow's date nicely formatted in American style,
e.g. Sunday, September 17, 2000."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%A, %B %e, %Y" (tomorrow-time)))
)



;; Get the time exactly 24 hours ago and in current-time format, i.e.,
;; three integers.  Each integers is 16 bits.  The first and second
;; together are the count of seconds since Jan 1, 1970.  When the second word
;; increments above 6535, it resets to zero and carries 1 to the high word.
;; The third integer is a count of milliseconds (on machines which can produce
;; this granularity).  The math in the defun below, then, is to accomodate the
;; way the current-time variable is structured.  That is, the number of seconds
;; in a day is 86400.  In effect, we subtract (65536 [= 1 in the high word] + 20864)
;; from the current-time.  However, if 20864 is too big for the low word, if it
;; would create a sum less than 0, then we subtract 2 from the high word
;; and add 44672 to the low word.

(defun yesterday-time ()
"Provide the date/time 24 hours before the time now in the format of current-time."
  (setq
   now-time (current-time)              ; get the time now
   hi (car now-time)                    ; save off the high word
   lo (car (cdr now-time))              ; save off the low word
   msecs (nth 2 now-time)               ; save off the milliseconds
   )

  (if (< lo 20864)                      ; if the low word is too small for subtracting
   (setq hi (- hi 2)  lo (+ lo 44672)) ; take 2 from the high word and add to the low
    (setq hi (- hi 1) lo (- lo 20864))  ; else, add 86400 seconds (in two parts)
    )
  (list hi lo msecs)                    ; regurgitate the new values
  )                                     ; end of yesterday-time

(defun yesterday ()
  "Insert string for yesterday's date nicely formatted in American style,
e.g. Sunday, September 17, 2000."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%A, %B %e, %Y" (yesterday-time)))
)


;;org-clock-convinience
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package org-clock-convenience                                    ;;
;;   :ensure t                                                           ;;
;;   :bind (:map org-agenda-mode-map                                     ;;
;;    	   ("<S-up>" . org-clock-convenience-timestamp-up)               ;;
;;    	   ("<S-down>" . org-clock-convenience-timestamp-down)           ;;
;;    	   ("ö" . org-clock-convenience-fill-gap)                        ;;
;;    	   ("é" . org-clock-convenience-fill-gap-both)))                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (load "orca.el")                                    ;;
;; (require 'orca)                                     ;;
;; (setq orca-handler-list                             ;;
;;       '((orca-handler-match-url                     ;;
;;          "https://www.reddit.com/emacs/"            ;;
;;          "~/.emacs.d/GTD/orgBoss/Site/www.site.org" ;;
;;          "Reddit")                                  ;;
;;         (orca-handler-match-url                     ;;
;;          "https://emacs.stackexchange.com/"         ;;
;;          "~/.emacs.d/GTD/orgBoss/Site/www.site.org" ;;
;;          "\\* Questions")                           ;;
;;         (orca-handler-current-buffer                ;;
;;          "\\* Tasks")                               ;;
;;         (orca-handler-file                          ;;
;;          "~/.emacs.d/GTD/orgBoss/newgtd.org"        ;;
;;          "\\* Articles")))                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq browse-url-browser-function 'eww-browse-url)


(defvar my/espeak-command "c://eSpeak//command_line//espeak.exe")
(defun my/say (string &optional speed)
  (interactive "MString: ")
  (setq speed (or speed 175))
  (call-process my/espeak-command nil nil nil string "-s" speed))

 

(global-set-key (kbd "C-c e") 'org-mark-ring-goto)
(global-set-key (kbd "C-c w") 'org-mark-ring-push)


;;https://github.com/jacktasia/dumb-jump
(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g b" . dumb-jump-back)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
;;(setq dumb-jump-debug t)   ;;when something wrong with dumb-jump,uncomment it 
(setq dumb-jump-force-searcher 'ag)
  :ensure)


;;https://github.com/jacktasia/dumb-diff
(use-package dumb-diff
  :bind (("C-c d" . dumb-diff)
         ("C-c 1" . dumb-diff-set-region-as-buffer1)
         ("C-c 2" . dumb-diff-set-region-as-buffer2)
         ("C-c q" . dumb-diff-quit))
  :ensure t)



;; org-mind-map

(require 'ox-org)


(use-package poporg
      :bind (("C-c t" . poporg-dwim)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'writegood-mode)                         ;;
;; (global-set-key "\C-c n" 'writegood-grade-level)  ;;
;;                                                   ;;
;; (global-set-key "\C-c o" 'writegood-reading-ease) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; org-dashboard

(setq org-dashboard-files (list 
                           "~/.emacs.d/GTD/orgBoss/newgtd.org"
                           "~/.emacs.d/GTD/orgBoss/hello.org"
))

;For example, to avoid displaying entries that are finished (progress = 100), not started (progress = 0), or are tagged with "archive", use the following:


(defun my/org-dashboard-filter (entry)                     ;;
    (and (>= (plist-get entry :progress-percent) 0)         ;;
        (< (plist-get entry :progress-percent) 100)        ;;
        (not (member "archive" (plist-get entry :tags))))) ;;
                                                           ;;
(setq org-dashboard-filter 'my/org-dashboard-filter)       ;;



(setq global-page-break-lines-mode t)

(require 'org-listcruncher)

;(setq org-mru-clock-how-many 100)
;(setq org-mru-clock-completing-read #'ivy-completing-read)
(use-package org-mru-clock
  :ensure t
  :bind* (("C-c C-x i" . org-mru-clock-in)
          ("C-c C-x C-j" . org-mru-clock-select-recent-task))
  :init
  (setq org-mru-clock-how-many 100
        org-mru-clock-completing-read #'ivy-completing-read))

;;; org-brain

(use-package org-brain :ensure t
  :init
  (setq org-brain-path "~/.emacs.d/gtd/org_Brain")
  ;; For Evil users
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  :config
  (setq org-brain-file-entries-use-title nil)
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12))

;; ascii-art-to-unicode is useful if you want org-brain-visualize-mode to look a bit nicer. After installing, add the following to your init-file:
;; http://www.gnuvola.org/software/aa2u/

(defun aa2u-buffer ()                                    ;;
  (aa2u (point-min) (point-max)))                        ;;
                                                         ;;
(add-hook 'org-brain-after-visualize-hook #'aa2u-buffer) ;;


;; Here’s a command which uses org-cliplink to add a link from the clipboard as an org-brain resource. It guesses the description from the URL title. Here I’ve bound it to L in org-brain-visualize.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun org-brain-cliplink-resource ()                                             ;;
;;   "Add a URL from the clipboard as an org-brain resource.                         ;;
;; Suggest the URL title as a description for resource."                             ;;
;;   (interactive)                                                                   ;;
;;   (let ((url (org-cliplink-clipboard-content)))                                   ;;
;;     (org-brain-add-resource                                                       ;;
;;      url                                                                          ;;
;;      (org-cliplink-retrieve-title-synchronously url)                              ;;
;;      t)))                                                                         ;;
;;                                                                                   ;;
;; (define-key org-brain-visualize-mode-map (kbd "L") #'org-brain-cliplink-resource) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; org-wiki
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (let ((url "https://raw.githubusercontent.com/caiorss/org-wiki/master/org-wiki.el"))      ;;
;;       (with-current-buffer (url-retrieve-synchronously url)                               ;;
;;     (goto-char (point-min))                                                               ;;
;;     (re-search-forward "^$")                                                              ;;
;;     (delete-region (point) (point-min))                                                   ;;
;;     (kill-whole-line)                                                                     ;;
;;     (package-install-from-buffer)))                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'org-wiki)                                                ;;
;; ;; (setq org-wiki-location "e:/projects/org-wiki-test.emacs")      ;;
;;                                                                    ;;
;; (setq org-wiki-location-list                                       ;;
;;       '(                                                           ;;
;;         "~/.emacs.d/GTD/orgwiki"    ;; First wiki is the default.  ;;
;;         ))                                                         ;;
;; (setq org-wiki-server-port "8085") ;; 8000 - default value         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; org-ref                                                                                  ;;
;;                                                                                             ;;
;;                                                                                             ;;
;; ;; see org-ref for use of these variables                                                   ;;
;; (setq org-ref-bibliography-notes "~/.emacs.d/GTD/org-ref/bibliography/notes.org"            ;;
;;       org-ref-default-bibliography '("~/.emacs.d/GTD/org-ref//bibliography/references.bib") ;;
;;       org-ref-pdf-directory "~/.emacs.d/GTD/org-ref/bibliography/bibtex-pdfs/")             ;;
;;                                                                                             ;;
;;                                                                                             ;;
;; (setq bibtex-completion-bibliography "~/.emacs.d/GTD/org-ref//bibliography/references.bib"  ;;
;;       bibtex-completion-library-path "~/.emacs.d/GTD/org-ref/bibliography/bibtex-pdfs/"     ;;
;;       bibtex-completion-notes-path "~/.emacs.d/GTD/org-ref/bibliography/helm-bibtex-notes") ;;
;;                                                                                             ;;
;; ;; open pdf with system pdf viewer (works on mac)                                           ;;
;; (setq bibtex-completion-pdf-open-function                                                   ;;
;;   (lambda (fpath)                                                                                ;;
;;     (start-process "open" "*open*" "open" fpath)))                                          ;;
;;                                                                                             ;;
;; ;; alternative                                                                              ;;
;; ;; (setq bibtex-completion-pdf-open-function 'org-open-file)                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ace-link in your info-mode any other mode to create link in the text
(ace-link-setup-default)


;; deft configuration
;;By default, Deft looks for notes by searching for files with the extensions .txt, .text, .md, .markdown, or .org in the ~/.deft
(setq deft-extensions '("org" "md" "wiki" "txt" "text"))
(setq deft-directory "~/.emacs.d/GTD/")
(setq deft-recursive t)  ;By default, Deft only searches for files in deft-directory but not in any subdirectories.

(global-set-key [f8] 'deft)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package deft                                ;;
;;   :bind ("<f8>" . deft)                          ;;
;;   :commands (deft)                               ;;
;;   :config (setq deft-directory "~/.emacs.d/GTD/" ;;
;;                 deft-extensions '("md" "org")))  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq deft-use-filename-as-title t) ;; 
;(setq deft-new-file-format "%Y-%m-%dT%H%M") ;; o

;(setq deft-use-filter-string-for-filename t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq deft-file-naming-rules '((noslash . "-")        ;;
;;                                (nospace . "-")        ;;
;;                                (case-fn . downcase))) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 加速 https://github.com/sachac/.emacs.d/blob/gh-pages/Sacha.org#speed-commands
(with-eval-after-load 'org-agenda
  (bind-key "i" 'org-agenda-clock-in org-agenda-mode-map))
(setq org-use-effective-time t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    (defun my/org-use-speed-commands-for-headings-and-lists ()                                 ;;
;;      "Activate speed commands on list items too."                                             ;;
;;      (or (and (looking-at org-outline-regexp) (looking-back "^\**"))                          ;;
;;          (save-excursion (and (looking-at (org-item-re)) (looking-back "^[ \t]*")))))         ;;
;;    (setq org-use-speed-commands 'my/org-use-speed-commands-for-headings-and-lists)            ;;
;;                                                                                               ;;
;; (with-eval-after-load 'org                                                                    ;;
;;    (add-to-list 'org-speed-commands-user '("x" org-todo "DONE"))                              ;;
;;    (add-to-list 'org-speed-commands-user '("y" org-todo-yesterday "DONE"))                    ;;
;;    (add-to-list 'org-speed-commands-user '("!" my/org-clock-in-and-track))                    ;;
;;    (add-to-list 'org-speed-commands-user '("s" call-interactively 'org-schedule))             ;;
;;    (add-to-list 'org-speed-commands-user '("d" my/org-move-line-to-destination))              ;;
;;    (add-to-list 'org-speed-commands-user '("i" call-interactively 'org-clock-in))             ;;
;;    (add-to-list 'org-speed-commands-user '("P" call-interactively 'org2blog/wp-post-subtree)) ;;
;;    (add-to-list 'org-speed-commands-user '("o" call-interactively 'org-clock-out))            ;;
;;    (add-to-list 'org-speed-commands-user '("$" call-interactively 'org-archive-subtree))      ;;
;;    (bind-key "!" 'my/org-clock-in-and-track org-agenda-mode-map))                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun org-insert-file (filename)                                                                                                                                                                              ;;
;;       "Insert Elisp code block recreating FILE in the current                                                                                                                                                  ;;
;; directory."                                                                                                                                                                                                    ;;
;;       (interactive "f")                                                                                                                                                                                        ;;
;;       (let ((basename (file-name-nondirectory filename))                                                                                                                                                       ;;
;; 	    (base64-string                                                                                                                                                                                        ;;
;; 	     (with-temp-buffer                                                                                                                                                                                    ;;
;; 	       (insert-file-contents-literally filename)                                                                                                                                                          ;;
;; 	       (base64-encode-region (point-min) (point-max))                                                                                                                                                     ;;
;; 	       (buffer-string))))                                                                                                                                                                                 ;;
;; 	(save-excursion                                                                                                                                                                                           ;;
;; 	  (insert (format "[[./%s]]\n#+BEGIN_SRC emacs-lisp :results output silent\n  (with-temp-file %S\n    (insert (base64-decode-string\n      %S)))\n#+END_SRC" basename basename base64-string)))           ;;
;; 	(forward-line)                                                                                                                                                                                            ;;
;; 	(copy-file filename basename 1)                                                                                                                                                                           ;;
;; 	(org-display-inline-images)))                                                                                                                                                                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; org-ref

(require 'org-ref)
(setq reftex-default-bibliography '("~/.emacs.d/GTD/orgref/reference.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/.emacs.d/GTD/orgref/notes.org"
      org-ref-default-bibliography '("~/.emacs.d/GTD/orgref/reference.bib" "~/.emacs.d/GTD/orgref/20180324.bib" "~/.emacs.d/GTD/orgref/20180303.bib" "~/.emacs.d/GTD/orgref/higherMegawatt.bib" "~/.emacs.d/GTD/orgref/20161223.bib")
      org-ref-pdf-directory "~/.emacs.d/GTD/orgref/bibtex-pdfs/")



(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))


;(require 'artbollocks-mode)
;(add-hook 'text-mode-hook 'artbollocks-mode)

(use-package artbollocks-mode
  :defer t
  :config
  (progn
    (setq artbollocks-weasel-words-regex
          (concat "\\b" (regexp-opt
                         '("one of the"
                           "should"
                           "just"
                           "sort of"
                           "a lot"
                           "probably"
                           "maybe"
                           "perhaps"
                           "I think"
                           "really"
                           "pretty"
                           "nice"
                           "action"
                           "utilize"
                           "leverage") t) "\\b"))
    ;; Don't show the art critic words, or at least until I figure
    ;; out my own jargon
    (setq artbollocks-jargon nil)))

;;; http://emacsredux.com/blog/2013/03/27/open-file-in-external-program/
(defun prelude-open-with (arg)
  "Open visited file in default external program.

With a prefix ARG always prompt for command to use."
  (interactive "P")
  (when buffer-file-name
    (shell-command (concat
                    (cond
                     ((and (not arg) (eq system-type 'darwin)) "open")
                     ((and (not arg) (member system-type '(gnu gnu/linux gnu/kfreebsd))) "xdg-open")
                     (t (read-shell-command "Open current file with: ")))
                    " "
                    (shell-quote-argument buffer-file-name)))))

(add-to-list 'org-file-apps '("pdf" . "acrobat %s"))


;; https://github.com/sachac/.emacs.d/blob/gh-pages/Sacha.org#estimating-wpm
(require 'org-clock)
(defun my/org-entry-wpm ()
  (interactive)
  (save-restriction
    (save-excursion
      (org-narrow-to-subtree)
      (goto-char (point-min))
      (let* ((words (count-words-region (point-min) (point-max)))
	     (minutes (org-clock-sum-current-item))
	     (wpm (/ words minutes)))
	(message "WPM: %d (words: %d, minutes: %d)" wpm words minutes)
	(kill-new (number-to-string wpm))))))



(defun my/org-send-to-bottom-of-list ()
  "Send the current line to the bottom of the list."
  (interactive)
  (beginning-of-line)
  (let ((kill-whole-line t))
    (save-excursion
      (kill-line 1)
      (org-end-of-item-list)
      (yank))))



;; record orgmode recent activity
;; enable the log feature
(setq org-log-into-drawer t)
(setq org-log-reschedule 'time)
(setq org-log-redeadline 'note)
(setq org-log-note-clock-out t)

;; add T: before timestamp for easy regex search
(setq org-log-note-headings '((done . "CLOSING NOTE T:%t")
                              (state . "State %-12s from %-12S T:%t")
                              (note . "Note taken on T:%t")
                              (reschedule . "Rescheduled from %S on T:%t")
                              (delschedule . "Not scheduled, was %S on T:%t")
                              (redeadline . "New deadline from %S on T:%t")
                              (deldeadline . "Removed deadline, was %S on T:%t")
                              (refile . "Refiled on T:%t")
                              (clock-out . "Clocked out on T:%t")))

(defun +org/find-state (&optional end)
  "Used to search through the logbook of subtrees.

    Looking for T:[2018-09-14 Fri 10:50] kind of time stamp in logbook."
  (let* ((closed (re-search-forward "^CLOSED: \\[" end t))
         (created (if (not closed) (re-search-forward "^:CREATED: \\[" end t)))
         (logbook (if (not closed) (re-search-forward ".*T:\\[" end t)))
         (result (or closed logbook created)))
    result))

(defun +org/date-diff (start end &optional compare)
  "Calculate difference between  selected timestamp to current date.

  The difference between the dates is calculated in days.
  START and END define the region within which the timestamp is found.
  Optional argument COMPARE allows for comparison to a specific date rather than to current date."
  (let* ((start-date (if compare compare (calendar-current-date))))
    (- (calendar-absolute-from-gregorian start-date) (org-time-string-to-absolute (buffer-substring-no-properties start end)))))

(defun +org/last-update-before (since)
  "List Agenda items that updated before SINCE day."
  (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (subtree-valid (save-excursion
                            (forward-line 1)
                            (if (and (< (point) subtree-end)
                                     ;; Find the timestamp to test
                                     (+org/find-state subtree-end))
                                (let ((startpoint (point)))
                                  (forward-word 3)
                                  ;; Convert timestamp into days difference from today
                                  (+org/date-diff startpoint (point)))
                              (point-max)))))
      (if (and subtree-valid (>= subtree-valid since))
          next-headline
        nil))))

(defun +org/has-child-and-last-update-before (day)
  (if (+org/has-child-p) (point)
    (+org/last-update-before day)))    
(defun +org/has-child-p ()
  (save-excursion (org-goto-first-child)))
