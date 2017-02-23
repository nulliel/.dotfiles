(use-package doom-themes
  :ensure t
  :diminish doom-buffer-mode
  :init
  (setq doom-enable-bold t
        doom-enable-italic t)
  :config
  ;;--------------------------------------------------
  ;; Load the theme
  ;;--------------------------------------------------
  (load-theme 'doom-molokai t)

  ;;--------------------------------------------------
  ;; Extend the theme
  ;;--------------------------------------------------
  (face-spec-set 'doom-hl-line
                 `((((type graphic)) :background "#1F1F1F")
                   (t                :inherit hl-line)))

  (let ((c '((class color) (min-colors 89)))
        (r "#FF6E64")
        (y "#DEB542")
        (b "#69B7F0")
        (g "#EFEFEF")
        (grey1 "#525254")
        (grey2 "#39393D"))
    (custom-theme-set-faces
     'doom-molokai
     `(powerline-active1
       ((,c (:foreground "#FD971F" :background ,grey1 :weight bold))))
     `(powerline-active2
       ((,c (:foreground "#FD971F" :background ,grey2 :weight bold))))
     `(flycheck-fringe-error
       ((,c (:foreground ,g :background ,r :weight bold))))
     `(flycheck-fringe-warning
       ((,c (:foreground ,g :background ,y :weight bold))))
     `(flycheck-fringe-info
       ((,c (:foreground ,g :background ,b :weight bold))))))

  (add-hook 'find-file-hook 'doom-buffer-mode)
  (add-hook 'minibuffer-setup-hook 'doom-brighten-minibuffer))

(provide 'core-themes)
