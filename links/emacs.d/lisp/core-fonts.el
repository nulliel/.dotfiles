;;--------------------------------------------------
;; Set the default font
;;--------------------------------------------------
(set-face-attribute 'default nil :font "Source Code Pro" :height 70)
(set-frame-font "Source Code Pro" nil t)

;;--------------------------------------------------
;; Font size
;;--------------------------------------------------
(use-package default-text-scale
  :ensure t
  :bind (("C-M-=" . default-text-scale-increase)
         ("C-M--" . default-text-scale-decrease)))

(defun sanityinc/maybe-adjust-visual-fill-column ()
  "Readjust visual fill column when the global font size is modified."
  (if visual-fill-column-mode
      (add-hook 'after-setting-font-hook 'visual-fill-column--adjust-window nil t)
    (remove-hook 'after-setting-font-hook 'visual-fill-column--adjust-window t)))

(add-hook 'visual-fill-column-mode-hook 'sanityinc/maybe-adjust-visual-fill-column)

(provide 'core-fonts)
