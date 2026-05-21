;; text --- Exported from Org Mode
;; 2026-05-21  5:56:47 pm CEST


  ;; Commentary:
  ;; Configuration for personal keybindings

  ;; Code:
  ;; --- Text preferences ---

  (set-face-attribute 'default nil :font "IBM Plex Mono")
  (set-fontset-font t 'greek (font-spec :family "FreeMono"))

  ;; detects a /path/to/file or https://example-url.com near point, can remap C-x C-f so it uses that guess as the default
  (ffap-bindings)

  ;; when marked region makes typed text replace the active region
  (delete-selection-mode 1)

  ;; ------ Text editing keybindings ------
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



(provide 'text)
;; 006_text.el ends here
