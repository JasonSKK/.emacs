;;; prefix-ctrl-l --- 2024-11-22  8:09:46 pm CET

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
;;; 009_prefix-ctrl-l.el ends here
