;; SYSTEM DEPENDENCIES - CMAKE
;; REQUIRES RUNNING irony-build-server
;; REQUIRES CLANG
;; REQUIRES RTAGS
;; irony-install-server

;; REQUIRES CPPLINT.PY
;; https://raw.githubusercontent.com/google/styleguide/gh-pages/cpplint/cpplint.py



(progn
  (require 'rtags)
  (require 'company-rtags)
  (require 'flycheck-rtags)

  ;; rtags settings
  (setq rtags-completions-enabled t)
  (setq rtags-autostart-diagnostics t)

  ;; rtags configuration
  (rtags-enable-standard-keybindings)

  ;; rtags company configuration
  (eval-after-load 'company '(add-to-list 'company-backends 'company-rtags))

  (add-hook 'c-mode-common-hook #'(lambda ()
                                    (flycheck-select-checker 'rtags)
                                    (setq-local flycheck-highlighting-mode nil)))
                                    ;(setq-local flycheck-check-syntax-automatically nil)))
  )

(use-package irony
  :ensure t
  :config
  (add-hook 'c-mode-cook    'irony-mode)
  (add-hook 'c++-mode-hook  'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)

  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  (add-hook 'irony-mode-hook '(lambda ()
                                (define-key irony-mode-map [remap completion-at-point]
                                  'irony-completion-at-point-async)
                                (define-key irony-mode-map [remap complete-symbol]
                                  'irony-completion-at-point-async)))

  (use-package company-irony
    :ensure t
    :after company
    :config
    (use-package company-irony-c-headers
      :ensure t
      :config
      (add-to-list 'company-backends '(company-irony-c-headers company-irony)))))

;  (use-package flycheck-irony
;    :ensure t
;    :after flycheck
;    :config
;    (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

(use-package cmake-ide
  :ensure t
  :after irony
  :after rtags
  :config
  (cmake-ide-setup))






(use-package disaster
  :ensure t
  :config
  (add-hook 'c-mode-common-hook '(lambda ()
                                   (define-key c-mode-map (kbd "C-c d") 'disaster)))
  (add-hook 'c-mode-common-hook '(lambda ()
                                   (define-key c++-mode-map (kbd "C-c d") 'disaster))))

(use-package google-c-style
  :ensure t)
;  :config
;  (defconst google-c-style
;      (append
;       (butlast google-c-style 1)
;       `((c-style-alist . ,(append
;                            (butlast (cdr (car (last google-c-style))) 1)
;                            '((innamespace . 0)))))))

  (use-package flycheck-google-cpplint
    :ensure t
    :after  flycheck
    :init
    (setq flycheck-googlelint-verbose "0"
          flycheck-googlelint-linelength "100"
          flycheck-googlelint-filter "-build/c++11")
    :config
    (flycheck-add-next-checker 'rtags
;                               'irony)
;    (flycheck-add-next-checker 'irony
                               'c/c++-clang)
    (flycheck-add-next-checker 'c/c++-cppcheck
                               '(warning . c/c++-googlelint)))

(use-package function-args
  :ensure t
  :config
  (fa-config-default))

(use-package modern-cpp-font-lock
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'modern-c++-font-lock-mode))

(add-hook 'c++-mode-hook
          '(lambda ()
             (define-key c++-mode-map (kbd "C-c C-t") 'projectile-find-other-file-other-window)
             (add-to-list 'projectile-other-file-alist '("cc" "h"))
             (add-to-list 'projectile-other-file-alist '("h" "cc"))
             (setq c-backslash-max-column 100)
             (setq c-backslash-column 99)
             (setq flycheck-disabled-checkers '(c/c++-gcc))
             (setq flycheck-clang-language-standard "c++14")
             (setq irony--compile-options '("-std=c++14"))))

(add-hook 'c-mode-common-hook 'google-set-c-style)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(setq flycheck-clang-include-path
      '("/home/sribich/Programming/projects/clustard/node_modules/nan/"
        "/home/sribich/.nvm/versions/node/v7.3.0/include/node/"))
(setq flycheck-clang-language-standard "c++14")

(defun flycheck-fold-include-levels (errors sentinel-message)
  (unless (or (stringp sentinel-message) (functionp sentinel-message))
    (error "Sentinel must be string or function: %S" sentinel-message))
  (let ((sentinel (if (functionp sentinel-message)
                      sentinel-message
                    (lambda (err)
                      (string-match-p sentinel-message
                                      (flycheck-error-message err)))))
        (remaining-errors errors))))


(use-package cmake-mode
  :ensure t)

;(define-key c-mode-map [(tab)] 'company-complete)
;(define-key c++-mode-map [(tab)] 'company-complete)
;(define-key c++-mode-map [(tab)] 'indent-according-to-mode)

(provide 'mode-c)
