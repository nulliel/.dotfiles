;;--------------------------------------------------
;; Editor Configurations
;;--------------------------------------------------
(setq-default fill-column 100)

;; Smooth scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; Preserve tab spacing, bur prevent tabs
(setq-default indent-tabs-mode nil
              tab-width 8)

(setq tab-always-indent 'complete)

;; Automatically pair delimiters
(when (fboundp 'electric-pair-mode)
  (electric-pair-mode t)
  (electric-indent-mode t))

;; Disable mouse
(use-package disable-mouse
  :ensure t
  :diminish global-disable-mouse-mode
  :config
  (global-disable-mouse-mode))

;;--------------------------------------------------
;; Quality of Life Changes
;;--------------------------------------------------
;; Replace yes/no with y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Automatically indent on newline
(global-set-key (kbd "RET") 'newline-and-indent)

;;--------------------------------------------------
;; Buffer Settings
;;--------------------------------------------------
;; Remove inactive buffers
(require 'midnight)

;; Automatically revert buffers every 5 seconds
(global-auto-revert-mode 1)


;; Recent history
(require 'recentf)
(setq recentf-save-file (concat emacs-save-dir "/recentf")
      recentf-exclude '("/tmp" "/ssh:" "\\.?ido\\.last$" "\\.revive$" "/TAGS$"
                        "emacs\\.d/private/cache/.+" "emacs\\.d/workgroups/.+$"
                        "wg-default" "/company-statistics-cache.el$")
      recentf-max-menu-items 0
      recentf-max-saved-items 250
      recentf-auto-cleanup 600
      recentf-filename-handlers '(abbreviate-file-name))
(recentf-mode 1)

;;--------------------------------------------------
;; UTF8 Everywhere
;;--------------------------------------------------
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)

(setq-default buffer-file-coding-system 'utf-8)

(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(provide 'core-editor)
