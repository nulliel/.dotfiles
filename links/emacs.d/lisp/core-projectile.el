;(use-package perspective
;  :ensure t
;  :config
;  (persp-mode +1))

(use-package projectile
  :ensure t
;  :after perspective
  :init
  (setq projectile-cache-file (concat emacs-save-dir "/projectile.cache")
        projectile-known-projects-file (concat emacs-save-dir "/projectile.projects")
        projectile-indexing-method 'alien)
  (setq-default projectile-mode-line '(:eval
                                       (if (file-remote-p default-directory)
                                           " Pr"
                                         (format " Pr[%s]" (projectile-project-name)))))
  :config
;  (use-package persp-projectile
;    :ensure t)

  (defun projectile-test-suffix (type)
    (cond
     ((member type '(js)) ".spec")))

  (global-set-key (kbd "C-c C-t") 'projectile-find-implementation-or-test-other-window)

  (projectile-register-project-type 'js '("package.json") nil "npm test")


  (projectile-global-mode t))


(use-package counsel-projectile
  :ensure t
  :after projectile
  :config
  (global-set-key (kbd "C-x C-p") 'counsel-projectile)
  (global-set-key (kbd "C-x C-f") (lambda ()
                                    (interactive)
                                    (if (projectile-project-name)
                                        (projectile-find-file)
                                      (ivy-find)))))

(provide 'core-projectile)
