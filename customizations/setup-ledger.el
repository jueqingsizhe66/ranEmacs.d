;;; setup-ledger.el --- 
;; Copyright (C) 2018  Ye Zhaoliang

;; Author: Ye Zhaoliang <yzl@DESKTOP-MVNHR6D>
;; Keywords: tools, abbrev, 

(require 'ledger-mode)
(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

;;(setq  ledger-binary-path "c\\Users\\yzl\\Desktop\\ledger_3.1.1_win_bin\\ledger.exe")

(defun ledger-accounts ()
    (mapcar 'list '(Eating Salary Fruits 建行7889  建行1593 牡丹卡 花呗 支付宝 微信 Tourists Houselive  Amusement Learning Sports Car Train Aircraft Phone Stokes)))

(defun ledger-add-entry (title in amount out)
  (interactive
   (let ((accounts (ledger-accounts)))
     (list (read-string "Entry: " (format-time-string "%Y-%m-%d " (current-time)))
           (let ((completion-regexp-list "Assets:"))
             (concat completion-regexp-list  (completing-read "What did you pay for? "  accounts)))
           (read-string "How much did you pay? " "RMB ")
           (let ((completion-regexp-list "Liabilities:"))
             (concat completion-regexp-list  (completing-read "Where did the money come from? " accounts))))))
  (insert title)
  (newline)
  (indent-to 4)
  (insert in "  " amount)
  (newline)
  (indent-to 4)
  (insert out))
