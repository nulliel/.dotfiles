;;--------------------------------------------------
;; Package Update Configs
;;--------------------------------------------------
(defvar package-update-frequency 7)
(defvar package-update-file (expand-file-name "last-update" emacs-save-dir))

;;--------------------------------------------------
;; Package Update Mode
;;--------------------------------------------------
(define-derived-mode package-update-mode tabulated-list-mode "Update Menu"
  "Major mode for updating local packages."
  (define-key package-update-mode-map "u" 'package-update-mark)
  (define-key package-update-mode-map "U" 'package-update-unmark)
  (define-key package-update-mode-map "x" 'package-update-execute)

  (setq tabulated-list-format
        `[("Package" 18 t)
          ("Version" 13 nil)
          ("New Version" 13 nil)
          ("Description" 0 nil)])
  (setq tabulated-list-padding 2)
  (setq tabulated-list-sort-key (cons "Package" nil))
  (tabulated-list-init-header))

(defun package-update-mark ()
  "Mark a package for updating."
  (interactive)
  (when (derived-mode-p 'package-update-mode)
    (tabulated-list-put-tag "U" t)))

(defun package-update-unmark ()
  "Unmark a package for updating."
  (interactive)
  (when (derived-mode-p 'package-update-mode)
    (tabulated-list-put-tag " " t)))

(defun package-update-execute ()
  "Update marked packages"
  (interactive)
  (when (derived-mode-p 'package-update-mode)
    (let (update-list cmd desc)
      (save-excursion
        (goto-char (point-min))
        (while (not (eobp))
          (setq cmd (char-after))
          (unless (eq cmd ?\s)
            (setq desc (tabulated-list-get-id))
            (when (eq cmd ?U)
              (add-to-list 'update-list desc)))
          (forward-line)))
      (package-update--update update-list))))

(defun package-update--update (update-alist)
  "Update the selected packages."
  (interactive)
  (dolist (package update-alist)
    (let* ((pkg (car package))
           (name (symbol-name (package-desc-name pkg)))
           (old (car (cddr package))))
      (condition-case ex
          (progn
            (package-install pkg)
            (delete-directory old t))
        (error (print (format "Error installing %s" name))))))
  (kill-buffer))

(defun update-menu--populate (update-alist)
  "Populate the Update Menu."
  (interactive)
  (setq tabulated-list-entries nil)
  (dolist (package update-alist)
    (let* ((new-vers (package-desc-version (car package)))
           (new-name (symbol-name (package-desc-name (car package))))
           (new-desc (package-desc-summary (car package)))
           (old-vers (cadr package))
           (new-vers-string (concat (number-to-string (car new-vers))
                                    "."
                                    (number-to-string (cadr new-vers))))
           (old-vers-string (concat (number-to-string (car old-vers))
                                    "."
                                    (number-to-string (cadr old-vers)))))
      (tabulated-list-init-header)
      (add-to-list 'tabulated-list-entries (list package
                                                 `[,new-name
                                                   ,old-vers-string
                                                   ,new-vers-string
                                                   ,new-desc]))))
  (tabulated-list-print t))

;;--------------------------------------------------
;; Package Updating
;;--------------------------------------------------
(defun should-update-packages ()
  "Determine whether packages should be updated based on the time since the last update."
  (unless (file-exists-p package-update-file)
    (write-file-contents package-update-file "0"))

  (let* ((last-update (string-to-number (read-file-contents package-update-file)))
         (days-since  (- (time-to-days (current-time)) last-update)))
    (if (and (>= days-since package-update-frequency)
             (y-or-n-p "Packages can be updated. Update?"))
        t
      nil)))

(defun get-updated-packages ()
  "Create a list of updated packages."
  (interactive)
  (let ((update-alist (list)))
    (dolist (package package-activated-list)
      (when (package-installed-p package)
        (let* ((new-desc (cadr (assq package package-archive-contents)))
               (old-desc (cadr (or (assq package package-alist)
                                   (assq package package--builtins))))
               (new-vers (when new-desc (package-desc-version new-desc)))
               (old-vers (package-desc-version old-desc))
               (old-path (package-desc-dir old-desc)))
          (when (and new-vers
                     (> (time-to-days new-vers) (time-to-days old-vers)))
            (add-to-list 'update-alist (list new-desc old-vers old-path))))))
    update-alist))

(defun create-update-buffer (update-alist)
  "Create a buffer in `package-update-mode' to update packages."
  (interactive)
  (let ((buf (get-buffer-create "*Update Packages*")))
    (with-current-buffer buf
      (package-update-mode)
      (update-menu--populate update-alist)
      (switch-to-buffer buf))))

;; Display in a disposable frame
(fullframe create-update-buffer quit-window)

(defun maybe-update-packages ()
  "Check whether packages should be updated. Update if necessary."
  (interactive)
  (when (should-update-packages)
    (package-refresh-contents)
    (let ((update-alist (get-updated-packages)))
      (create-update-buffer update-alist))
    (write-file-contents package-update-file (int-to-string (time-to-days (current-time))))))


(add-hook 'emacs-startup-hook 'maybe-update-packages)

(provide 'core-update)
