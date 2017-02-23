;;; gitconfig-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "gitconfig-mode" "../../../../../.emacs.d/elpa/gitconfig-mode-20160710.1913/gitconfig-mode.el"
;;;;;;  "577e851003f030e624c33f1047a8f8ba")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/gitconfig-mode-20160710.1913/gitconfig-mode.el

(autoload 'gitconfig-mode "gitconfig-mode" "\
A major mode for editing .gitconfig files.

\(fn)" t nil)

(dolist (pattern '("/\\.gitconfig\\'" "/\\.git/config\\'" "/modules/.*/config\\'" "/git/config\\'" "/\\.gitmodules\\'" "/etc/gitconfig\\'")) (add-to-list 'auto-mode-alist (cons pattern 'gitconfig-mode)))

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/gitconfig-mode-20160710.1913/gitconfig-mode-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/gitconfig-mode-20160710.1913/gitconfig-mode.el")
;;;;;;  (22647 41256 56942 12000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; gitconfig-mode-autoloads.el ends here
