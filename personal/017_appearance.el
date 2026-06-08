;; appearance --- Exported from Org Mode
;; 2026-06-08  7:52:22 pm CEST


  ;; tool-bar-mode disabled
  (tool-bar-mode 0)

  ;; --- Date/time ---
  ;; Display time
  (display-time)
  (setq display-time-format "%H:%M %Y %b %d %a")

  ;; Display date
  (display-time-mode 1)

  ;; --- Window ---
  ;; emacsclient new frames maximised
  (add-to-list 'default-frame-alist '(fullscreen . maximized))

  ;; --- DISPLAY ---
  
  ;; line numbers
  (global-display-line-numbers-mode) ;; display line numbers

  ;; Reverse colors for the border to have nicer line
  ;;(set-face-inverse-video-p 'vertical-border nil)
  ;;(set-face-background 'vertical-border (face-background 'default))
  ;; Set symbol for the border
  ;;(set-display-table-slot standard-display-table
  ;;                        'vertical-border
  ;;                        (make-glyph-code ?┃))

  ;; startup frame position
  ;; (setq initial-frame-alist
  ;;     '((top . 1)         ; Top edge of the screen
  ;;     (left . 490)      ; Distance from the left edge of the screen
  ;;   (width . 132)      ; Width of the frame
  ;; (height . 61)))  ; Height of the frame

  ;; set alpha value: transparency
  ;; (set-frame-parameter(selected-frame)'alpha '(100. 0))
  ;;(add-to-list 'default-frame-alist '(alpha . (100. 0)))

  ;; startup buffers define 
  ;; 1. Split the window horizontally
  (split-window-horizontally)
  ;; 2. Open the scratch buffer on the left
  (switch-to-buffer "*scratch*")

  ;; --- Themes ---
  ;; disable theme after loading another one
  (defun disable-all-themes ()
    "disable all active themes."
    (dolist (i custom-enabled-themes)
      (disable-theme i)))
  (defadvice load-theme (before disable-themes-first activate)
    (disable-all-themes))


(provide 'appearance)
;; 017_appearance.el ends here
