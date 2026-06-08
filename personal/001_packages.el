;; packages --- Exported from Org Mode
<<<<<<< HEAD
;; 2026-03-31  4:46:03 pm CEST
=======
;; 2026-06-08  7:52:22 pm CEST
>>>>>>> main

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

    ;; --- completion ---
  (use-package corfu
    ;; Optional customizations
    ;; :custom
    ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
    ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
    ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
    ;; (corfu-preview-current nil)    ;; Disable current candidate preview
    ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
    ;; (corfu-on-exact-match 'insert) ;; Configure handling of exact matches

    ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
    ;; :hook ((prog-mode . corfu-mode)
    ;;        (shell-mode . corfu-mode)
    ;;        (eshell-mode . corfu-mode))

    :init

    ;; Recommended: Enable Corfu globally.  Recommended since many modes provide
    ;; Capfs and Dabbrev can be used globally (M-/).  See also the customization
    ;; variable `global-corfu-modes' to exclude certain modes.
    (global-corfu-mode)

    ;; Enable optional extension modes:
    ;; (corfu-history-mode)
    ;; (corfu-popupinfo-mode)
    )

  ;; A few more useful configurations...
  (use-package emacs
    :custom
    ;; TAB cycle if there are only few candidates
    ;; (completion-cycle-threshold 3)

    ;; Enable indentation+completion using the TAB key.
    ;; `completion-at-point' is often bound to M-TAB.
    (tab-always-indent 'complete)

    ;; Emacs 30 and newer: Disable Ispell completion function.
    ;; Try `cape-dict' as an alternative.
    (text-mode-ispell-word-completion nil)

    ;; Hide commands in M-x which do not apply to the current mode.  Corfu
    ;; commands are hidden, since they are not used via M-x. This setting is
    ;; useful beyond Corfu.
    (read-extended-command-predicate #'command-completion-default-include-p))

  ;; Enable auto completion pop up, configure delay, trigger and quitting
  ;; (setq corfu-auto t
  ;;       corfu-auto-delay 0.2
  ;;       corfu-auto-trigger "." ;; Custom trigger characters
  ;;       corfu-quit-no-match 'separator) ;; or t

  ;; --- completion ---

  ;; flexible fuzzy matching via orderless
  (use-package orderless
    :ensure t
    :init
    ;; corfu completion
    ;; (orderless-style-dispatchers '(orderless-affix-dispatch))
    ;; (orderless-component-separator #'orderless-escapable-split-on-space)
    (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles partial-completion)))
        completion-category-defaults nil ;; Disable defaults, use our settings
        completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring
    

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
<<<<<<< HEAD
  (use-package gt
    :ensure t
    :config
    (setq gt-default-translator
          (gt-translator
           :taker   (gt-taker :langs '(de en el ru)
                              :text 'buffer
                              :pick 'paragraph)
           :engines (list (gt-deepl-engine)
                          ;; (gt-google-engine)
                          )
           :render  (gt-buffer-render))))
=======
  ;;; Translation — go-translate (gt) with DeepL
(use-package gt
  :ensure t
  :config

  ;; --- DeepL fixes (run once gt's DeepL engine file is loaded) ---
  (with-eval-after-load 'gt-engine-deepl

    ;; 1) Add Greek. The shipped language table has no Greek entry,
    ;;    even though DeepL itself supports it (API code "EL").
    ;;    Without this, translating to/from Greek throws an error.
    (add-to-list 'gt-deepl-langs-mapping '(el . "EL"))

    ;; 2) Fix the result parser. DeepL's reply looks like:
    ;;       {"translations":[{"text":"...","detected_source_language":"DE"}]}
    ;;    The built-in parser grabbed a field *by position*, which broke
    ;;    when DeepL reordered them — so it showed the language code ("EN")
    ;;    instead of the translated text. This version grabs the "text"
    ;;    field *by name*, so field order no longer matters.
    (cl-defmethod gt-parse ((_ gt-deepl-parser) task)
      (cl-loop for item in (oref task res)
               for translations = (alist-get 'translations item)
               for str = (mapconcat (lambda (tr) (or (alist-get 'text tr) ""))
                                     (append translations nil) "\n")
               collect (string-trim (decode-coding-string str 'utf-8)) into lst
               finally (oset task res lst))))

  ;; --- The default translator used by M-x gt-translate ---
  (setq gt-default-translator
        (gt-translator
         ;; What text to grab and which languages to offer:
         :taker (gt-taker
                 :langs '(de en el ru)  ; languages you translate between
                 :text 'buffer          ; take the whole buffer
                 :pick 'paragraph       ; split it paragraph by paragraph
                 :prompt t)             ; ask/confirm the from→to direction
                                        ; (so it won't guess wrong, e.g. DE as EN)
         ;; Which engine does the translating:
         :engines (list (gt-deepl-engine))
         ;; Where the result is shown:
         :render (gt-buffer-render))))   ; pop up a buffer with the translation
>>>>>>> main

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

  ;; easy-kill
  ;; (use-package easy-kill
  ;;   :init
  ;;   (global-set-key [remap kill-ring-save] 'easy-kill)
  ;;   (global-set-key [remap mark-sexp] 'easy-mark))

  ;; xclip
  (use-package xclip
    :init
    (xclip-mode 1)
    ;; sync kill ring into system clipboard
    (setq x-select-enable-clipboard t))

  ;; undo-tree
  (use-package undo-tree
    :init
    (global-undo-tree-mode))

  (use-package ispell
    :ensure nil
    :custom
    (ispell-program-name "aspell")
    (ispell-dictionary "british")
    :config
    (defvar my/ispell-dictionaries '("british" "el" "de"))

    (defvar my/ispell-dictionary-ring
      (let ((ring (make-ring (length my/ispell-dictionaries))))
        (dolist (dict my/ispell-dictionaries ring)
          (ring-insert ring dict))))

    (defun my/cycle-ispell-dictionary ()
      (interactive)
      (let ((dict (ring-ref my/ispell-dictionary-ring -1)))
        (ring-insert my/ispell-dictionary-ring dict)
        ;; critical: reset personal dictionary when changing language
        (setq-local ispell-local-dictionary dict)
        (setq-local ispell-personal-dictionary nil)
        (ispell-kill-ispell t)
        (ispell-change-dictionary dict)
        (message "Local Ispell dictionary set to %s" dict)))

    (global-set-key (kbd "C-M-!") #'my/cycle-ispell-dictionary)
    (global-set-key (kbd "s-;") #'ispell-continue))

  ;; plantuml
  ;; (use-package plantuml-mode
  ;; :mode ("\\.puml\\'" "\\.plantuml\\'" "\\.pu\\'")
  ;; :init
  ;; (setq org-plantuml-jar-path
  ;;       (expand-file-name "~/bin/plantuml/plantuml-1.2025.2.jar"))
  ;; (setq plantuml-default-exec-mode 'jar)
  ;; :config
  ;; (org-babel-do-load-languages
  ;;  'org-babel-load-languages
  ;;  '((plantuml . t))))





(provide 'packages)
;; 001_packages.el ends here
