;; now-today-text-insert --- Exported from Org Mode
;; 2026-03-31  4:46:04 pm CEST

;; This file provides a number of personal function definitions

;; Commentary:

;; Code:

;; function now (time) M-x now
(defun now ()
  "Insert string for the current time formatted like '2:34 PM'."
  (interactive) ;; permit invocation in minibuffer
  (insert (format-time-string "%Y-%m-%d %-I:%M %p")))
(defun today ()
  "Insert string for today's date nicely formatted in UK style,
i.e. Sunday, 17 September, 2000."
  (interactive) ;; permit invocation in minibuffer
  (insert (format-time-string "%A, %e %B, %Y")))

(provide 'now-today-text-insert)
;; 007_now-today-text-insert.el ends here
