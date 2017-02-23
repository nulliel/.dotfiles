;;--------------------------------------------------
;; Ease of use window dedication functions
;;--------------------------------------------------
(defun is-window-dedicated ()
  "Check whether the current window is dedicated."
  (interactive)
  (window-dedicated-p (get-buffer-window (current-buffer))))

(defun toggle-window-dedication ()
  "Toggle the current buffer between dedication."
  (interactive)
  (let* ((window (get-buffer-window (current-buffer)))
         (nstate (not (window-dedicated-p window))))
    (set-window-dedicated-p window nstate)
    (if nstate
        (message "Window is dedicated")
      (message "Window is no longer dedicated"))))

(defun set-window-dedication (bool)
  "Turn window dedication on or off"
  (interactive)
  (set-window-dedicated-p (get-buffer-window (current-buffer)) bool))

;;--------------------------------------------------
;; Change window dimensions
;;--------------------------------------------------
(defun set-window-height (height)
  "Set window height to `height'."
  (interactive "nHeight: ")
  (enlarge-window (- height (window-height))))

(defun set-window-width (width)
  "Set window width to `width'."
  (interactive "nWidth: ")
  (enlarge-window-horizontally (- width (window-width))))

(provide 'core-utils-window)
