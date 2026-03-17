;; notmuch-lieer-sync --- Exported from Org Mode
;; 2026-03-17  3:19:10 pm CET


;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Lexical-Binding.html
(require 'subr-x)

(defvar notmuch-sync--process nil
  "Current notmuch sync process.")

(defun notmuch-sync ()
  "Run `notmuch new` asynchronously and log to *notmuch-sync*."
  (interactive)
  (when (process-live-p notmuch-sync--process)
    (user-error "Notmuch sync already running"))

  (let ((outbuf (get-buffer-create "*notmuch-sync*")))
    (with-current-buffer outbuf
      (erase-buffer)
      (insert (format "[%s] starting: notmuch new\n\n"
                      (format-time-string "%Y-%m-%d %H:%M:%S"))))

    (setq notmuch-sync--process
          (make-process
           :name "notmuch-sync"
           :buffer outbuf
           :command (list "notmuch" "new")
           :noquery t
           :sentinel
           (lambda (proc event)
             (when (memq (process-status proc) '(exit signal))
               (let* ((code (process-exit-status proc))
                      (buf (process-buffer proc)))
                 (setq notmuch-sync--process nil)
                 (notmuch-refresh-this-buffer)
                 (when (buffer-live-p buf)
                   (with-current-buffer buf
                     (goto-char (point-max))
                     (insert (format "\n[%s] finished: %s (exit %d)\n"
                                     (format-time-string "%Y-%m-%d %H:%M:%S")
                                     (string-trim event)
                                     code))))
                 (if (eq code 0)
                     (message "Notmuch sync OK")
                   (when (buffer-live-p buf)
                     (display-buffer buf))
                   (message "Notmuch sync FAILED, see *notmuch-sync*")))))))))

;; view html part in browser
;; mapped to ".v" in elpa/notmuch-20240406.1803/notmuch-show.el
(defun notmuch-show-view-html+ ()
  "Open the text/html part of the current message using `notmuch-show-view-part' and bring Firefox to the foreground."
  (interactive)
  (save-excursion
    ;; Navigate to the text/html part
    (goto-char
     (prop-match-beginning
      (text-property-search-forward
       :notmuch-part
       "text/html"
       (lambda (value notmuch-part)
         (equal (plist-get notmuch-part :content-type)
                value)))))
    ;; View the part in an external browser
    (let ((url (notmuch-show-view-part)))
      ;; After a short delay, bring Firefox to the foreground using wmctrl
      (start-process "wmctrl-focus-firefox" nil "sh" "-c"
                     "sleep 0.5 && wmctrl -a Firefox"))))
;; overwrite default
(with-eval-after-load 'notmuch
  (define-key notmuch-show-part-map "v" 'notmuch-show-view-html+))

(defun notmuch-batch-tag-per-email ()
  "Batch sorts ko00 & gmail"
  (interactive)
  (shell-command "notmuch tag --batch <<EOM
        +gmail -- to:jason.skk98@gmail.com
        +work -- to:"iason.svoronoskanavas@gmail.com" <iason.svoronoskanavas@gmail.com>
        +windowslive -- to:ko00@windowslive.com
        EOM"))

;; mapped to ". l" in elpa/notmuch-20240406.1803/notmuch-show.el
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
(with-eval-after-load 'notmuch
  (define-key notmuch-show-part-map "l" 'notmuch-show-jump-to-latest))

;; notmuch-sync hook
(add-hook 'notmuch-search-mode-hook
          '(lambda ()
             (define-key notmuch-search-mode-map (kbd ".") 'notmuch-sync)))

;; disable wrap, characters
(add-hook 'notmuch-mode (turn-off-auto-fill))
(add-hook 'notmuch-message-mode (turn-off-auto-fill))
(add-hook 'notmuch-message-mode-hook (lambda () (auto-fill-mode -1)))

;; notmuch auto-load
(autoload 'notmuch "notmuch" "notmuch mail" t)
(global-set-key (kbd "C-l n") 'notmuch)

;; Sign Emails
;;(setq mml-secure-openpgp-sign-with-sender t)
;; Sign messages by default.
;;(add-hook 'message-setup-hook 'mml-secure-sign-pgpmime)

;; SMTP Settings
(setq message-directory "~/.mail")
;; set up smtpmail
(require 'smtpmail)
;; Set the SMTP server and port
(setq smtpmail-smtp-server "smtp.gmail.com")
;; Enable STARTTLS / SSL/TLS
(setq smtpmail-smtp-servicetpmail-smtp-service 587)
(setq smtpmail-stream-type 'starttls)
;; (setq smtpmail-smtp-service 465) ;; unsafe TLS
;; (setq smtpmail-stream-type 'tls)
;; make sure smtpmail reads from .authinfo
(setq smtpmail-auth-credentials (expand-file-name "~/.authinfo"))
;; use smptmail-send-it
(setq message-send-mail-function 'smtpmail-send-it)

;; send email from multiple accounts
(setq message-sendmail-envelope-from 'header)
(setq message-alternative-emails
      '("jason.skk98@gmail.com" "iason.svoronoskanavas@gmail.com"))
(setq notmuch-always-prompt-for-sender t)

;; specify save drafts
(setq message-auto-save-directory "~/.mail/drafts")
(setq message-draft-headers "Subject:")

;; Automatically collapse certain MIME types in notmuch-show and message mode
(setq mm-inline-override-types '("text/x-diff"
                                 "text/x-patch"
                                 ;; "application/pdf"
                                 ;; "application/octet-stream"
                                 "image/jpeg"
                                 "image/png"
                                 ;; "application/zip"
                                 ))

;; dynamically setting smtp server
(defun my-set-smtp-server ()
  "Set the SMTP server and user based on the From address."
  (let ((from (message-fetch-field "from")))
    (cond
     ;; Primary email account
     ((string-match "iason.svoronoskanavas@gmail.com" from)
      (setq smtpmail-smtp-user "iason.svoronoskanavas@gmail.com"
            smtpmail-smtp-server "smtp.gmail.com"
            smtpmail-smtp-service 587))
     ;; Other email account
     ((string-match "jason.skk98@gmail.com" from)
      (setq smtpmail-smtp-user "jason.skk98@gmail.com"
            smtpmail-smtp-server "smtp.gmail.com"
            smtpmail-smtp-service 587)))))
(add-hook 'message-send-hook 'my-set-smtp-server)



(provide 'notmuch-lieer-sync)
;; 009_notmuch-lieer-sync.el ends here
