;; Syntax highlighting
(setq org-src-fontify-natively t)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode))

(provide 'mode-org)
