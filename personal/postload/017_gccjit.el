;;; gccjit --- Exported from Org Mode
;;; 2025-10-18  1:45:20 pm CEST

;: Enable gccjit  in Emacs
;; gccjit (GNU Compiler Collection Just-In-Time compilation) allows Emacs to natively compile Elisp code into machine code for improved performance.
(setq native-comp-async-report-warnings-errors 'silent)
(setq native-comp-speed 3)
(setq native-comp-deferred-compilation t)
(setq package-native-compile t)

(provide 'gccjit)
;;; 017_gccjit.el ends here
