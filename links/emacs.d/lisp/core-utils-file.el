;;--------------------------------------------------
;; File reading and writing
;;--------------------------------------------------
(defun read-file-contents (file)
  "Read the content of a file into a string."
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)))

(defun write-file-contents (file content)
  "Write the content of a string into a file."
  (with-temp-buffer
    (insert content)
    (when (file-writable-p file)
      (write-region (point-min) (point-max) file))))

(provide 'core-utils-file)
