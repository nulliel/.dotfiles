;; Mode line position indicators
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
;; Custom mode line
(use-package powerline
  :ensure t
  :init
  (defun get-powerline-separator (dir &rest args)
    (let ((separator (and (fboundp 'powerline-current-separator)
                          (intern (format "powerline-%s-%s"
                                          (powerline-current-separator)
                                          (or (and (eq dir 'left)
                                                   (car powerline-default-separator-dir))
                                              (cdr powerline-default-separator-dir))))))
          (args (mapcar (lambda (f)
                          (let ((fa (assoc f face-remapping-alist)))
                            (if fa
                                (cadr fa)
                              f)))
                        args)))
      (when (fboundp separator)
        (let ((img (apply separator args)))
          (when (and (listp img)
                     (eq 'image (car img)))
            (propertize " " 'display img 'face (plist-get (cdr img) :face)))))))
  (defun powerline-custom-theme ()
    (interactive)
    (setq-default mode-line-format
                  '("%e"
                    (:eval
                     (let* ((active (powerline-selected-window-active))
                            (mode-line-buffer-id (if active 'mode-line-buffer-id 'mode-line-buffer-id-inactive))
                            (mode-line (if active 'mode-line 'mode-line-inactive))
                            (face1 (if active 'powerline-active1 'powerline-inactive1))
                            (face2 (if active 'powerline-active2 'powerline-inactive2))
                            (lhs (list
                                  ;; Buffer Save, Size, Name
                                  (powerline-raw "%*" face1 'l)
                                  (powerline-buffer-size face1 'l)
                                  (set-face-attribute mode-line-buffer-id nil :background (face-attribute face1 :background))
                                  (powerline-buffer-id mode-line-buffer-id 'l)
                                  (powerline-raw " " face1)
                                  (powerline-arrow-right face1 face2 18)

                                  ;; Major Mode
                                  (powerline-major-mode face2 'l)
                                  (powerline-raw " " face2)
                                  (powerline-arrow-right face2 face1 18)

                                  ;; Git Branch
                                  (powerline-vc face1)
                                  (powerline-raw " " face1)
                                  (powerline-arrow-right face1 face2 18)))
                            (center (list
                                     (powerline-minor-modes face2 'l)))
                            (rhs (list
                                  (powerline-raw global-mode-string face1 'r)

                                  ;; Location #:#
                                  (powerline-arrow-left face2 face1 18)
                                  (powerline-raw "%4l" face1 'l)
                                  (powerline-raw ":" face1)
                                  (powerline-raw "%3c" face1 'r)

                                  ;; Location %
                                  (get-powerline-separator 'left face1 mode-line 18)
                                  (powerline-raw " " mode-line)
                                  (powerline-raw "%6p" mode-line 'r))))
                       (concat
                        (powerline-render lhs)
                        (powerline-fill-center face2 (/ (powerline-width center) 2.0))
                        (powerline-render center)
                        (powerline-fill face2 (powerline-width rhs))
                        (powerline-render rhs)))))))
  :config
  (powerline-custom-theme))

(provide 'core-modeline)
