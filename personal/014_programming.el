;; programming --- Exported from Org Mode
;; 2026-03-17  5:09:14 pm CET

  ;; --- C/C++ ---
  ;; Set the default indentation level to 3 spaces for C/C++ modes
  (setq c-basic-offset 3)

  ;; Disable the use of tabs for indentation using spaces instead
  (custom-set-variables '(indent-tabs-mode nil))

  ;; configure indentation in C++ mode
  (defun indentation-setup-c++-mode ()
    ;; Set the basic indentation level to 3 spaces specifically for C++ mode
    (setq c-basic-offset 3)
    ;; braces don't get additional indentation (brace alignment with control structures)
    (c-set-offset 'substatement-open 0))

  (add-hook 'c++-mode-hook 'indentation-setup-c++-mode)
  
  ;; Prevent company-mode from automatically lowercasing completions
  (setq company-dabbrev-downcase nil)

(provide 'programming)
;; 014_programming.el ends here
