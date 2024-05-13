;;; SuperCollider --- 2024-05-13 02:15:04 pm
;;; Commentary:
;; Basic setup for using SuperCollider in EMACS

;; (add-to-list 'load-path "~/.emacs.d/personal/packages/sclang/")
;; (load-file "~/.emacs.d/personal/packages/sclang/sclang.el")
;; (load-file "~/.emacs.d/personal/packages/sc-snippets/sc-snippets.el")
(require 'sclang) ;; must be made available through links in personal/packages
;; (require 'sc-snippets) ;; replaced by postload file

;;; Directory of SuperCollider support, for quarks, plugins, help etc.
(defvar sc_userAppSupportDir
  (expand-file-name "~/Library/Application\ Support/SuperCollider"))
;; Make path of sclang executable available to emacs shell load path

;; For Version 3.6.6:
(add-to-list
 'exec-path
 "/Applications/SuperCollider.app/Contents/MacOS")
;;Before
;;/Applications/SuperCollider.app/Contents/Resources/sclang

;; For Version 3.7:
(add-to-list
 'exec-path
 "/Applications/SuperCollider.app/Contents/MacOS/")
;; Global keyboard shortcut for starting sclang
(global-set-key (kbd "C-c M-s") 'sclang-start)
;; overrides alt-meta switch command
(global-set-key (kbd "C-c W") 'sclang-switch-to-workspace)
;; post buffer
;; start-sclang with post window on the right
;;(defun sclang-move-post-buffer-right ()
;; (let* ((current-buffer-name (buffer-name))
;;         (post-buffer (get-buffer "*SCLang:PostBuffer*")))
;;  (switch-to-buffer-other-window current-buffer-name)
;;  (delete-other-windows)
;;  (split-window-horizontally)
;;  (switch-to-buffer-other-window "*SCLang:PostBuffer*")
;;  (other-window 2))
;;
;;(defun sclang-start-right ()
;;  (interactive)
;;  (sclang-start)
;;  (sclang-move-post-buffer-right))
;;
;;(global-set-key (kbd "C-c C-o") 'sclang-start-right)
;;
(provide 'SuperCollider)
;;; 008_SuperCollider.el ends here
