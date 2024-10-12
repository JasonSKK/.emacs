;;; dired-config --- 2024-10-12  8:36:39 pm CEST
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
(define-key dired-mode-map "q" 'kill-this-buffer)
;; ------------------------------------
(provide 'dired-config)
;;; 007_dired-config.el ends here
