;;--------------------------------------------------
;; Generic UI Settings
;;--------------------------------------------------

(setq indicate-empty-lines t)

;; Don't show startup screen
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

;; Remove toolbars
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(toggle-frame-fullscreen)



;; Suppress gui features
(setq use-file-dialog nil
      use-dialog-box nil
      ring-bell-function 'ignore)

;; Don't blink the cursor
(blink-cursor-mode -1)

;;--------------------------------------------------
;; Font
;;--------------------------------------------------


;;--------------------------------------------------
;; Highlighting
;;--------------------------------------------------

;; Highlight the current line
(global-hl-line-mode t)

;; Only highlight the current line up to the fill column.
(use-package visual-fill-column
  :ensure t
  :diminish visual-line-mode
  :init
  (setq visual-fill-column-center-text nil
        fill-column 100
        visual-fill-column-width 100
        split-window-preferred-function 'visual-line-mode-split-window-sensibly)
  :config
  (add-hook 'prog-mode-hook 'visual-line-mode)
  (add-hook 'prog-mode-hook 'visual-fill-column-mode))

;; Highlight matching parenthesis
(show-paren-mode t)

;; Change delimiter colors based on their nested depth
(use-package rainbow-delimiters
  :ensure t
  :init
  (setq rainbow-delimiters-max-face-count 3)
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; Flash the current line line after jumping
(use-package beacon
  :ensure t
  :diminish beacon-mode
  :config
  (beacon-mode t))

;; Highlight the current symbol (or word) and add navigation options
(use-package highlight-symbol
  :ensure t
  :diminish highlight-symbol-mode
  :init
  (setq highlight-symbol-delay 0.25)
  :config
  (dolist (hook '(prog-mode-hook html-mode-hook css-mode-hook))
    (add-hook hook 'highlight-symbol-mode)
    (add-hook hook 'highlight-symbol-nav-mode))
  (add-hook 'org-mode-hook 'highlight-symbol-nav-mode))

;; Highlight changed text due caused by undo, yank, yank-pop, etc.
(use-package volatile-highlights
  :ensure t
  :diminish volatile-highlights-mode
  :config
  (volatile-highlights-mode t))

;; Highlight numeric literals
(use-package highlight-numbers
  :ensure t
  :config
  (highlight-numbers-mode t))

;;--------------------------------------------------
;; Formatting
;;--------------------------------------------------

;; Show symbols as their mathematical counterpart
(global-prettify-symbols-mode t)

;; Display line indentation guides
(use-package highlight-indent-guides
  :ensure t
  :init
  (setq highlight-indent-guides-method 'character)
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

(provide 'core-ui)
