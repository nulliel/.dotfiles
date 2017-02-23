;;--------------------------------------------------
;; Buffer modification
;;--------------------------------------------------
(defun is-visiting-file ()
  "Return whether the current buffer is pointing to a file on the file system."
  (interactive)
  (or (buffer-file-name)
      (error "Buffer '%s' is not visiting a file" (buffer-name))))

(defun get-buffer-file-name ()
  "Return the file name of the current buffer."
  (interactive)
  (if (buffer-file-name)
      (file-name-nondirectory (buffer-file-name))
    nil))

(defun delete-this-file ()
   "Delete the file the current buffer is pointing to and kill the buffer."
   (interactive)
   (when (and (is-visiting-file)
              (y-or-n-p (format "Really delete '%s?" (file-name-nondirectory buffer-file-name))))
     (delete-file (buffer-file-name))
     (kill-this-buffer)))

(defun rename-this-file (name &optional destructive)
  "Rename the file the current buffer is pointing to."
  (interactive "sRename: ")
  (let ((file (buffer-file-name)))
    (when (and (is-visiting-file)
               (file-exists-p file))
      (rename-file file name (if destructive t nil))
      (set-visited-file-name name)
      (rename-buffer name))))

(defun move-this-file (dir)
  "Move the file the current buffer is pointing to."
  (interactive "DDirectory: ")
  (let* ((name (get-buffer-file-name))
         (file (buffer-file-name))
         (dir (if (string-match dir "\\(?:/\\|\\\\)$")
                  (substring dir 0 -1) dir))
         (newfile (concat dir "/" name)))
    (when (and (is-visiting-file)
               (file-exists-p file))
      (copy-file file newfile 1)
      (delete-file file)
      (set-visited-file-name newfile)
      (set-buffer-modified-p nil))))

(provide 'core-utils-buffer)
