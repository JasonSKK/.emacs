;;; whitespace_and_visual_line_fixes --- 2024-05-13 02:15:03 pm
;;; Commentary:
;;; turn off whitespace and turn on visual line modes,
;;; for these main modes:
;;; js, css, web, html, markdown

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
(provide 'whitespace_and_visual_line_fixes)
;;; 005_whitespace_and_visual_line_fixes.el ends here
