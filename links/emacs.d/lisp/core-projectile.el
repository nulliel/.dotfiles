(use-package projectile
  :ensure t
  :init
  (setq projectile-cache-file (concat emacs-save-dir "/projectile.cache")
        projectile-known-projects-file (concat emacs-save-dir "/projectile.projects")
        projectile-indexing-method 'alien)
  (setq-default projectile-mode-line '(:eval
                                       (if (file-remote-p default-directory)
                                           " Pr"
                                         (format " Pr[%s]" (projectile-project-name)))))
  :config
  (defun projectile-test-suffix (type)
    (cond
     ((member type '(js)) ".spec")))

  (global-set-key (kbd "C-c C-t") 'projectile-find-implementation-or-test-other-window)

  (projectile-register-project-type 'js '("package.json") nil "npm test")


  (projectile-global-mode t))

(provide 'core-projectile)
