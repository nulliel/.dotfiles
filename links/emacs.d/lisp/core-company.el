(use-package company
  :ensure t
  :diminish company-mode
  :init
  (setq company-idle-delay nil
        company-minimum-prefix-length 2
        company-tooltip-limit 10
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case nil
        company-dabbrev-code-other-buffers t
        company-tooltop-align-annotations t
        company-require-match 'never
        company-global-modes '(not eshell-mode comint-mode erc-mode message-mode help-mode)
        company-backends '(company-capf company-yasnippet)
        company-quickhelp-delay nil)
  :config
  (require 'company-capf)
  (require 'company-yasnippet)
  (use-package company-quickhelp
    :ensure t
    :config
    (company-quickhelp-mode t))
  (global-company-mode t))

(provide 'core-company)
