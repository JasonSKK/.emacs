;; undo-tree --- Exported from Org Mode
;; 2026-07-11 11:38:22 am CEST

  ;; global
  (setq undo-tree-auto-save-history nil)

  ;; Disable it per-file by pattern
  ;; Set the variable buffer-locally for anything encrypted or secret-bearing:
  ;; This keeps undo-tree persistence everywhere else but turns off the on-disk history for .gpg / .authinfo files.
  (add-hook 'find-file-hook
            (lambda ()
              (when (and buffer-file-name
                         (string-match-p "\\.\\(gpg\\|authinfo\\)\\'" buffer-file-name))
                (setq-local undo-tree-auto-save-history nil))))



(provide 'undo-tree)
;; 018_undo-tree.el ends here
