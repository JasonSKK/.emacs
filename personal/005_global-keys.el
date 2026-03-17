;; global-keys --- Exported from Org Mode
;; 2026-03-17  5:09:14 pm CET

  
  ;; Commentary:
  ;; Configuration for personal keybindings

  ;; Code:
  ;; Remove C-l mapping and define new keymap prefix
  (global-unset-key "\C-l")
  (defvar ctl-l-map (make-keymap)
    "Keymap for local bindings and functions, prefixed by (^L)")
  (define-key global-map "\C-l" 'Control-L-prefix)
  (fset 'Control-L-prefix ctl-l-map)

(provide 'global-keys)
;; 005_global-keys.el ends here
