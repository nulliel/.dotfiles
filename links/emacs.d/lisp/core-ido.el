(use-package flx-ido
  :ensure t
  :init
  (setq ido-enable-flex-matching t
        ido-use-filename-at-point nil
        ido-auto-merge-work-directories-length 0
        ido-use-vertical-buffers t
        ido-use-default-buffer-method 'selected-window
        ido-use-faces nil
        ido-save-directory-list-file (concat emacs-save-dir "/ido.last"))
  :config
  (ido-mode t)
  (ido-everywhere t)
  (flx-ido-mode t))

(use-package ido-ubiquitous
  :ensure t
  :config
  (ido-ubiquitous-mode t))

(provide 'core-ido)
