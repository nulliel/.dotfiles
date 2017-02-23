;;--------------------------------------------------
;; Desktop
;;--------------------------------------------------
(setq desktop-path (list emacs-save-dir)
      desktop-auto-save-timeout 600)
(desktop-save-mode t)

(setq desktop-globals-to-save
      (append '((comint-input-ring        . 50)
                (compile-history          . 30)
                desktop-missing-file-warning
                (dired-regexp-history     . 20)
                (extended-command-history . 30)
                (face-name-history        . 20)
                (file-name-history        . 100)
                (grep-find-history        . 30)
                (grep-history             . 30)
                (ido-buffer-history       . 100)
                (ido-last-directory-list  . 100)
                (ido-work-directory-list  . 100)
                (ido-work-file-list       . 100)
                (ivy-history              .100)
                (magit-read-rev-history   . 50)
                (minibuffer-history       . 50)
                (org-clock-history        . 50)
                (org-refile-history       . 50)
                (org-tags-history         . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                register-alist
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                tags-table-list)))

;;--------------------------------------------------
;; Desktop hooks
;;--------------------------------------------------
(add-hook 'desktop-after-read-hook
          '(lambda ()
             (let ((tmp desktop-dirname))
               (desktop-remove)
               (setq desktop-dirname tmp))))

;;--------------------------------------------------
;; Desktop hacks
;;--------------------------------------------------
(defun emacs-process-p (pid)
  "If pid is the process ID of an emacs process, return t, else nil."
  (when pid
    (let ((attributes (process-attributes pid)) (cmd))
      (dolist (attr attributes)
        (if (string= "comm" (car attr))
            (setq cmd (cdr attr))))
      (if (and cmd (or (string= "emacs" cmd) (string= "emacs.exe" cmd))) t))))

(defun desktop-advice (fn &rest args)
  (when (not (emacs-process-p ad-return-value))
    (setq ad-return-value nil))
  (apply fn args))

(advice-add 'desktop-owner :around #'desktop-advice)

;;--------------------------------------------------
;; History
;;--------------------------------------------------
;; Save cursor position
(setq-default save-place-file (concat emacs-save-dir "/saveplace")
              save-place t)
(save-place-mode t)

;; Savehistories
(setq savehist-file (concat emacs-save-dir "/savehist")
      savehist-save-minibuffer-history t
      savehist-additional-variables '(kill-ring search-ring regexp-search-ring)
      history-length 1000)
(savehist-mode t)

;; Recentf
(setq recentf-save-file (concat emacs-save-dir "/recentf")
      recentf-exclude '("/tmp" "/ssh:" "\\.?ido\\.last$" "\\.revive$" "/TAGS$"
                        "emacs\\.d/private/cache/.+" "emacs\\.d/workgroups/.+$"
                        "wg-default" "/company-statistics-cache.el$")
      recentf-max-menu-items 0
      recentf-max-saved-items 250
      recentf-auto-cleanup 600
      recentf-filename-handlers '(abbreviate-file-name))

(provide 'core-sessions)
