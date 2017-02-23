(require 'package)

;;--------------------------------------------------
;; Package Initialization
;;--------------------------------------------------
(setq package-enable-at-startup nil
      package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("melpa"        . "https://melpa.org/packages/")
                         ("org"          . "http://orgmode.org/elpa/")))

(package-initialize)

;;--------------------------------------------------
;; Default Packages
;;--------------------------------------------------
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(use-package fullframe
  :ensure t)

(use-package diminish
  :ensure t)

(provide 'core-packages)
