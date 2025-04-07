;;; dired-config --- Exported from Org Mode
;;; 2025-03-04  6:47:37 pm CET

    ;;; Commentary:
  ;; Hide details when using dired

                ;;; Code:
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

(provide 'dired-config)
;;; 006_dired-config.el ends here
