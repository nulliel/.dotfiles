(require 'cl-lib)

;;--------------------------------------------------
;; Version Check
;;--------------------------------------------------
(when (< emacs-major-version 24)
  (error "This configuration requires Emacs 24 or higher"))

;;--------------------------------------------------
;; Prevent garbage collection during startup
;;--------------------------------------------------
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          '(lambda () (setq gc-cons-threshold 800000)))

;;--------------------------------------------------
;; Folder Structure
;;--------------------------------------------------
(defconst emacs-root-dir (expand-file-name user-emacs-directory))
(defconst emacs-data-dir (expand-file-name "data" emacs-root-dir))
(defconst emacs-lisp-dir (expand-file-name "lisp" emacs-root-dir))
(defconst emacs-mode-dir (expand-file-name "mode" emacs-root-dir))
(defconst emacs-save-dir (expand-file-name "save" emacs-root-dir))
(defconst emacs-site-dir (expand-file-name "site" emacs-root-dir))

(unless (file-exists-p emacs-data-dir) (make-directory emacs-data-dir))
(unless (file-exists-p emacs-save-dir) (make-directory emacs-save-dir))
(unless (file-exists-p emacs-site-dir) (make-directory emacs-site-dir))

;; Add necessary folders to the load-path.
(cl-labels ((add-to-load-path (parent)
                              "Add subfolders of `PARENT' to `load-path'."
                              (add-to-list 'load-path parent)
                              (dolist (file (directory-files parent))
                                (let ((name (expand-file-name file parent)))
                                  (when (and (file-directory-p name)
                                             (not (string-prefix-p "." file)))
                                    (add-to-list 'load-path name)
                                    (add-to-load-path name))))))
  (add-to-load-path emacs-lisp-dir)
  (add-to-load-path emacs-lisp-dir)
  (add-to-load-path emacs-mode-dir)
  (add-to-load-path emacs-site-dir))

;; Move custom configuration settings outside init.el
(and (setq custom-file (expand-file-name "custom.el" emacs-data-dir))
     (unless (file-exists-p custom-file)
       (with-temp-buffer (write-file custom-file)))
     (load custom-file))

(provide 'core)
