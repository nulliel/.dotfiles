;;(package-initialize)

(load (concat user-emacs-directory "lisp/core.el"))

(require 'core-defuns)
(require 'core-binds)
(require 'core-save)

(require 'core-ui)
(require 'core-editor)
(require 'core-writing)

(require 'core-windows)
(require 'core-modeline)
(require 'core-whitespace)

(require 'core-ido)
(require 'core-dired)

(require 'core-company)
(require 'core-flycheck)
(require 'core-yasnippet)
(require 'core-projectile)
(require 'core-vc)
(require 'core-ivy)

(require 'core-code)
(require 'core-automodes)

(require 'mode-js)
(require 'mode-bash)
(require 'mode-org)
