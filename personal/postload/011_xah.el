;;; xah --- Exported from Org Mode
;;; 2025-02-25 10:08:39 pm CET

  ;; copy current buffer path
  (defun xah-copy-file-path (&optional DirPathOnlyQ)
    "Copy current buffer file path or dired path.
  Result is full path.
  If `universal-argument' is called first, copy only the dir path.
  If in dired, copy the current or marked files.
  If a buffer is not file and not dired, copy value of `default-directory'.
  URL `http://xahlee.info/emacs/emacs/emacs_copy_file_path.html'
  Version 2018-06-18 2021-09-30"
    (interactive "P")
    (let (($fpath
           (if (string-equal major-mode 'dired-mode)
               (progn
                 (let (($result (mapconcat 'identity (dired-get-marked-files) "\n")))
                   (if (equal (length $result) 0)
                       (progn default-directory )
                     (progn $result))))
             (if (buffer-file-name)
                 (buffer-file-name)
               (expand-file-name default-directory)))))
      (kill-new
       (if DirPathOnlyQ
           (progn
             (message "Directory copied: %s" (file-name-directory $fpath))
             (file-name-directory $fpath))
         (progn
           (message "File path copied: %s" $fpath)
           $fpath )))))
  ;; open file with external app e.g. *txt with TextEdit
  ;; disable the exact same function by prelude
  ;; (global-unset-key (kbd "C-c o"))
  ;; xah code
  (defun xah-open-in-external-app (&optional @fname)
    "Open the current file or dired marked files in external app.
  When called in emacs lisp, if @fname is given, open that.
  URL `http://xahlee.info/emacs/emacs/emacs_dired_open_file_in_ext_apps.html'
  Version 2019-11-04 2021-02-16"
    (interactive)
    (let* (
           ($file-list
            (if @fname
                (progn (list @fname))
              (if (string-equal major-mode "dired-mode")
                  (dired-get-marked-files)
                (list (buffer-file-name)))))
           ($do-it-p (if (<= (length $file-list) 5)
                         t
                       (y-or-n-p "Open more than 5 files? "))))
      (when $do-it-p
        (cond
         ((string-equal system-type "windows-nt")
          (mapc
           (lambda ($fpath)
             (shell-command (concat "PowerShell -Command \"Invoke-Item -LiteralPath\" " "'" (shell-quote-argument (expand-file-name $fpath )) "'")))
           $file-list))
         ((string-equal system-type "darwin")
          (mapc
           (lambda ($fpath)
             (shell-command
              (concat "open " (shell-quote-argument $fpath))))  $file-list))
         ((string-equal system-type "gnu/linux")
          (mapc
           (lambda ($fpath) (let ((process-connection-type nil))
                              (start-process "" nil "xdg-open" $fpath))) $file-list))))))
  (defun xah-beginning-of-line-or-block ()
    "Move cursor to beginning of line or previous paragraph.
  • When called first time, move cursor to beginning of char in current line. (if already, move to beginning of line.)
  • When called again, move cursor backward by jumping over any sequence of whitespaces containing 2 blank lines.
  URL `http://xahlee.info/emacs/emacs/emacs_keybinding_design_beginning-of-line-or-block.html'
  Version 2017-05-13"
    (interactive)
    (let (($p (point)))
      (if (or (equal (point) (line-beginning-position))
              (equal last-command this-command ))
          (if (re-search-backward "\n[\t\n ]*\n+" nil "NOERROR")
              (progn
                (skip-chars-backward "\n\t ")
                (forward-char ))
            (goto-char (point-min)))
        (progn
          (back-to-indentation)
          (when (eq $p (point))
            (beginning-of-line))))))
  (defun xah-end-of-line-or-block ()
    "Move cursor to end of line or next paragraph.
  • When called first time, move cursor to end of line.
  • When called again, move cursor forward by jumping over any sequence of whitespaces containing 2 blank lines.
  URL `http://xahlee.info/emacs/emacs/emacs_keybinding_design_beginning-of-line-or-block.html'
  Version 2017-05-30"
    (interactive)
    (if (or (equal (point) (line-end-position))
            (equal last-command this-command ))
        (progn
          (re-search-forward "\n[\t\n ]*\n+" nil "NOERROR" ))
      (end-of-line)))

  ;; define keybindings
  (global-set-key (kbd "C-c x") 'xah-copy-file-path)
  (global-set-key (kbd "C-c o") 'xah-open-in-external-app)
  (global-set-key (kbd "C-a") 'xah-beginning-of-line-or-block) ;; replaces (crux-move-beginning-of-line ARG)
  (global-set-key (kbd "C-e") 'xah-end-of-line-or-block) ;; replaces (move-end-of-line ARG)


(provide 'xah)
;;; 011_xah.el ends here
