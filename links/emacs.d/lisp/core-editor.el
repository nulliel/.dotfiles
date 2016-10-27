;; Replace yes/no with y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Smooth scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; Suppress gui features
(setq use-file-dialog nil
      use-dialog-box nil
      ring-bell-function 'ignore)

;; Auto revert mode
(global-auto-revert-mode 1)

;; Electric pairing
(when (fboundp 'electric-pair-mode)
  (electric-pair-mode t)
  (electric-indent-mode t))

;; Preserve tab spacing, bur prevent tabs
(setq-default indent-tabs-mode nil
              tab-width 8)

;; Indentation
(setq tab-always-indent 'complete)
(global-set-key (kbd "RET") 'newline-and-indent)

;; Smart newline
(defun newline-without-break-line ()
  "Move to end of line and insert new line."
  (interactive)
  (end-of-line)
  (newline-and-indent))

(global-set-key (kbd "C-<return>") 'newline-without-break-line)

;; Remove old buffers
(require 'midnight)

;; Disable mouse
(use-package disable-mouse
  :ensure t
  :diminish global-disable-mouse-mode
  :config
  (global-disable-mouse-mode))

;; Save point
(require 'saveplace)
(setq-default save-place-file (concat emacs-save-dir "/saveplace")
              save-place t)
(save-place-mode t)

;; Save history
(require 'savehist)
(setq savehist-file (concat emacs-save-dir "/savehist")
      savehist-save-minibuffer-history t
      savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
(savehist-mode t)

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

(provide 'core-editor)
