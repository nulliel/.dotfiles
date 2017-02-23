(use-package ivy
  :ensure t
  :diminish ivy-mode
  :bind (("C-s" . swiper)
         ("M-x" . counsel-M-x)
         ("C-x f" . counsel-find-file)
         ("C-c k" . counsel-ag))
  :init
  (setq-default ivy-use-virtual-buffers t
                ivy-count-format ""
                ivy-height 15
                ivy-wrap t
                ivy-do-completion-in-region nil
                projectile-completion-system 'ivy
                counsel-mode-override-describe-bindings t
                ivy-initial-inputs-alist '((counsel-M-x . "^")
                                           (man . "^")
                                           (woman . "^")))
  :config
  (require 'ivy)
  (require 'counsel)
  (require 'swiper)

  (advice-add 'ivy-done :after 'redraw-display)

  (ido-ubiquitous-mode -1)
  (ido-mode -1)
  (ivy-mode t))

(provide 'core-ivy)
