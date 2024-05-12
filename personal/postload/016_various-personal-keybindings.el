;;; various-personal-keybindings --- 2024-05-12 08:43:36 pm

;;; Commentary:
;; Configuration for personal keybindings

;;; Code:
;; Remove C-l mapping and define new
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

;; ------------ Dired Mode ------------
;; q kills current buffer instead of quit
(define-key dired-mode-map "q" 'kill-this-buffer)
;; ------------------------------------

;; ------- Console mode f7 as H -------
(define-key function-key-map (kbd "<f7>") 'event-apply-hyper-modifier)
;; -------------------------------------

(provide 'various-personal-keybindings)
;;; 016_various-personal-keybindings.el ends here
