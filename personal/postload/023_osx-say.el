;;; osx-say --- 2024-05-13 02:15:09 pm

;; Copyright ShingoFukuyama
;; Original code: https://gist.github.com/ShingoFukuyama/7986889

;; Modified version by Iason SK

;;; Commentary:
;; Region lines and then `M-x osx-say' to make OSX speak.
;; Changed by Iason SK
;; osx-say is defined in another function.  Every time the
;; function is invoked it either speaks or kills the say
;; process & buffer

;;; Code:

;; Adjust speak(defun osx-say-stop ()) speed
(setq osx-say-speed 180)
;; Change voice
;; Kathy, Vicki, Victoria, Alex, Bruce, Fred
(setq osx-say-voice "Daniel")
(setq osx-say-buffer "*osx say*")
(defun osx-say-stop ()
  ;; (interactive)
  (when (get-buffer osx-say-buffer)
    (kill-buffer osx-say-buffer)))
(defun osx-say-start (&optional $word $speed)
  "Utilize `say' command that Mac OSX has."
  ;; (interactive)
  (unless (executable-find "say")
    (error (message "`say' command not found")))
  (osx-say-stop)
  (cond ($word $word)
        (mark-active
         (setq $word (buffer-substring-no-properties
                      (region-beginning) (region-end))))
        ((setq $word (thing-at-point 'word)))
        (t (setq $word (read-string "word: "))))
  (mapc (lambda ($r)
          (setq $word (replace-regexp-in-string (car $r) (cdr $r) $word)))
        (list ;;'("'"   . "\\\\'")
              '("\""  . "\\\\\"")
              '("?"   . "\\\\?")
              '("\n"  . " ")
              '("\("  . "\\\\(")
              '("\)"  . "\\\\)")
              '("\\[" . "\\\\[")
              '("\\]" . "\\\\]")
              '("\;"  . "\\\\;")
              '("\&"  . "\\\\&")
              '("\|"  . "\\\\|")))
  (save-window-excursion
    (start-process "OSX Say" osx-say-buffer
                   "say" "-v" osx-say-voice "-r"
                   (number-to-string (or $speed osx-say-speed)) $word)))
;;; 2022-12-17 1:03 AM -- Iason SK
;; start quit using same keybinding
(defun osx-say ()
  (interactive)
  (if (get-buffer-process "*osx say*") ;; if there is a buffer
      (let ((kill-buffer-query-functions nil)) ;; without confirmation ...
        (kill-buffer "*osx say*")) ;; kill the buffer ...
    (osx-say-start))) ;; otherwise evaluate function osx-say

;; set to C-l x
(global-set-key (kbd "C-l x") 'osx-say)
(provide 'osx-say)
;;; 023_osx-say.el ends here
