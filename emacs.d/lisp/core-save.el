;; Super save
(use-package super-save
  :ensure t
  :init
  (setq auto-save-default nil)
  (setq super-save-auto-save-when-idle t)
  :config
  (super-save-mode t)
  (diminish 'super-save-mode))

(provide 'core-save)
