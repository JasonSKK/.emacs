;; flycheck --- Exported from Org Mode
;; 2026-03-18  9:10:45 pm CET

  ;; 260317, yes lag is observed, especially on autosave
  ;; --> I suffered from this in my previous config. For now it remains commented out until issue is observed again.

  ;; flycheck slows emacs down FIX
  ;; Flycheck uses default config to check when a new-line is inserted or idle-change event occurs.
  ;; To change this:
  (setq flycheck-check-syntax-automatically '(save mode-enable))
  ;; the default value was '(save idle-change new-line mode-enabled)

  ;; This way, syntax checking will occur only when you save your file or change the major mode.
  (setq flycheck-check-syntax-automatically '(save mode-enable))

  ;; https://github.com/flycheck/flycheck/issues/1129#issuecomment-319600923
  (with-eval-after-load 'flycheck
    (advice-add 'flycheck-eslint-config-exists-p :override (lambda() t)))


(provide 'flycheck)
;; 010_flycheck.el ends here
