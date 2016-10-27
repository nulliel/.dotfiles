(use-package flycheck
  :ensure t
  :init
  (setq flycheck-idle-change-delay 0.5
        flycheck-highlighting-mode 'symbols
        flycheck-check-syntax-automatically '(save idle-change mode-enabled))
  :config
  (use-package flycheck-color-mode-line
    :ensure t
    :config
    (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
  (use-package flycheck-pos-tip
    :ensure t
    :config
    (flycheck-pos-tip-mode t))
  (global-flycheck-mode t))

(use-package flyspell
  :ensure t
  :init
  (setq ispell-program-name "aspell"
        ispell-extra-args '("--sug-mode=ultra"))
  :config
  (when (executable-find ispell-program-name)
    (add-hook 'text-mode-hook 'flyspell-mode)
    (add-hook 'prog-mode-hook 'flyspell-mode)))

(provide 'core-flycheck)
