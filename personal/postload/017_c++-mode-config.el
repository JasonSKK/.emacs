;;; c++-mode-config --- 2024-10-15  8:55:13 pm CEST
  #+begin_src emacs-lisp
  ;; Set the default indentation level to 3 spaces for C/C++ modes
(setq c-basic-offset 3)
;; Disable the use of tabs for indentation using spaces instead
(custom-set-variables '(indent-tabs-mode nil))
;; configure indentation in C++ mode
(defun my-c++-mode-hook ()
  ;; Set the basic indentation level to 3 spaces specifically for C++ mode
  (setq c-basic-offset 3)
  ;; braces don't get additional indentation (brace alignment with control structures)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
;; Prevent company-mode from automatically lowercasing completions
(setq company-dabbrev-downcase nil)
(provide 'c++-mode-config)
;;; 017_c++-mode-config.el ends here
