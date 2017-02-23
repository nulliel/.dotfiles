;;--------------------------------------------------
;; Pull missing shell variables into Emacs
;;--------------------------------------------------
(use-package exec-path-from-shell
  :ensure t
  :config
  (dolist (var '())
    (add-to-list 'exec-path-from-shell-variables var))

  (when (memq window-system '(mac x))
    (exec-path-from-shell-initialize)))

(provide 'core-path)
