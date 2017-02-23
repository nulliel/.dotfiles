;;--------------------------------------------------
;; Super Save
;;--------------------------------------------------
(use-package super-save
  :ensure t
  :diminish 'super-save-mode
  :init
  (setq auto-save-default nil
        super-save-auto-save-when-idle t)
  :config
  (super-save-mode t))

(provide 'core-save)
