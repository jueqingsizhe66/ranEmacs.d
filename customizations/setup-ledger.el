;;; setup-ledger.el --- 
;; Copyright (C) 2018  Ye Zhaoliang

;; Author: Ye Zhaoliang <yzl@DESKTOP-MVNHR6D>
;; Keywords: tools, abbrev, 

(require 'ledger-mode)
(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

;;(setq  ledger-binary-path "c\\Users\\yzl\\Desktop\\ledger_3.1.1_win_bin\\ledger.exe")


;; Expenses: where money goes,     ;;
;; Assets: where money sits,       ;;
;; Income: where money comes from, ;;
;; Liabilities: money you owe,     ;;
;; Equity: the real value of your property. ;;

(defun ledger-add-entry (title in amount out)
  (interactive
   (let ((accounts '(Expenses:Fruits Expenses:Tourists Expenses:House-living Expenses:Amusement 
                     Expenses:Utilities:Train Expenses:Utilities:Aircraft Expenses:Utilities:Phone Expenses:Food 
                     Assets:Savings:建行7889  Assets:Savings:建行1593 Assets:Savings:支付宝Alipay 
                     Assets:Savings:微信Weixin Assets:Learning:Book Assets:Learning:Videos 
                     Assets:Learning:Software Assets:Sports Assets:Stokes Assets:现金Cash 
                     Income:SalaryKang Income:SalaryWang Income:SalaryNcepu Income:Donation Income:Business 
                     Liabilities:CreditCard:牡丹卡Mudan Liabilities:花呗Huabei Liabilities:Car-load Liabilities:house-load 
                     Equity:Wife)))
     (list (read-string "Entry: " (format-time-string "%Y-%m-%d " (current-time)))
           (completing-read "What did you pay for? "  accounts)
           (read-string "How much did you pay? " "RMB ")
           (completing-read "Where did the money come from? " accounts))))
  (insert title)
  (newline)
  (indent-to 4)
  (insert in "  " amount)
  (newline)
  (indent-to 4)
  (insert out))
