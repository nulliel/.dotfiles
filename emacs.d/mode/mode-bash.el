(defun setup-sh-mode ()
  (interactive)
  (setq sh-basic-offset 2
        sh-indentation 2))

(add-hook 'sh-mode-hook 'setup-sh-mode)

(provide 'mode-bash)
