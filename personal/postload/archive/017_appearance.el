;;; appearance --- Exported from Org Mode
;;; 2025-03-04  6:47:37 pm CET


  ;; zenburn disable
  (disable-theme 'zenburn)

  ;; --- DISPLAY ---
  ;; (split-window-right) ;; split to 2 windows right on startup
  ;; display numbers
  ;;(global-display-line-numbers-mode) ;; display line numbers
  ;; Reverse colors for the border to have nicer line
  ;;(set-face-inverse-video-p 'vertical-border nil)
  ;;(set-face-background 'vertical-border (face-background 'default))
  ;; Set symbol for the border
  ;;(set-display-table-slot standard-display-table
  ;;                        'vertical-border
  ;;                        (make-glyph-code ?┃))

  ;; Display time
  (display-time)
  (setq display-time-format "%H:%M %Y %b %d %a")
  ;; display date
  (display-time-mode 1)
  ;; --- Window ---
  ;; startup frame position
  (setq initial-frame-alist
        '((top . 1)         ; Top edge of the screen
          (left . 490)      ; Distance from the left edge of the screen
          (width . 132)      ; Width of the frame
          (height . 61)))  ; Height of the frame
  ;; set alpha value: transparency
  (set-frame-parameter(selected-frame)'alpha '(92. 50))
  (add-to-list 'default-frame-alist '(alpha . (92. 50)))
  ;; telephone-line-config
  (setq telephone-line-subseparator-faces '())
  (setq telephone-line-height 24
        telephone-line-evil-use-short-tag t)
  (require 'telephone-line)
  (telephone-line-mode 1)

  ;; disable theme after loading another one
  (defun disable-all-themes ()
    "disable all active themes."
    (dolist (i custom-enabled-themes)
      (disable-theme i)))
  (defadvice load-theme (before disable-themes-first activate)
    (disable-all-themes))


(provide 'appearance)
;;; 017_appearance.el ends here
