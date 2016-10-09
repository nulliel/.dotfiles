;; Folding Mode
(add-hook 'prog-mode-hook 'hs-minor-mode)
(global-set-key (kbd "C-\\") 'hs-toggle-hiding)

(use-package ace-jump-mode
  :ensure t
  :diminish ace-jump-mode
  :bind (("C-c SPC" . ace-jump-mode)))

(use-package expand-region
  :ensure t
  :bind (("C-=" . er/expand-region)))

(use-package multiple-cursors
  :ensure t
  :bind (("C-<" . mc/mark-previous-like-this)
         ("C->" . mc/mark-next-like-this)
         ("C-+" . mc/mark-all-like-this)
         ("C-c c c" . mc/edit-lines)
         ("C-c c a" . mc/edit-beginnings-of-lines)
         ("C-c c e" . mc/edit-ends-of-lines)))

(provide 'core-code)
