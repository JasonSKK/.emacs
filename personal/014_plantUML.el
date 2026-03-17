;; plantUML --- Exported from Org Mode
;; 2026-03-17  3:19:10 pm CET


  ;; active Org-babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(;; other Babel languages
     (plantuml . t)))

  ;; set path plantuml lib
  (setq org-plantuml-jar-path
        (expand-file-name "~/bin/plantuml/plantuml-1.2025.2.jar"))


(provide 'plantUML)
;; 014_plantUML.el ends here
