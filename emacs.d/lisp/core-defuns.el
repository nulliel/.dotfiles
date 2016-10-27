(defun delete-this-file ()
  (interactive)
  (or (buffer-file-name) (error "No file is currently being visited"))
  (when (yes-or-no-p (format "Really delete '%s'?" (file-name-nondirectory buffer-file-name)))
    (delete-file (buffer-file-name))
    (kill-this-buffer)))

(defun rename-this-file (new-name)
  (interactive "sRename: ")
  (let ((name (buffer-name))
        (file (buffer-file-name)))
    (unless file
      (error "Buffer '%s' is not visiting a file!" name))
    (progn
      (when (file-exists-p file)
        (rename-file file new-name 1))
      (set-visited-file-name new-name)
      (rename-buffer new-name))))

(defun move-this-file (dir)
  (interactive "DDirectory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn (copy-file filename newname 1)
             (delete-file filename)
             (set-visited-file-name newname)
             (set-buffer-modified-p nil)
             t))))

(defun get-buffer-file-name ()
  (if (buffer-file-name) (file-name-nondirectory (buffer-file-name)) nil))

(defun read-file-contents (file)
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)))

(provide 'core-defuns)
