(use-package ivy
  :ensure t
  :init
  (setq projectile-completion-system 'ivy
        ivy-height 15
        ivy-do-completion-in-region nil
        ivy-wrap t)
  :config
  (require 'ivy)
  (require 'counsel)
  (require 'swiper)

;  (eval-after-load 'magit
;    (setq magit-completing-read-function 'ivy-completing-read))

  (ivy-mode t)
  (diminish 'ivy-mode)

  (advice-add 'ivy-done :after 'redraw-display)
  :bind (("C-s" . swiper)
         ("M-x" . counsel-M-x)
         ("C-x f" . counsel-find-file)
         ("C-c k" . counsel-ag)))

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



(provide 'core-ivy)
