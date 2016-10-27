;;; core.el --- Core configuration
;;
;; Copyright (c) 2016 Stephen Ribich
;;
;; Author: Stephen Ribich <stephen.ribich@gmail.com>
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;; License:
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

;; Prevent GC on Startup
(setq-default gc-cons-threshhold 339430400
              gc-cons-percentage 0.6)

(add-hook 'after-init-hook '(lambda () (setq gc-cons-threshhold 4388608)))

;; Directories
(defconst emacs-root-dir (expand-file-name user-emacs-directory))
(defconst emacs-lisp-dir (expand-file-name "lisp" user-emacs-directory))
(defconst emacs-mode-dir (expand-file-name "mode" user-emacs-directory))
(defconst emacs-data-dir (expand-file-name "data" user-emacs-directory))
(defconst emacs-site-dir (expand-file-name "site" user-emacs-directory))
(defconst emacs-save-dir (expand-file-name "save" user-emacs-directory))

(unless (file-exists-p emacs-data-dir) (make-directory emacs-data-dir))
(unless (file-exists-p emacs-site-dir) (make-directory emacs-site-dir))
(unless (file-exists-p emacs-save-dir) (make-directory emacs-save-dir))

;; Load Path
(defun add-to-load-path (parent)
  "Add subfolders of `PARENT' to `load-path'."
  (add-to-list 'load-path parent)
  (dolist (file (directory-files parent))
    (let ((name (expand-file-name file parent)))
      (when (and (file-directory-p name)
                 (not (string-prefix-p "." file)))
        (add-to-list 'load-path name)
        (add-to-load-path name)))))

(add-to-load-path emacs-lisp-dir)
(add-to-load-path emacs-mode-dir)
(add-to-load-path emacs-site-dir)

;; Move custom configuration
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(unless (file-exists-p custom-file)
  (with-temp-buffer (write-file custom-file)))

(load custom-file)

;; Use UTF-8
(set-charset-priority 'unicode)
(setq locale-coding-system   'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system        'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Settings
(setq backup-directory-alist `((".*" . ,emacs-save-dir))
      auto-save-list-file-prefix emacs-save-dir
      auto-save-file-name-transforms `((".*" ,emacs-save-dir t)))

;; Package settings
(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; Default packages
(use-package dash :ensure t)
(use-package diminish :ensure t)

(use-package smex
  :ensure t
  :commands (smex smex-major-mode-commands)
  :config
  (setq smex-completion-method 'ivy
        smex-save-file (concat emacs-save-dir "/smex-items"))
  (smex-initialize))

(provide 'core)
;;; core.el ends here
