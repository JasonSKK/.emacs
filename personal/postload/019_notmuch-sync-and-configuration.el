;;; notmuch-sync-and-configuration --- 2024-05-13 02:15:08 pm
;; shell command output no window
(defun no-output-shell-run (command)
  "Run shell COMMAND without displaying the output.  First ARG is COMMAND."
  (interactive (list (read-shell-command "$ ")))
  (start-process-shell-command command nil command))
;; sync notmuch using lieer and notmuch new
(defun notmuch-sync ()
  "Syncs notmuch using lieer.  ARG empty: Configuration file is /Users/jsk/Mail/gmi-sync.sh."
  (interactive)
  (let ((lnr (line-number-at-pos))) ;; register cursor line number
  ;; synching config replaced by /Users/jsk/Mail/.notmuch/hooks/pre-new, now with 'notmuch new' lieer fetches and pushes
  (no-output-shell-run "notmuch new")
  ;; (no-output-shell-run "pushd /Users/jsk/Mail ; gmi sync ; popd ; notmuch new")
  ;; (no-output-shell-run "notmuch tag +work -- tag:new and to:iason.svoronoskanavas@gmail.com ; notmuch tag +gmail -- tag:new and to:jason.skk98@gmail.com")
    ;; "&& notmuch tag +gmail -- tag:new and to:jason.skk98@gmail.com && notmuch tag +windowslive -- tag:new and to:ko00@windowslive.com" ;; is in /Users/jsk/Mail/.notmuch/hooks/pre-new
    (notmuch-refresh-this-buffer) ;; refresh this buffer to reduce lag
    ;; (notmuch-refresh-all-buffers) ;; refresh all not much buffers ;; old version
    (goto-line lnr) ;; go to registered line number
    (message "notmuch & lieer on sync")))
(defun notmuch-batch-tag-per-email ()
  "Batch sorts ko00 & gmail"
  (interactive)
  (no-output-shell-run "notmuch tag --batch <<EOM
  +gmail -- to:jason.skk98@gmail.com
  +work -- to:"iason.svoronoskanavas@gmail.com" <iason.svoronoskanavas@gmail.com>
  +windowslive -- to:ko00@windowslive.com
  EOM"))
(defun notmuch-show-jump-to-latest ()
  "Jump to the message in the current thread with the latest
timestamp."
  (interactive)
  (let ((timestamp 0)
	latest)
    (notmuch-show-mapc
     (lambda () (let ((ts (notmuch-show-get-prop :timestamp)))
		  (when (> ts timestamp)
		    (setq timestamp ts
			  latest (point))))))
    (if latest
	(goto-char latest)
      (error "Cannot find latest message."))))
;; global, it syncs email database even without notmuch buffer open
;; (global-set-key (kbd "C-l s") 'notmuch-sync) ;; global ;; prefix for slack C-l s ...

;; notmuch hooks
(add-hook 'notmuch-search-mode-hook
          '(lambda ()
          (define-key notmuch-search-mode-map (kbd ".") 'notmuch-sync)))

;; disable wrap, characters
(add-hook 'notmuch-mode (turn-off-auto-fill))
(add-hook 'notmuch-message-mode (turn-off-auto-fill))
(add-hook 'notmuch-message-mode-hook (lambda () (auto-fill-mode -1)))


;; mode specific notmuch-hello-mode -- fetch email every 25 sec
;;(add-hook 'notmuch-hello-mode-hook
;;          '(lambda ()
             ;;(run-with-timer 0 notmuch-sync-period  ;; every 25 sec do:
                             ;;'(lambda ()
;;                                (if
;;                                    (get-buffer "*notmuch-hello*")  ;; if notmuch buffer exists fetch email
;;                                    (no-output-shell-run "cd /Users/jsk/Mail ; gmi sync ; notmuch new")
;;)))
                                    ;; (no-output-shell-run "pushd /Users/jsk/Mail && gmi sync && popd && notmuch new && notmuch-hooks.sh") ;; auto-tag gmail
                                  ;;(cancel-function-timers "no-output-shell-run"))))))  ;; cancel timer if buffer does not exist
;;  post hooks notmuch
;; (add-hook 'notmuch-new-hook #'(lambda () (start-process-shell-command "notmuch-hooks" nil "/Users/jsk/scripts/notmuch-hooks.sh")))

;; NOTMUCH
;; notmuch auto-load
(autoload 'notmuch "notmuch" "notmuch mail" t)
(global-set-key (kbd "C-l n") 'notmuch)
;; sign emails
;;(setq mml-secure-openpgp-sign-with-sender t)
;; Sign messages by default.
;;(add-hook 'message-setup-hook 'mml-secure-sign-pgpmime)
;; fetch email on startup
(no-output-shell-run "pushd /Users/jsk/Mail ; gmi sync ; popd ; notmuch new")
;; fetch email period
(setq notmuch-sync-period 25) ;; every 25 sec
;; set port SMTP server
(setq smtpmail-smtp-service 587)
(provide 'notmuch-sync-and-configuration)
;;; 019_notmuch-sync-and-configuration.el ends here
