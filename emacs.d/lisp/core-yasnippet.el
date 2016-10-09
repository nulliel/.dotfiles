(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :init
  (setq yas-snippet-dirs (list (concat emacs-data-dir "/snippets")))
  :config
  (use-package autoinsert
    :config
    (auto-insert-mode)
    (setq auto-insert-query nil)
    (define-auto-insert "\.spec.js"
      '(lambda ()
         (interactive)
         (yas-expand-snippet (yas-lookup-snippet "js-test-default")))))
  (yas-reload-all)
  (yas-global-mode t))

(provide 'core-yasnippet)
