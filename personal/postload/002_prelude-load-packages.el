;;; prelude-load-packages --- 2024-10-15  8:55:10 pm CEST
    (prelude-load-require-packages '(avy-zap avy-menu auto-async-byte-compile anzu ace-window ace-popup-menu ace-isearch))

    ;;; re-builder package
    ;; https://www.masteringemacs.org/article/re-builder-interactive-regexp-builder
    (prelude-require-package 're-builder)
    (setq reb-re-syntax 'string)
(provide 'prelude-load-packages)
;;; 002_prelude-load-packages.el ends here
