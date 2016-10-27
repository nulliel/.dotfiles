;; Unique buffer names
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator " • ")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; Save window configuration
(desktop-save-mode t)

;; Set window dimensions
(defun set-window-height (height)
  "Set window height to HEIGHT."
  (interactive "nHeight: ")
  (enlarge-window (- height (window-height))))

(defun set-window-width (width)
  "Set window width to WIDTH."
  (interactive "nWidth: ")
  (enlarge-window-horizontally (- width (window-width))))

;; Rename windows
(setq frame-title-format
      '("" invocation-name " - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))

;; Dedicated windows
(defadvice pop-to-buffer (before cancel-other-window first)
  (ad-set-arg 1 nil))

(ad-activate 'pop-to-buffer)

;; Toggle window dedication
(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not."
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window
                                 (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
   (current-buffer)))

(defun set-window-dedication (bool)
  "Turn a window state on or off"
  (interactive)
  (set-window-dedicated-p (get-buffer-window (current-buffer)) bool))

;; Press [pause] key in each window you want to "freeze"
(global-set-key [pause] 'toggle-window-dedicated)

;; Ace window
(use-package ace-window
  :ensure t
  :init
  (global-set-key (kbd "C-x o") 'ace-window)
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-forwground :height 3.0))))))

(provide 'core-windows)
