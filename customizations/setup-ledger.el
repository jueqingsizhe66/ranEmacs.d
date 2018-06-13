;;; setup-ledger.el --- 
;; Copyright (C) 2018  Ye Zhaoliang

;; Author: Ye Zhaoliang <yzl@DESKTOP-MVNHR6D>
;; Keywords: tools, abbrev, 

(require 'ledger-mode)
(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

(defun ledger-accounts ()
    (mapcar 'list '(建行7889  建行1593 牡丹卡 花呗 支付宝 微信 Tourists Houselive Salary Fruits Eating Amusement Learning Sports Car Train Aircraft Phone Stokes)))

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
