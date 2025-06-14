;;; org-el-untangle --- Exported from Org Mode
;;; 2025-06-14  7:34:07 pm CEST

    ;;; Commentary:
    ;;; org-el-untangle:
    ;;; import muliple el files from one folder into one org mode file.
    ;;; org-el-tangle-sections
    ;;; export each sections' emacs-lisp block to a separate file.

    ;;; Code:
  (defvar org-el-export-counter 0
    "Counter for numbering exported emacs-lisp sections.")

  (defun org-el-import-all-files (directory)
    "Import muliple el files from one folder into one org mode file."
    (interactive "D")
    (let
        ((filename (concat "MASTER-FILE-" (format-time-string "%y%m%d") ".org"))
         (files (file-expand-wildcards (concat directory "*.el")))
         (target-buffer))
      ;; (message (concat (file-truename directory) filename))
      (find-file filename)
      (erase-buffer)
      (setq target-buffer (current-buffer))
      (insert "#+STARTUP: overview\n")
      (goto-char (point-max))
      (mapc 'org-el-import-1-file files)))
  (defun org-el-import-1-file (fname)
    "Insert file FNAME into the master org file.
    Create org header and SRC block from data in FNAME file."
    (message fname)
    (save-excursion
      (let*
          ((fname-base (substring (file-name-base fname) 4 nil))
           found body-start body-end body)
        (find-file fname)
        (goto-char (point-min)) ;; in case we are already editing the buffer!
        (setq found
              (search-forward fname-base (line-end-position 1) t 1))
        (cond
         (found
          (forward-line 1)
          (setq body-start (point)))
         (t (setq body-start (point-min))))
        (setq found
              (search-forward (format "provide '%s" fname-base) nil t 1))
        (cond
         (found (setq body-end (line-beginning-position)))
         (t (setq body-end (point-max))))
        (setq body (buffer-substring body-start body-end))
        (kill-buffer (current-buffer))
        (with-current-buffer target-buffer
          (goto-char (point-max))
          (insert (replace-regexp-in-string
                   "  " " "
                   (format "\n* %s\n"
                           (replace-regexp-in-string "_" " " fname-base))))
          (insert "\n#+BEGIN_SRC emacs-lisp\n")
          (insert body)
          (insert "#+END_SRC")))))
  (defun org-el-export-all-sections ()
    "Export each sections' emacs-lisp block to a separate file.
    Add header and footer parts required by flycheck."
    (interactive)
    (let
        ((index 0)
         (root-dir (file-name-directory (buffer-file-name)))
         buffers)
    ;;; First delete old entries, before creating new ones.
    ;;; Prevent duplicate entries due to renumbering.
      (mapc 'delete-file (file-expand-wildcards (concat root-dir "*.el")))
      (org-map-entries 'org-el-export-1-section)
      (mapc 'kill-buffer buffers))
    (setq org-el-export-counter 0))
  (defun org-el-export-1-section ()
    "Export the first emacs-lisp block in the current section to a separate file.
  Adds necessary headers and footers for Flycheck. Skips COMMENT sections."
    (interactive)
    (let* ((element (org-element-at-point)) ;; Get the element at point
           (title (org-get-heading t t t t)) ;; Fetch the title safely
           (commented (org-element-property :commentedp element)) ;; Check if commented
           filename body-element)

      ;; Skip commented sections
      (unless commented
        (setq org-el-export-counter (+ org-el-export-counter 1)) ;; Increment global counter

        ;; Get the current subtree content
        (let ((section-end (org-element-property :end element))
              (section-start (org-element-property :begin element)))
          (setq body-element
                (org-element-map (org-element-parse-buffer) 'src-block
                  (lambda (src)
                    (when (and (string= (org-element-property :language src) "emacs-lisp")
                               (> (org-element-property :begin src) section-start)
                               (< (org-element-property :begin src) section-end))
                      src))
                  nil t)))) ;; Stop after first match

      (if (not body-element)
          (message "WARNING: No valid emacs-lisp src block found in section: %s" title)
        (progn
          ;; Sanitize title for filename
          (setq title (replace-regexp-in-string "[^a-zA-Z0-9_-]" "_" title))
          (setq filename (format "%03d_%s.el" org-el-export-counter title))

          ;; Create and write to file
          (with-temp-buffer
            (insert (format ";;; %s --- Exported from Org Mode\n" title))
            (insert (format ";;; %s\n\n" (format-time-string "%F %r")))
            (insert (org-element-property :value body-element)) ;; Extract correct code
            (insert (format "\n(provide '%s)\n;;; %s ends here\n" title filename))
            (write-file filename))

          (message "Exported section '%s' to file: %s" title filename)))))
  (eval-after-load 'org
    '(progn
       ;; Note: This keybinding is in analogy to the default keybinding:
       ;; C-c . -> org-time-stamp
       (define-key org-mode-map (kbd "C-c C-M-e") 'org-el-export-all-sections)))

(provide 'org-el-untangle)
;;; 004_org-el-untangle.el ends here
