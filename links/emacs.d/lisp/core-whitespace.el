;;--------------------------------------------------
;; Show unnecessary whitespace
;;--------------------------------------------------
(setq-default show-trailing-whitespace t)
(setq whitespace-style '(face tabs trailing newline empty tab-mark))

(global-whitespace-mode 1)
(diminish 'global-whitespace-mode)

;;--------------------------------------------------
;; Remove unnecessary whitespace
;;--------------------------------------------------
(use-package whitespace-cleanup-mode
  :ensure t
  :diminish whitespace-cleanup-mode
  :config
  (global-whitespace-cleanup-mode t))

(provide 'core-whitespace)
