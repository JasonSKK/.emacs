;;; prefix-ctrl-l --- Exported from Org Mode
;;; 2026-03-16 11:01:44 pm CET


;; Commentary:
;; Configuration for personal keybindings

;; Code:
;; Remove C-l mapping and define new keymap prefix
(global-unset-key "\C-l")
(defvar ctl-l-map (make-keymap)
  "Keymap for local bindings and functions, prefixed by (^L)")
(define-key global-map "\C-l" 'Control-L-prefix)
(fset 'Control-L-prefix ctl-l-map)

(provide 'prefix-ctrl-l)
;;; 003_prefix-ctrl-l.el ends here
