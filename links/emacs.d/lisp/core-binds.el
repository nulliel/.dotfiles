;;--------------------------------------------------
;; Don't close emacs with binds
;;--------------------------------------------------
(global-unset-key (kbd "C-x C-c"))

;;--------------------------------------------------
;; Prevent use of arrow keys
;;--------------------------------------------------
(global-unset-key [C-left])
(global-unset-key [C-right])
(global-unset-key [M-left])
(global-unset-key [M-right])
(global-unset-key [left])
(global-unset-key [right])

;;--------------------------------------------------
;; Binds
;;--------------------------------------------------
(global-set-key (kbd "<Scroll_Lock>") 'create-dired-persistent-window)
(global-set-key [pause] 'toggle-window-dedication)

(provide 'core-binds)
