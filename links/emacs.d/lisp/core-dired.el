;; Set a window for persistent dired usage
(defvar dired-frame-window nil)
(defvar dired-last-file nil)

(defun select-dired-window ()
  (interactive)
  (dired "~")
  (set-window-dedication t)
  (print "Enabling Dired following")
  (dired-omit-mode t)
  (setq dired-frame-window (get-buffer-window)))

(defun remove-dired-window()
  (interactive)
  (set-window-dedication nil)
  (print "Disabling Dired following")
  (dired-omit-mode nil)
  (setq dired-frame-window nil))

(defun toggle-dired-window ()
  (interactive)
  (if dired-frame-window
      (remove-dired-window)
    (select-dired-window)))

(global-set-key (kbd "<Scroll_Lock>") 'toggle-dired-window)

;; Kill dired buffers
(defun kill-dired-buffers ()
  "Kills all dired buffers"
  (interactive)
  (setq dired-is-killing t)
  (mapc (lambda (buffer)
          (when (eq 'dired-mode (buffer-local-value 'major-mode buffer))
            (kill-buffer buffer)))
        (buffer-list)))

;; Dired follow active buffer
(defun dired-update-buffer ()
    "Update the dired buffer to match the current window"
    (interactive)
    (when (and dired-frame-window
               (not (active-minibuffer-window)))
      (let* ((file (buffer-file-name))
             (buffer (current-buffer))
             (window (get-buffer-window buffer)))
        (when (and file
                   window
                   (not (string= file dired-last-file))
                   (not (eq 'dired-mode (buffer-local-value 'major-mode (current-buffer)))))
          (setq dired-last-file file)
          (select-window dired-frame-window)
          (set-window-dedication nil)
          (dired (file-name-directory file))
          (revert-buffer)
          (sb/redraw-window)
          (set-window-dedication t)
          (select-window window)))))

(add-hook 'buffer-list-update-hook 'dired-update-buffer)

;; Dired+
(use-package dired+
  :ensure t
  :init
  (setq-default diredp-hide-details-initially-flag t
                diredp-toggle-find-file-reuse-dir t
                dired-dwin-target t)
  :config
  (use-package dired-x
    :config
    (progn
      (setq dired-omit-verbose nil)
      ;; Toggle `dired-omit-mode' with C-x M-o
      (add-hook 'dired-mode-hook #'dired-omit-mode)
      (setq dired-omit-files
            (concat dired-omit-files "\\|^.git$\\|^coverage$\\|^.nyc_output$\\|^node_modules$"))))
  (use-package dired-k
    :ensure t
    :config
    (add-hook 'dired-initial-position-hook 'dired-k))
  (use-package dired-sort :ensure t)
  (use-package dired-filter :ensure t)
  (use-package dired-rainbow :ensure t))

;; Stripe buffer
(use-package stripe-buffer
  :ensure t
  :config
  (add-hook 'dired-mode-hook 'stripe-buffer-mode))

(provide 'core-dired)
