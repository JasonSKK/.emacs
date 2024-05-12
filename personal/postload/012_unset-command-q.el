;;; unset-command-q --- 2024-05-12 08:43:35 pm
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 012_unset-command-q.el ends here
