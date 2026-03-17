;; packages --- Exported from Org Mode
;; 2026-03-17  3:19:10 pm CET

  ;; Commentary:
  ;; this is all of the packages.

  ;; --- Package bootstrap ---
  (require 'package)

  (setq package-archives
        '(("gnu"   . "https://elpa.gnu.org/packages/")
          ("melpa" . "https://melpa.org/packages/")))

  (package-initialize)

  (unless package-archive-contents
    (package-refresh-contents))

  (unless (package-installed-p 'use-package)
    (package-install 'use-package))

  (require 'use-package)
  (setq use-package-always-ensure t)

  ;; --- Packages ---
  ;; completion UI
  (use-package vertico
    :init
    (vertico-mode))

  ;; richer minibuffer commands
  (use-package consult
    :bind (("C-x b"   . consult-buffer)
           ("C-x C-r" . consult-recent-file)
           ("M-y"     . consult-yank-pop)
           ("M-g g"   . consult-goto-line)
           ("M-s r"   . consult-ripgrep)))

  ;; better M-x, find-file annotations
  (use-package marginalia
    :init
    (marginalia-mode 1))

  ;; better M-x sorting history
  (use-package savehist
    :init
    (savehist-mode))

  ;; flexible fuzzy matching via orderless
  (use-package orderless
    :ensure t
    :init
    (setq completion-styles '(orderless basic)
          completion-category-defaults nil
          completion-category-overrides
          '((file (styles basic partial-completion)))))

  ;; ignores case for find file
  (setq read-buffer-completion-ignore-case t
        read-file-name-completion-ignore-case t)

  ;; find recently opened files and more 
  (use-package recentf
    :init
    (recentf-mode 1)
    :custom
    (recentf-max-saved-items 200)
    (recentf-auto-cleanup 'never))

  ;; translation
  (use-package gt
    :ensure t
    :config
    (setq gt-default-translator
          (gt-translator
           :taker   (gt-taker :langs '(de en el ru)
                              :text 'buffer
                              :pick 'paragraph)
           :engines (list (gt-libre-engine)
                          ;; (gt-google-engine)
                          )
           :render  (gt-buffer-render))))

  ;; telephone line 
  (use-package telephone-line
    :init
    (setq telephone-line-subseparator-faces '())
    (setq telephone-line-height 24
    telephone-line-evil-use-short-tag t)
    (telephone-line-mode 1))

  ;; key-chord
  (use-package key-chord
    :init
    (key-chord-mode))

  ;; notmuch
  (use-package notmuch)

  ;; avy-zap
  (use-package avy-zap)

  ;; avy-menu
  (use-package avy-menu)

  ;; auto-async-byte-compile
  (use-package auto-async-byte-compile)

  ;; ace window
  (use-package ace-window)

  ;; multiple-cursors
  (use-package multiple-cursors)
  (use-package ace-mc)

  ;; xclip
  (use-package xclip
    :init
    (xclip-mode 1)
    ;; sync kill ring into system clipboard
    (setq x-select-enable-clipboard t))



(provide 'packages)
;; 001_packages.el ends here
