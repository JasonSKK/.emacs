;;; create-next-meeting-notes-file --- 2024-05-13 02:15:09 pm
;; create-next-meeting-notes-file.el
;;
;; This Emacs Lisp function creates a new supervising meeting notes file with the next number in the directory
;; "~/Desktop/research-mres/meeting-notes/" and inserts the preamble text for easy org-latex to PDF export.
;;
;; The function retrieves the list of existing meeting notes files in the specified directory, extracts
;; the numerical part of each file name, finds the maximum number, and increments it by 1 to determine
;; the next file number. The current date is added to the file name in the format YYMMDD.
;;
;; The preamble text includes various Org mode options, such as TITLE, DATE, AUTHOR, EMAIL, LANGUAGE,
;; SELECT_TAGS, EXCLUDE_TAGS, CREATOR, and more. You can customize these options to suit your needs.
;;
;; To use this function, evaluate the code in Emacs Lisp or add it to your Emacs configuration file.
;;
;; Example usage:
;;   M-x create-next-meeting-notes-file
;;
;; License: GNU General Public License, v3.0
(defun create-next-meeting-notes-file ()
  "Create a new meeting notes file with the next number in the directory ~/Desktop/research-mres/meeting-notes/ and insert the preamble text."
  (interactive)
  (let ((directory "~/dsk/research-mres/meeting-notes/"))
    (when (file-exists-p directory)
      (let* ((files (directory-files directory nil "^[0-9]+_.*meeting-notes\\.org$" t))
             (next-number (1+ (apply #'max (mapcar (lambda (file) (string-to-number (substring file 0 2))) files))))
             (date (format-time-string "%Y-%m-%d"))
             (filename (concat directory (format "%02d_%s_meeting-notes.org" next-number (format-time-string "%y%m%d"))))
             (preamble (concat
                        "#+OPTIONS: ':nil *:t -:t ::t <:t H:3 \\n:nil ^:t arch:headline\n"
                        "#+OPTIONS: author:t broken-links:nil c:nil creator:nil\n"
                        "#+OPTIONS: d:(not \"LOGBOOK\") date:t e:t email:nil f:t inline:t num:t\n"
                        "#+OPTIONS: p:nil pri:nil prop:nil stat:t tags:t tasks:t tex:t\n"
                        "#+OPTIONS: timestamp:t title:t toc:t todo:t |:t\n"
                        (format "#+TITLE: Meeting notes %s\n" date)
                        (format "#+DATE: <%s>\n" date)
                        "#+AUTHOR: Jason SK\n"
                        "#+EMAIL: jsk@Jasons-MBP\n"
                        "#+LANGUAGE: en\n"
                        "#+SELECT_TAGS: export\n"
                        "#+EXCLUDE_TAGS: noexport\n"
                        "#+CREATOR: Emacs " emacs-version " (Org mode " org-version ")\n\n")))
        (find-file filename)
        (goto-char (point-min))
        (insert preamble)))))
(provide 'create-next-meeting-notes-file)
;;; 025_create-next-meeting-notes-file.el ends here
