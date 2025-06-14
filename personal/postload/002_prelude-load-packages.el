;;; prelude-load-packages --- Exported from Org Mode
;;; 2025-06-14  7:34:07 pm CEST

  (prelude-load-require-packages '(avy-zap avy-menu auto-async-byte-compile anzu ace-window ace-popup-menu ace-isearch))
  (prelude-load-require-packages '(multiple-cursors ace-mc)) ;; mc-extras

  ;;; re-builder package
  ;; https://www.masteringemacs.org/article/re-builder-interactive-regexp-builder
  (prelude-require-package 're-builder)
  (setq reb-re-syntax 'string)

(provide 'prelude-load-packages)
;;; 002_prelude-load-packages.el ends here
