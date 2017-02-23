(require 'dired)
(require 'dired-x)

(use-package dired+
  :ensure t
  :after dired
  :init
  (setq-default diredp-hide-details-initially-flag t
                diredp-toggle-find-file-reuse-dir t
                dired-dwin-target t))

(use-package dired-k
  :ensure t
  :after dired
  :config
  (require 'dired-k)
  (add-hook 'dired-initial-position-hook 'dired-k))

(use-package dired-sort
  :ensure t
  :after dired)

(use-package dired-filter
  :ensure t
  :after dired)

(use-package dired-rainbow
  :ensure t
  :after dired)

(use-package stripe-buffer
  :ensure t
  :after dired
  :config
  (add-hook 'dired-mode-hook 'stripe-buffer-mode))

(with-eval-after-load "dired-x"
  (setq dired-omit-verbose nil)
  (add-hook 'dired-mode-hook #'dired-omit-mode)
  (setq dired-omit-files
        (concat dired-omit-files "\\|^.git$\\|^coverage$\\|^.nyc_output$\\|^node_modules$")))

;;--------------------------------------------------
;; Persistent Dired Window
;;--------------------------------------------------
(defvar dired-persistent-window nil)
(defvar dired-last-file nil)

(defun create-dired-persistent-window ()
  "Create a persistent dired window in the current buffer that follows any active buffer. If a dired buffer already exists, kill it instead."
  (interactive)
  (if dired-persistent-window
      (disable-dired-persistent-window)
    (enable-dired-persistent-window)))

(defun enable-dired-persistent-window ()
  "Create the persistent dired window."
  (interactive)
  (dired "~")
  (set-window-dedication t)
  (setq dired-persistent-window (get-buffer-window))
  (print "Enabled dired following"))

(defun disable-dired-persistent-window ()
  "Destroy the persistent dired window."
  (interactive)
  (set-window-dedication nil)
  (setq dired-persistent-window nil)
  (print "Disabled dired following"))

(defun dired-update-buffer ()
  "Update the dired buffer to follow the the current window"
  (interactive)
  (when (and dired-persistent-window
             (not (active-minibuffer-window)))
    (let* ((file (buffer-file-name))
           (buffer (current-buffer))
           (window (get-buffer-window buffer)))
      (when (and file
                 window
                 (not (string= file dired-last-file))
                 (not (eq 'dired-mode (buffer-local-value 'major-mode (current-buffer)))))
        (setq dired-last-file file)
        (select-window dired-persistent-window)
        (set-window-dedication nil)
        (dired (file-name-directory file))
        (revert-buffer)
        (sb/redraw-window)
        (set-window-dedication t)
        (select-window window)))))

(add-hook 'buffer-list-update-hook #'dired-update-buffer)

;;--------------------------------------------------
;; Remove all dired buffers every day
;;--------------------------------------------------
(defun kill-buffer-wrap (fn &rest args)
  (if (not (is-window-dedicated))
      (apply fn args)
    (message "Cannot kill a strongly dedicated buffer")))

(advice-add 'kill-buffer :around #'kill-buffer-wrap)

(defun kill-dired-buffers ()
  "Kills all dired buffers"
  (interactive)
  (mapc #'(lambda (buffer)
          (when (eq 'dired-mode (buffer-local-value 'major-mode buffer))
            (kill-buffer buffer)))
        (buffer-list)))

(run-at-time "00:00" 86400 #'kill-dired-buffers)

(provide 'core-dired)
