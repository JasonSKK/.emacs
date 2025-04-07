;;; ispell-config --- Exported from Org Mode
;;; 2025-03-04  6:47:37 pm CET

  ;; This contains a collection of Ispell configurations.

  ;;; Commentary:

  ;;; Code:
  ;; for cycling through Greek and UK English when using Ispell <C-1>
  ;; You should have aspell-gr and aspell-en packages installed
  (let ((langs '("british" "el" "ru")))
    (setq lang-ring (make-ring (length langs)))
    (dolist (elem langs) (ring-insert lang-ring elem)))
  (defun cycle-ispell-languages ()
    (interactive)
    (let ((lang (ring-ref lang-ring -1)))
      (ring-insert lang-ring lang)
      (ispell-change-dictionary lang)))
  (global-set-key (kbd "C-!") 'cycle-ispell-languages)
  ;; ignore spelling in LaTeX \commands
  (setq ispell-tex-skip-alists
        (list
         (append
          (car ispell-tex-skip-alists)
          '(("\\\\mycommand"       ispell-tex-arg-end)
            ("\\\\mycommandtwo"      ispell-tex-arg-end 2)))
         (cadr ispell-tex-skip-alists)))
  ;; Ispell continue
  (global-set-key (kbd "s-;") 'ispell-continue)

  (add-hook 'LaTeX-mode-hook #'turn-on-flyspell)
  ;; (add-hook 'org-mode-hook '(flyspell-mode t))
  ;;(add-hook org-mode-hook #'turn-on-flyspell)
  ;; toggle flyspell on open text-mode ~ all modes
  ;; (add-hook 'text-mode-hook #'flyspell-mode)
  ;; (add-hook 'flyspell-mode-hook #'flyspell-local-vars)
  ;; (defun flyspell-local-vars ()
  ;;  (add-hook 'hack-local-variables-hook #'flyspell-buffer))


(provide 'ispell-config)
;;; 012_ispell-config.el ends here
