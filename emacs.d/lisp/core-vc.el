;; Diff highlighting
(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode))

;; Magit
(use-package magit
  :ensure t
  :bind (("C-c g" . magit-status)
         ("C-c M-g" .  magit-dispatch-popup))
  :init
  (setq-default magit-process-popup-time 10
                magit-diff-refine-hunk t
                magit-completing-read-function 'magit-ido-completing-read)
  (setq magit-display-buffer-function
        (lambda (buffer)
            (display-buffer
             buffer (if (and (derived-mode-p 'magit-mode)
                             (memq (with-current-buffer buffer major-mode)
                                   '(magit-process-mode
                                     magit-revision-mode
                                     magit-diff-mode
                                     magit-stash-mode
                                     magit-status-mode)))
                        nil
                      '(display-buffer-same-window))))))

(provide 'core-vc)
