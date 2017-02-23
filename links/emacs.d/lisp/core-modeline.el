;;--------------------------------------------------
;; Modeline position indicators
;;--------------------------------------------------
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;;--------------------------------------------------
;; Custom mode line
;;--------------------------------------------------
(defun powerline-has-notice ()
  (if flycheck-color-mode-line-cookie
      t
    nil))

(defun powerline-custom-theme ()
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line-buffer-id (if active
                                                   'mode-line-buffer-id
                                                 'mode-line-buffer-id-inactive))
                          (mode-line (if active
                                         'mode-line
                                       'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (lhs (list
                                ;; Buffer Save, Size, Name
                                (powerline-raw "%*" mode-line 'l)
                                (powerline-buffer-size mode-line 'l)

                                (powerline-buffer-id mode-line 'r)
                                (powerline-arrow-right mode-line face1 20)

                                (powerline-major-mode face1 'l))))

                     (concat
                      (powerline-render lhs)))))))






;                                (set-face-attribute mode-line-buffer-id nil :background (face-attribute face1 :background))




                                  ;; Git Branch
;                                  (powerline-vc face1)
;                                  (powerline-raw " " face1)
;                                  (powerline-arrow-right face1 face2 18)))
;                            (center (list
;                                     (powerline-minor-modes face2 'l)))
;                            (rhs (list
;                                  (powerline-raw global-mode-string face1 'r)
;
                                  ;; Location #:#
;                                  (powerline-arrow-left face2 face1 18)
;                                  (powerline-raw "%4l" face1 'l)
;                                  (powerline-raw ":" face1)
;                                  (powerline-raw "%3c" face1 'r)

                                  ;; Location %
;                                  (get-powerline-separator 'left face1 mode-line 18)
;                                  (powerline-raw " " mode-line)
;                                  (powerline-raw "%6p" mode-line 'r))))
;                       (concat
;                        (powerline-render lhs)
;                        (powerline-fill-center face2 (/ (powerline-width center) 2.0))
;                        (powerline-render center)
;                        (powerline-fill face2 (powerline-width rhs))
 ;                       (powerline-render rhs)))))))


;;--------------------------------------------------
;; Powerline
;;--------------------------------------------------
(use-package powerline
  :ensure t
  :config
  ;;--------------------------------------------------
  ;; Reset overrides
  ;;--------------------------------------------------
  (defun pl/memoize (func name))

  (defun pl/memoize-wrap-frame-local (func name)
    (let ((funcid (cl-gensym)))
      `(lambda (&rest args)
         (let* ((cache (pl/create-or-get-cache))
                (key (cons ',funcid args))
                (val (gethash key cache)))
           (if (and val
                    (not (string= ,name "arrow")))
               val
             (apply ,func args)
             (puthash key (apply ,func args) cache))))))

  (defun powerline-reset ()
    "All we care about is arrows"
    (interactive)
    (pl/memoize (pl/arrow left) "arrow")
    (pl/memoize (pl/arrow right) "arrow")
    (pl/reset-cache))

  (powerline-reset)
  (powerline-custom-theme))


(face-attribute (face-attribute 'flycheck-color-mode-line-error-face :background) :background)

(print (cdr flycheck-color-mode-line-cookie))

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



(provide 'core-modeline)
