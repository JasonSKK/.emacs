;; gccjit --- Exported from Org Mode
;; 2026-03-17  3:19:10 pm CET

;; gccjit (GNU Compiler Collection Just-In-Time compilation) allows Emacs to natively compile Elisp code into machine code for improved performance.
(setq native-comp-async-report-warnings-errors 'silent)
(setq native-comp-speed 3)
(setq native-comp-deferred-compilation t)
(setq package-native-compile t)

(provide 'gccjit)
;; 015_gccjit.el ends here
