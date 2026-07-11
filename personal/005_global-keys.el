;; global-keys --- Exported from Org Mode
;; 2026-07-11 11:38:22 am CEST


  ;; Commentary:
  ;; Configuration for personal keybindings

  ;; Code:
  ;; Remove C-l mapping and define new keymap prefix
  (global-unset-key "\C-l")
  (defvar ctl-l-map (make-keymap)
    "Keymap for local bindings and functions, prefixed by (^L)")
  (define-key global-map "\C-l" 'Control-L-prefix)
  (fset 'Control-L-prefix ctl-l-map)

  ;; increment/decrease text scale
  (global-set-key (kbd "C-+") (lambda () (interactive) (text-scale-increase 1)))
  (global-set-key (kbd "C--") (lambda () (interactive) (text-scale-decrease 1)))


(provide 'global-keys)
;; 005_global-keys.el ends here
