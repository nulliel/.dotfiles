(use-package js2-mode
  :ensure t
  :mode "\\.js$"
  :interpreter "node"
  :bind (:map js2-mode-map
              ("C-c C-t" . nil))
  :config
  (setq js2-basic-offset 2
        js2-bounce-indent-p nil
        js2-mode-show-parse-errors nil
        js2-mode-show-strict-warnings nil)

  (add-hook 'js2-mode-hook '(lambda ()
                              (define-key js2-mode-map (kbd "C-;") '(lambda ()
                                                                      (interactive)
                                                                      (end-of-line)
                                                                      (when (not (looking-back ";"))
                                                                        (insert ";")))))))

(use-package tern
  :ensure t
  :config
  (setq tern-command (append tern-command '("--no-port-file")))
  (define-key tern-mode-keymap (kbd "TAB") nil)
  (add-hook 'js2-mode-hook 'tern-mode)
  :after js2-mode)

(use-package company-tern
  :ensure t
  :after tern)

(use-package js-doc
  :ensure t
  :config
  (add-hook 'js2-mode-hook
            #'(lambda ()
                (define-key js2-mode-map (kbd "C-c i") 'js-doc-insert-function-doc)
                (define-key js2-mode-map (kbd "@")'js-doc-insert-tag))))

(provide 'mode-js)
