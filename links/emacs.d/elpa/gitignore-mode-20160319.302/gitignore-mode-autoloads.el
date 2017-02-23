;;; gitignore-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "gitignore-mode" "../../../../../.emacs.d/elpa/gitignore-mode-20160319.302/gitignore-mode.el"
;;;;;;  "c86b9f5c5a39d4c6e9aef7689fedf19d")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/gitignore-mode-20160319.302/gitignore-mode.el

(autoload 'gitignore-mode "gitignore-mode" "\
A major mode for editing .gitignore files.

\(fn)" t nil)

(dolist (pattern (list "/\\.gitignore\\'" "/info/exclude\\'" "/git/ignore\\'")) (add-to-list 'auto-mode-alist (cons pattern 'gitignore-mode)))

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/gitignore-mode-20160319.302/gitignore-mode-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/gitignore-mode-20160319.302/gitignore-mode.el")
;;;;;;  (22647 41256 250939 983000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; gitignore-mode-autoloads.el ends here
