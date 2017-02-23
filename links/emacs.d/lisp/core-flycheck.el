(use-package flycheck
  :ensure t
  :init
  (setq flycheck-idle-change-delay 0.5
        flycheck-highlighting-mode 'symbols
        flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-disabled-checkers '(emacs-lisp-checkdoc)
        flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
  :config
  (use-package flycheck-color-mode-line
    :ensure t
    :config
    ;;--------------------------------------------------
    ;; Override face attributes
    ;;--------------------------------------------------
    (face-spec-set 'flycheck-color-mode-line-error-face
                   `((((class color) (min-colors 89))
                      (:foreground "#FFFFFF" :weight bold :inherit flycheck-fringe-error))))

    (face-spec-set 'flycheck-color-mode-line-warning-face
                   `((((class color) (min-colors 89))
                      (:foreground "#FFFFFF" :weight bold :inherit flycheck-fringe-warning))))

    (face-spec-set 'flycheck-color-mode-line-info-face
                   `((((class color) (min-colors 89))
                      (:foreground "#FFFFFF" :weight bold :inherit flycheck-fringe-info))))



    (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
  (use-package flycheck-pos-tip
    :ensure t
    :config
    (flycheck-pos-tip-mode t))
  (global-flycheck-mode t))

(provide 'core-flycheck)
