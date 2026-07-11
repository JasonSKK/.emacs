;; completion --- Exported from Org Mode
;; 2026-07-11 11:38:22 am CEST

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

    ;; ---------- LSP-MODE ----------
    ;; The path to lsp-mode needs to be added to load-path as well as the
    ;; path to the `clients' subdirectory.
    (add-to-list 'load-path (expand-file-name "lib/lsp-mode" user-emacs-directory))
    (add-to-list 'load-path (expand-file-name "lib/lsp-mode/clients" user-emacs-directory))

    (use-package lsp-mode
    :init
    ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
    (setq lsp-keymap-prefix "C-c l")
    :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
           (rust-mode . lsp)
           ;; if you want which-key integration
           (lsp-mode . lsp-enable-which-key-integration))
    :commands lsp)

  ;; optionally
  ;; (use-package lsp-ui :commands lsp-ui-mode)
  ;; if you are helm user
  ;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)
  ;; ;
                                          ; if you are ivy user
  ;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
  ;; (
  ;; use-package lsp-treemacs :commands lsp-treemacs-errors-list)

  ;; optionally if you want to use debugger
  ;; (use-package dap-mode)
  ;; (use-package dap-LANGUAGE) to load the dap adapter for your language

  ;; optional if you want which-key integration
  (use-package which-key
      :config
      (which-key-mode))


(provide 'completion)
;; 010_completion.el ends here
