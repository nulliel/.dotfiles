(require 'ibuffer)
(require 'vc-hooks)

(use-package ibuffer-vc
  :ensure t
  :after ibuffer
  :config
  (require 'ibuffer-vc)
  (add-hook 'ibuffer-hook #'ibuffer-vc-set-filter-groups-by-vc-root))

;;--------------------------------------------------
;; Settings for ibuffer
;;--------------------------------------------------
(setq-default ibuffer-show-empty-filter-groups nil)
(setq ibuffer-filter-group-name-face 'font-lock-doc-face)

(with-eval-after-load 'ibuffer
  (fullframe ibuffer ibuffer-quit)
  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (cond
     ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
     ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
     ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
     (t (format "%8d" (buffer-size))))))

(global-set-key (kbd "C-x C-b") 'ibuffer)

;;--------------------------------------------------
;; Modify ibuffer fontification
;;--------------------------------------------------
(defvar ibuffer-current-font nil)
(setq ibuffer-fontification-alist
      '((10 buffer-read-only font-lock-constant-face)
        (15 (and buffer-file-name
                 (string-match ibuffer-compressed-file-name-regexp buffer-file-name))
            font-lock-constant-face)
        (20 (string-match "^*" (buffer-name)) font-lock-constant-face)
        (25 (and (string-match "^ " (buffer-name))
                 (null buffer-file-name))
            italic)
        (30 (memq major-mode ibuffer-help-buffer-modes) font-lock-comment-face)
        (35 (derived-mode-p (quote dired-mode)) font-lock-function-name-face)
        (80 (and (buffer-file-name)
                 (string= (vc-state buffer-file-name) "up-to-date")) dired-k-committed)
        (81 (and (buffer-file-name)
                 (string= (vc-state buffer-file-name) "edited")) dired-k-added)
        (82 (and (buffer-file-name)
                 (string= (vc-state buffer-file-name) "added")) dired-k-ignored)
        (83 (and (buffer-file-name)
                 (string= (vc-state buffer-file-name) "removed")) dired-k-modified)
        (84 (and (buffer-file-name)
                 (string= (vc-state buffer-file-name) "ignored")) diredp-file-name)
        (85 (and (buffer-file-name)
                 (string= (vc-state buffer-file-name) "unregistered")) dired-k-untracked)))

;;--------------------------------------------------
;; Modify the default formats
;;--------------------------------------------------
(setq ibuffer-formats
      '((mark modified read-only vc-status-mini " "
              (name 18 18 :left :elide)
              " "
              (size-h 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              (vc-status 16 16 :left)
              " "
              filename-and-process)))

(provide 'core-ibuffer)
