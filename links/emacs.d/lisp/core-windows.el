;;--------------------------------------------------
;; Modify window titles
;;--------------------------------------------------
(setq frame-title-format
      '("" invocation-name " - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))

;;--------------------------------------------------
;; C-x o prompts for a window to jump to
;;--------------------------------------------------
(use-package ace-window
  :ensure t
  :init
  (global-set-key (kbd "C-x o") 'ace-window)
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-forwground :height 3.0))))))

;;--------------------------------------------------
;; Prevent window stealing
;;--------------------------------------------------
(defadvice pop-to-buffer (before cancel-other-window first)
  (ad-set-arg 1 nil))

(ad-activate 'pop-to-buffer)

;;--------------------------------------------------
;; Prevent code window creation
;;--------------------------------------------------
(setq pop-up-windows nil)

;;--------------------------------------------------
;; Temporary full window
;;--------------------------------------------------
(add-hook 'emacs-startup-hook 'winner-mode)

(defun sanityinc/toggle-delete-other-window ()
  "Delete other windows in frame if any, or restore previous window config."
  (interactive)
  (if (and winner-mode
           (equal (selected-window) (next-window)))
      (winner-undo)
    (delete-other-windows)))

(global-set-key (kbd "C-x 1") 'sanityinc/toggle-delete-other-window)

(provide 'core-windows)
