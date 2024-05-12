;;; personal-latex-commands --- 2024-05-12 08:43:35 pm
;;  async compile current latex document with references and open it with external app
(defun async-compile-latex-file-open-external ()
  (interactive)
  (let* ((tex-file (buffer-file-name))
         (pdf-file (concat (file-name-sans-extension tex-file) ".pdf"))
         (bib-file (concat (file-name-sans-extension tex-file) ".bib"))
         (bib-command (when (file-exists-p bib-file) "bibtex"))
         (command (concat "pdflatex -interaction=batchmode " tex-file "; " "pdflatex -interaction=batchmode " tex-file "; "
                          (when bib-command
                            (concat "bibtex " (file-name-sans-extension tex-file) "; "
                                    "pdflatex -interaction=batchmode " tex-file "; "))
                          "open " pdf-file)))
    (shell-command command)))
(add-hook 'latex-mode-hook
          (lambda ()
          (local-set-key (kbd "C-l 0") 'async-compile-latex-file-open-external)))

;; word count latex
(defun latex-word-count ()
  (interactive)
  (shell-command (concat "/Library/TeX/texbin/texcount "
                         ; "uncomment then options go here "
                         (buffer-file-name))))
(provide 'personal-latex-commands)
;;; 011_personal-latex-commands.el ends here
