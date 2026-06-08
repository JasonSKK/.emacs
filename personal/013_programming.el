;; programming --- Exported from Org Mode
;; 2026-06-08  8:09:36 pm CEST

  ;; --- C/C++ ---
  ;; Set the default indentation level to 3 spaces for C/C++ modes
  (setq c-basic-offset 3)

  ;; Disable the use of tabs for indentation using spaces instead
  (custom-set-variables '(indent-tabs-mode nil))
  (setq-default tab-width 3)

  (add-hook 'c-mode-common-hook
            (lambda ()
              (setq c-basic-offset 3)

              ;; Correct enum formatting
              (c-set-offset 'brace-list-intro '+)
              (c-set-offset 'brace-list-entry 0)
              (c-set-offset 'brace-list-close 0)))



  ;; ;; configure indentation in C++ mode -- OLD
  ;; (defun indentation-setup-c++-mode ()
  ;;   ;; Set the basic indentation level to 3 spaces specifically for C++ mode
  ;;   (setq c-basic-offset 3)
  ;;   ;; braces don't get additional indentation (brace alignment with control structures)
  ;;   (c-set-offset 'substatement-open 0))

  ;; (add-hook 'c++-mode-hook 'indentation-setup-c++-mode)

  ;; ;; Prevent company-mode from automatically lowercasing completions
  ;; (setq company-dabbrev-downcase nil)

(provide 'programming)
;; 013_programming.el ends here
