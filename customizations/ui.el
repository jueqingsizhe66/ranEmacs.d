;; These customizations change the way emacs looks and disable/enable
;; some user interface elements. Some useful customizations are
;; commented out, and begin with the line "CUSTOMIZE". These are more
;; a matter of preference and may require some fiddling to match your
;; preferences

;; Turn off the menu bar at the top of each frame because it's distracting
(menu-bar-mode -1)

(tool-bar-mode -1)
;; Show line numbers
;;(global-linum-mode)
;;(global-linum-mode -1)
(global-nlinum-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package nlinum-relative                                                                 ;;
;;     :config                                                                                  ;;
;;     ;; something else you want                                                               ;;
;;     (nlinum-relative-setup-evil)                                                             ;;
;;     (add-hook 'prog-mode-hook 'nlinum-relative-mode)                                         ;;
;;     (setq nlinum-relative-redisplay-delay 0)      ;; delay                                   ;;
;;     (setq nlinum-relative-current-symbol "->")      ;; or "" for display current line number ;;
;;     (setq nlinum-relative-offset 0)                 ;; 1 if you want 0, 2, 3...              ;;
;; )                                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; You can uncomment this to remove the graphical toolbar at the top. After
;; awhile, you won't need the toolbar.
;; (when (fboundp 'tool-bar-mode)
;;   (tool-bar-mode -1))

;; Don't show native OS scroll bars for buffers because they're redundant
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Color Themes
;; Read http://batsov.com/articles/2012/02/19/color-theming-in-emacs-reloaded/
;; for a great explanation of emacs color themes.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Custom-Themes.html
;; for a more technical explanation.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes/spacemacs-theme")
;(load-theme 'tomorrow-night-bright t)
;(load-theme 'spacemacs-dark t)
(load-theme 'srcery t)
  (setq spacemacs-theme-org-agenda-height nil)
  (setq spacemacs-theme-org-height nil)
;; set sizes here to stop spacemacs theme resizing these



;(load-theme 'dracula t)
;; workaround blue problem https://github.com/bbatsov/solarized-emacs/issues/18
(custom-set-faces
(if (not window-system)
  '(default ((t (:background "nil"))))))

;; increase font size for better readability
(set-face-attribute 'default nil :height 140)

;; Uncomment the lines below by removing semicolons and play with the
;; values in order to set the width (in characters wide) and height
;; (in lines high) Emacs will have whenever you start it
;; (setq initial-frame-alist '((top . 0) (left . 0) (width . 177) (height . 53)))

;; These settings relate to how emacs interacts with your operating system
(setq ;; makes killing/yanking interact with the clipboard
      x-select-enable-clipboard t

      ;; I'm actually not sure what this does but it's recommended?
      x-select-enable-primary t

      ;; Save clipboard strings into kill ring before replacing them.
      ;; When one selects something in another program to paste it into Emacs,
      ;; but kills something in Emacs before actually pasting it,
      ;; this selection is gone unless this variable is non-nil
      save-interprogram-paste-before-kill t

      ;; Shows all options when running apropos. For more info,
      ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Apropos.html
      apropos-do-all t

      ;; Mouse yank commands yank at point instead of at click.
      mouse-yank-at-point t)

;; No cursor blinking, it's distracting
(blink-cursor-mode 0)

;; full path in title bar
(setq-default frame-title-format "%b (%f)")

;; don't pop up font menu
(global-set-key (kbd "s-t") '(lambda () (interactive)))

;; no bell
(setq ring-bell-function 'ignore)

;
;(require 'neotree)
;(global-set-key [f6] 'neotree-toggle)




; 语法高亮。除 shell-mode 和 text-mode 之外的模式中使用语法高亮。
;进行语法加亮。

;(require 'all-the-icons)
; (setq neo-theme (if (display-graphic-p) 'icons 'arrow))



;;----------日历设置--------------------

;;设置日历的一些颜色
;(setq calendar-load-hook
;'(lambda ()
;;(set-face-foreground 'diary-face "")
;;(set-face-background 'holiday-face "slate blue")
;;(set-face-foreground 'holiday-face "white")))

;;设置我所在地方的经纬度，calendar里有个功能是日月食的预测，和你的经纬度相联系的。
;; 让emacs能计算日出日落的时间，在 calendar 上用 S 即可看到
;;; cal-china-x
(require 'cal-china-x)
(setq mark-holidays-in-calendar t)
(setq other-holidays '())
(setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
(setq cal-china-x-general-holidays '(
                                     (holiday-lunar 1 1 "新年")
                                     (holiday-lunar 1 15 "元宵节")
                                     (holiday-lunar 2 2 "头牙(龙抬头 春耕节)")
                                     (holiday-lunar 4 4 "寒食节")
                                     (holiday-lunar 4 5 "清明节")
                                     (holiday-lunar 5 5 "端午节")
                                     (holiday-lunar 6 1 "半年节")
                                     (holiday-lunar 7 7 "七夕节")
                                     (holiday-lunar 7 15 "中元节")
                                     (holiday-lunar 8 15 "中秋节")
                                     (holiday-lunar 9 9 "重阳节")
                                     (holiday-lunar 10 1 "寒衣节(祭祖)")
                                     (holiday-lunar 10 15 "下元节")
                                     (holiday-lunar 12 8 "腊八节")
                                     (holiday-lunar 12 22 "冬至")
                                     (holiday-lunar 12 24 "祭灶")
                                     (holiday-lunar 12 30 "除夕")
                                     (holiday-lunar 7 24 "中元节")
                                     (holiday-lunar 7 24 "中元节")
                                     ; (holiday-fixed 1 1 "元旦")
                                     ; (holiday-fixed 2 14 "情人节")
                                     ; (holiday-fixed 3 14 "白色情人节")
                                     ; (holiday-fixed 4 1 "愚人节")
                                     ; (holiday-fixed 5 1 "劳动节")
                                     ; (holiday-fixed-float 5 0 2 "母亲节")
                                     ; (holiday-fixed 6 1 "儿童节")
                                     ; (holiday-fixed-float 6 0 3 "父亲节")
                                     ; (holiday-fixed 7 1 "建党节")
                                     ; (holiday-fixed 8 1 "建军节")
                                     ; (holiday-fixed 9 10 "教师节")
                                     ; (holiday-fixed 10 1 "国庆节")
                                     ; (holiday-fixed 12 25 "圣诞节")
                                     ; (holiday-fixed 7 4 "结婚纪念日")
                                     ))
(setq calendar-holidays
      (append cal-china-x-important-holidays
              cal-china-x-general-holidays
              other-holidays))

;;;;cal-china-x

;;;; move here from navigation.el
;; in the digital keyboard add calendar and bookmark
(global-set-key (kbd "<kp-7>") 'calendar)
(global-set-key  (kbd "<kp-8>") 'list-bookmarks)
(setq bookmark-save-flag 1) ;; everytime bookmark is changed, automatically save it
(setq bookmark-save-flag t) ;; save bookmark when emacs quit

;;;; move  end
 
(setq calendar-latitude +39.54)
(setq calendar-longitude +116.28)
(setq calendar-location-name "北京")

;; 设置阴历显示，在 calendar 上用 pC 显示阴历
(setq chinese-calendar-celestial-stem
  ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"])
(setq chinese-calendar-terrestrial-branch
  ["子" "丑" "寅" "卯" "辰" "巳" "戊" "未" "申" "酉" "戌" "亥"])

;; 设置 calendar 的显示
(setq calendar-remove-frame-by-deleting t)
(setq calendar-week-start-day 1) ; 设置星期一为每周的第一天
(setq mark-diary-entries-in-calendar t) ; 标记calendar上有diary的日期
(setq mark-holidays-in-calendar nil) ; 为了突出有diary的日期，calendar上不标记节日
(setq view-calendar-holidays-initially nil) ; 打开calendar的时候不显示一堆节日

;; 去掉不关心的节日，设定自己在意的节日，在 calendar 上用 h 显示节日
(setq christian-holidays nil)
(setq hebrew-holidays nil)
(setq islamic-holidays nil)
(setq solar-holidays nil)


;;Calendar模式支持各种方式来更改当前日期
;;（这里的“前”是指还没有到来的那一天，“后”是指已经过去的日子）
;; q 退出calendar模式
;; C-f 让当前日期向前一天
;; C-b 让当前日期向后一天
;; C-n 让当前日期向前一周
;; C-p 让当前日期向后一周
;; M-} 让当前日期向前一个月
;; M-{ 让当前日期向后一个月
;; C-x ] 让当前日期向前一年
;; C-x [ 让当前日期向后一年
;; C-a 移动到当前周的第一天
;; C-e 移动到当前周的最后一天
;; M-a 移动到当前月的第一天
;; M-e 多动到当前月的最后一天
;; M-< 移动到当前年的第一天
;; M-> 移动到当前年的最后一天

;;Calendar模式支持移动多种移动到特珠日期的方式
;; g d 移动到一个特别的日期
;; o 使某个特殊的月分作为中间的月分
;; . 移动到当天的日期
;; p d 显示某一天在一年中的位置，也显示本年度还有多少天。
;; C-c C-l 刷新Calendar窗口

;; Calendar支持生成LATEX代码。
;; t m 按月生成日历
;; t M 按月生成一个美化的日历
;; t d 按当天日期生成一个当天日历
;; t w 1 在一页上生成这个周的日历
;; t w 2 在两页上生成这个周的日历
;; t w 3 生成一个ISO-SYTLE风格的当前周日历
;; t w 4 生成一个从周一开始的当前周日历
;; t y 生成当前年的日历

;;EMACS Calendar支持配置节日：
;; h 显示当前的节日
;; x 定义当天为某个节日
;; u 取消当天已被定义的节日
;; e 显示所有这前后共三个月的节日。
;; M-x holiday 在另外的窗口的显示这前后三个月的节日。


;; 另外，还有一些特殊的，有意思的命令：
;; S 显示当天的日出日落时间(是大写的S)
;; p C 显示农历可以使用
;; g C 使用农历移动日期可以使用

;;-----------日历设置结束----------------
;;-----------日记设置---------------------

(setq diary-file "~/.emacs.d/CalendarDairy/diary.org");; 默认的日记文件
(setq diary-mail-addr "zhaoturkkey@163.com")
;;(add-hook 'diary-hook 'appt-make-list)
;;当你创建了一个'~/diary'文件，你就可以使用calendar去查看里面的内容。你可以查看当天的事件，相关命令如下 ：
;; d 显示被选中的日期的所有事件
;; s 显示所有事件，包括过期的，未到期的等等

;; 创建一个事件的样例：
;; 02/11/1989
;; Bill B. visits Princeton today
;; 2pm Cognitive Studies Committee meeting
;; 2:30-5:30 Liz at Lawrenceville
;; 4:00pm Dentist appt
;; 7:30pm Dinner at George's
;; 8:00-10:00pm concert

;; 创建事件的命令：
;; i d 为当天日期添加一个事件
;; i w 为当天周创建一个周事件
;; i m 为当前月创建一个月事件
;; i y 为当前年创建一个年事件
;; i a 为当前日期创建一个周年纪念日
;; i c 创建一个循环的事件

;;----------日记设置结束-----------------


;;;magit configure from http://whattheemacsd.com/

;; C-c C-a to amend without any prompt


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; (setq default-mode-line-format                                                                   ;;
    ;;       (list ""                                                                                   ;;
    ;;             'mode-line-modified                                                                  ;;
    ;;             "<"                                                                                  ;;
    ;;             "YeZhaoliang"                                                                        ;;
    ;;             "> "                                                                                 ;;
    ;;             "%10b"                                                                               ;;
    ;;             '(:eval (when nyan-mode (list (nyan-create))));;注意添加此句到你的format配置列表中   ;;
    ;;             " "                                                                                  ;;
    ;;             'default-directory                                                                   ;;
    ;;             " "                                                                                  ;;
    ;;             "%[("                                                                                ;;
    ;;             'mode-name                                                                           ;;
    ;;             'minor-mode-list                                                                     ;;
    ;;             "%n"                                                                                 ;;
    ;;             'mode-line-process                                                                   ;;
    ;;             ")%]--"                                                                              ;;
    ;;             "Line %l--"                                                                          ;;
    ;;             '(-3 . "%P")                                                                         ;;
    ;;             "-%-"))                                                                              ;;
    ;; (nyan-mode t);;启动nyan-mode                                                                     ;;
    ;; ;(nyan-start-animation);;开始舞动吧（会耗cpu资源）                                               ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(nyan-mode t)
