;;; text-editing-keybindings --- 2024-10-12  8:36:39 pm CEST
;;; Commentary:
;; Configuration for personal keybindings

;;; Code:
;; Remove C-l mapping and define new keymap prefix
(global-unset-key "\C-l")
(defvar ctl-l-map (make-keymap)
     "Keymap for local bindings and functions, prefixed by (^L)")
(define-key global-map "\C-l" 'Control-L-prefix)
(fset 'Control-L-prefix ctl-l-map)
;; ------ Text editing bindings ------
;; Define key for replace string
(define-key ctl-l-map "r"  'replace-string)
;; Allow hash to be entered
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))
;; map fill region
(define-key ctl-l-map "f"  'fill-region)
;; comment region
(global-set-key (kbd "C-M-;") 'comment-region)
;; ------------------------------------
;; indenting
(global-set-key (kbd "C-x TAB") 'indent-rigidly)

(provide 'text-editing-keybindings)
;;; 010_text-editing-keybindings.el ends here
