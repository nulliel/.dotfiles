;; Don't show startup screen
(setq inhibit-startup-screen t)

;; Remove toolbars
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Don't blink the cursor
(blink-cursor-mode -1)

;; Font
(set-face-attribute 'default nil :font "Source Code Pro" :height 70)
(set-frame-font "Source Code Pro" nil t)

;; Theme
(require 'doom-theme)
(load-theme 'doom-dark t)

;; Highlight line
(global-hl-line-mode t)

;; Show symbols are their mathematical counterpart
(global-prettify-symbols-mode t)

;; Show parenthesis
(show-paren-mode t)

;; Flash line after jumping
(use-package beacon
  :ensure t
  :diminish beacon-mode
  :config
  (beacon-mode t))

;; Show key bindings
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode t))

;; Indentation
(use-package highlight-indent-guides
  :ensure t
  :init
  (setq highlight-indent-guides-method 'character)
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

;; Highlight symbols
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

;; Highlight yanked text
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

;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :init
  (setq rainbow-delimiters-max-face-count 3)
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; Fill Column
(use-package visual-fill-column
  :ensure t
  :init
  (setq visual-fill-column-center-text nil
        fill-column 100
        visual-fill-column-width fill-column
        split-window-preferred-function 'visual-line-mode-split-window-sensibly)
  :config
  (add-hook 'prog-mode-hook 'visual-line-mode)
  (add-hook 'prog-mode-hook 'visual-fill-column-mode))

(provide 'core-ui)
