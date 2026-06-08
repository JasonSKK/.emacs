;; dired --- Exported from Org Mode
<<<<<<< HEAD
;; 2026-03-31  4:46:04 pm CEST
=======
;; 2026-06-08  7:52:22 pm CEST
>>>>>>> main

;; Commentary:
;; Hide details when using dired

;; Code:
(defun dired-open-dir-in-finder ()
  "Open the current directory in Finder."
  (interactive)
  (shell-command "open ."))

(define-key dired-mode-map (kbd "O") 'dired-open-dir-in-finder)

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-hide-details-mode)))
;; overwite bad ido dired list
(global-set-key (kbd "C-x d") 'ido-dired)
(global-set-key (kbd "C-x C-d") 'ido-dired)


;; q kills current buffer instead of quit
(define-key dired-mode-map "q" 'kill-current-buffer)
;; ------------------------------------

(provide 'dired)
;; 004_dired.el ends here
