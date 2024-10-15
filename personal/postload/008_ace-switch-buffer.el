;;; ace-switch-buffer --- 2024-10-15  8:55:11 pm CEST
;;; Commentary:
;;; move amngst windows and switch window position with cursor keys

(prelude-require-package 'buffer-move)
;; (require 'windmove) required by buffermove
;; (winner-mode -1)
;;(global-set-key (kbd "s-<left>")  'windmove-left)
;;(global-set-key (kbd "s-<right>") 'windmove-right)
;;(global-set-key (kbd "s-<up>")    'windmove-up)
;;(global-set-key (kbd "s-<down>")  'windmove-down)
;;(global-set-key (kbd "s-S-<up>")     'buf-move-up)
;;(global-set-key (kbd "s-S-<down>")   'buf-move-down)
;;(global-set-key (kbd "s-S-<left>")   'buf-move-left)
;;(global-set-key (kbd "s-S-<right>")  'buf-move-right)
(global-set-key (kbd "C-O")  'ace-window)
(global-set-key (kbd "C-x o")  'ace-window)
(setq aw-keys '(?a ?b ?c ?d ?e ?f ?g ?h ?i ?j ?k ?l ?m ?n ?o ?p ?q))
(provide 'ace-switch-buffer)
;;; 008_ace-switch-buffer.el ends here
