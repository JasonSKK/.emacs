;;; prefix-ctrl-l --- Exported from Org Mode
;;; 2025-03-04  6:47:37 pm CET


  ;;; Commentary:
  ;; Configuration for personal keybindings

  ;;; Code:
  ;; Remove C-l mapping and define new keymap prefix
  (global-unset-key "\C-l")
  (defvar ctl-l-map (make-keymap)
    "Keymap for local bindings and functions, prefixed by (^L)")
  (define-key global-map "\C-l" 'Control-L-prefix)
  (fset 'Control-L-prefix ctl-l-map)

(provide 'prefix-ctrl-l)
;;; 007_prefix-ctrl-l.el ends here
