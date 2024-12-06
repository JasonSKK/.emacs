;;; whitespace --- 2024-12-06  4:23:53 pm CET
  ;;; Commentary:
;;; turn off whitespace and turn on visual line modes,
;;; for these main modes:
;;; js, css, web, html, markdown, python, latex

(defun whitespace-off ()
  "Make turning whitespace mode off a command callable from key."
  (interactive)
  (whitespace-mode -1))
(add-hook 'markdown-mode-hook 'whitespace-off)
(add-hook 'css-mode-hook 'whitespace-off)
(add-hook 'html-mode-hook 'whitespace-off)
(add-hook 'web-mode-hook 'whitespace-off)
(add-hook 'js-mode-hook 'whitespace-off)
(add-hook 'python-mode-hook 'whitespace-off)
(add-hook 'latex-mode-hook 'whitespace-off)
(add-hook 'markdown-mode-hook 'visual-line-mode)
(add-hook 'css-mode-hook 'visual-line-mode)
(add-hook 'html-mode-hook 'visual-line-mode)
(add-hook 'web-mode-hook 'visual-line-mode)
(add-hook 'js-mode-hook 'visual-line-mode)
(add-hook 'python-mode-hook 'visual-line-mode)
(add-hook 'latex-mode-hook 'visual-line-mode)
(provide 'whitespace)
;;; 019_whitespace.el ends here
