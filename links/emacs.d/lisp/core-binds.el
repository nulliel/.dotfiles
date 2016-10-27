;; Prevent closing emacs
(global-unset-key (kbd "C-x C-c"))

;; Prevent arrow keys
(global-unset-key [C-left])
(global-unset-key [C-right])
(global-unset-key [M-left])
(global-unset-key [M-right])
(global-unset-key [left])
(global-unset-key [right])

(provide 'core-binds)
