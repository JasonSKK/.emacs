;;; prefix-ctrl-l --- Exported from Org Mode
;;; 2026-02-20 11:07:33 pm CET


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
;;; 008_prefix-ctrl-l.el ends here
