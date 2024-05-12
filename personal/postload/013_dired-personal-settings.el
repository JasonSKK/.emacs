;;; dired-personal-settings --- 2024-05-12 08:43:35 pm
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
(provide 'dired-personal-settings)
;;; 013_dired-personal-settings.el ends here
