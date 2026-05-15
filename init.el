;; Make startup faster by reducing garbage collections.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(defun my/reset-gc-after-startup ()
  ;; Reasonable values for normal interactive use.
  (setq gc-cons-threshold (* 16 1024 1024)
        gc-cons-percentage 0.1))

(add-hook 'emacs-startup-hook #'my/reset-gc-after-startup)

;; --- Variables bin/exec ---

;; for access bin
(setq exec-path (append exec-path '("/usr/local/bin")))
(setq exec-path (append exec-path '("/bin")))
;; set python interpreter path
(setq python-interpreter "$HOME/venv/python3/bin/python3")

;; ------------------------

;; --- Encryption ---
;; GPG
(setenv "GPG_AGENT_INFO" nil)

;; solves epa-decrypt-region -- bug
(setf epa-pinentry-mode 'loopback)

;; --- LISP ---
;; Slime config sbcl
(setq inferior-lisp-program (executable-find "sbcl"))

;; --- server ---
(require 'server)
;; some systems don't auto-detect the socket dir, so specify it here and for the client:
(setq server-socket-dir "/tmp/emacs-shared")
;; start Emacs server mode
(server-start)

;; --- EMAIL ---

;; --- Load paths ---
;; Add load paths for all packages in personal/packages.
;; (mapc (lambda (path)
;;        (add-to-list 'load-path (concat path "/")))
;;       (file-expand-wildcards "~/.emacs.d/personal/packages/*"))

;; Load all customization files in alphabetical order.
(mapcar (lambda (path)
          (load-file path))
        (file-expand-wildcards "~/.emacs.d/personal/*.el"))

;; Load selected prelude stuff
(mapcar (lambda (path)
          (load-file path))
        (file-expand-wildcards "~/.emacs.d/personal/prelude/*.el"))

;; ------------------------

;; --- Startup time --- Should ALWAYS be LAST 
(defun efs/display-startup-time ()
  (message
   "Emacs loaded in %s with %d garbage collections."
   (format "%.2f seconds"
           (float-time
            (time-subtract after-init-time before-init-time)))
   gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

(provide 'init)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(confirm-kill-emacs 'yes-or-no-p)
 '(crux-shell-zsh-init-files
   '("$HOME/.zshrc" "$HOME/.zlogin" "$HOME/.zprofile" "$HOME/.zshenv"
     "$HOME/.zlogout" "/etc/zshenv" "/etc/zprofile" "/etc/zshrc"
     "/etc/zlogin" "/etc/zlogout" "$ZDOTDIR/.zshrc" "$ZDOTDIR/.zlogin"
     "$ZDOTDIR/.zprofile" "$ZDOTIR/.zshenv" "$ZDOTDIR/.zlogout"
     "$HOME/.oh-my-zsh/custom/aliases.zsh"
     "$HOME/.oh-my-zsh/custom/exports.zsh"))
 '(custom-enabled-themes '(modus-vivendi))
 '(default-frame-alist '((fullscreen . maximized) (font . "IBM Plex Mono")))
 '(dired-kill-when-opening-new-dired-buffer t)
 '(gc-cons-threshold 50000000)
 '(helm-descbinds-mode nil)
 '(ido-vertical-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen nil)
 '(key-chord-mode t)
 '(lsp-enable-on-type-formatting nil)
 '(mc/always-run-for-all t)
 '(notmuch-saved-searches
   '((:name "spam" :query "tag:spam" :key [115])
     (:name "inbox" :query "tag:inbox" :key [105])
     (:name "unread" :query "tag:unread" :key [117])
     (:name "flagged" :query "tag:flagged" :key [102])
     (:name "sent" :query "tag:sent" :key [116])
     (:name "drafts" :query "tag:draft" :key [100])
     (:name "all mail" :query "*" :key [97])))
 '(notmuch-search-oldest-first nil)
 '(notmuch-show-logo t)
 '(notmuch-tagging-keys
   '(("u" ("+unread") "Mark unread") ("a" notmuch-archive-tags "Archive")
     ("r" notmuch-show-mark-read-tags "Mark read")
     ("f" ("+flagged") "Flag") ("s" ("+spam" "-inbox") "Mark as spam")
     ("d" ("+deleted" "-inbox") "Delete")))
 '(org-mode-hook
   '(#[0
       "\305\20\306\11>\203\24\0\307\12\310\311#\210\307\13\312\313#\210\307\13\314\315#\210\306\11>\203,\0\307\12\316\317#\210\307\12\320\321#\210\322\11>\203>\0\307\13\323\324#\210\307\13\325\324#\210\326\11>\203P\0\307\12\327\317#\210\307\12\330\321#\210\331\11>\203_\0\332\311\14\333BC\334#\210\335\11>\203k\0\332\311\336\334#\210\337\11>\203w\0\332\311\340\334#\210\341\342\343\344#\207"
       [org-mouse-context-menu-function org-mouse-features
                                        org-mouse-map org-mode-map
                                        org-outline-regexp
                                        org-mouse-context-menu
                                        context-menu org-defkey
                                        [mouse-3] nil [mouse-3]
                                        org-mouse-show-context-menu
                                        [down-mouse-1]
                                        org-mouse-down-mouse
                                        [C-drag-mouse-1]
                                        org-mouse-move-tree
                                        [C-down-mouse-1]
                                        org-mouse-move-tree-start
                                        yank-link [S-mouse-2]
                                        org-mouse-yank-link
                                        [drag-mouse-3] move-tree
                                        [drag-mouse-3] [down-mouse-3]
                                        activate-stars
                                        font-lock-add-keywords
                                        (0
                                         `(face org-link mouse-face
                                                highlight keymap
                                                ,org-mouse-map)
                                         'prepend)
                                        t activate-bullets
                                        (("^[ \11]*\\([-+*]\\|[0-9]+[.)]\\) +"
                                          (1
                                           `(face org-link keymap
                                                  ,org-mouse-map
                                                  mouse-face highlight)
                                           'prepend)))
                                        activate-checkboxes
                                        (("^[ \11]*\\(?:[-+*]\\|[0-9]+[.)]\\)[ \11]+\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \11]*\\)?\\(\\[[- X]\\]\\)"
                                          (1
                                           `(face nil keymap
                                                  ,org-mouse-map
                                                  mouse-face highlight)
                                           prepend)))
                                        advice-add org-open-at-point
                                        :around
                                        org--mouse-open-at-point]
       4]
     org-tempo-setup
     #[0 "\300\301\302\303\304$\207"
         [add-hook change-major-mode-hook org-fold-show-all append
                   local]
         5]
     #[0 "\300\301\302\303\304$\207"
         [add-hook change-major-mode-hook org-babel-show-result-all
                   append local]
         5]
     org-babel-result-hide-spec org-overview org-babel-hide-all-hashes))
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-doi ol-eww ol-gnus ol-info ol-irc
             ol-mhe ol-rmail org-tempo ol-w3m))
 '(package-selected-packages
   '(ace-mc ace-window auto-async-byte-compile avy-menu avy-zap consult
            corfu easy-kill gt key-chord marginalia notmuch orderless
            plantuml-mode telephone-line undo-tree vertico xclip))
 '(send-mail-function 'smtpmail-send-it)
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25)
 '(user-emacs-directory-warning t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier" :foundry "nil" :width normal :height 115 :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "#DCDCCC" :background "#111111" :stipple nil :inherit nil))))
 '(font-lock-comment-delimiter-face ((t (:foreground "cyan" :inherit font-lock-comment-face))))
 '(font-lock-comment-face ((t (:foreground "gray80" :inherit modus-themes-slant))))
 '(font-lock-function-name-face ((t (:foreground "lime green" :weight bold))))
 '(helm-buffer-directory ((t (:extend t :background "LightGray" :foreground "lime green" :weight bold))))
 '(helm-ff-directory ((t (:extend t :background "gray20" :foreground "light green" :weight bold))))
 '(helm-ff-executable ((t (:extend t :foreground "red2"))))
 '(helm-ff-file-extension ((t (:extend t :foreground "white"))))
 '(helm-selection ((t (:underline nil :background "firebrick" :foreground "white"))))
 '(minibuffer-prompt ((t (:background "white" :foreground "#005f87"))))
 '(modus-themes-prompt ((t (:foreground "#005f87"))) t)
 '(org-block-end-line ((t (:background "#3a5a5f" :foreground "gray99"))))
 '(org-level-1 ((t (:family "Courier" :height 1.1 :weight bold))))
 '(org-level-2 ((t (:family "Courier" :height 1.1 :weight bold))))
 '(org-level-3 ((t (:weight bold :height 1.1))))
 '(org-level-4 ((t (:weight bold :height 1.1))))
 '(org-level-5 ((t (:weight bold :height 1.1))))
 '(org-level-6 ((t (:weight bold :height 1.1))))
 '(org-level-7 ((t (:weight bold :height 1.1))))
 '(org-level-8 ((t (:weight bold :height 1.1))))
 '(org-level-9 ((t (:weight bold :height 1.1))))
 '(region ((t (:background "gray50" :foreground nil))))
 '(telephone-line-projectile ((t (:inherit mode-line :foreground "burlywood1" :weight bold)))))
