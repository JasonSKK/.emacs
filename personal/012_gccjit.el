;;; gccjit --- Exported from Org Mode
;;; 2026-03-16 11:01:44 pm CET

                                        ;: Enable gccjit  in Emacs
;; gccjit (GNU Compiler Collection Just-In-Time compilation) allows Emacs to natively compile Elisp code into machine code for improved performance.
(setq native-comp-async-report-warnings-errors 'silent)
(setq native-comp-speed 3)
(setq native-comp-deferred-compilation t)
(setq package-native-compile t)

(provide 'gccjit)
;;; 012_gccjit.el ends here
