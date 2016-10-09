(setq-default show-trailing-whitespace t)
(setq whitespace-style '(face tabs trailing newline empty tab-mark))

(global-whitespace-mode 1)

(use-package whitespace-cleanup-mode
  :ensure t
  :config
  (global-whitespace-cleanup-mode t))

(provide 'core-whitespace)
