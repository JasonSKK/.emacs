;;; reverse-im --- Exported from Org Mode
;;; 2025-06-14  7:34:08 pm CEST

  (require 'reverse-im)

  (setq reverse-im-input-methods '("greek")) ; important: match the OS-level Greek layout
  (reverse-im-mode 1)

  ;; some key-bindings just do not work and need to be mapped manually
  (global-set-key (kbd "C-ζ") 'yank)
  (global-set-key (kbd "M-»") 'end-of-buffer)
  (global-set-key (kbd "M-«") 'beggining-of-buffer)


(provide 'reverse-im)
;;; 022_reverse-im.el ends here
