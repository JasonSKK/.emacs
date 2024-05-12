;;; anna-iason --- 2024-05-12 08:43:38 pm
(defun anna-iason-time-together ()
  "Calculate the number of years, months, and days between the start date (Feb 16, 2017) and today's date, including both dates."
  (interactive)
  (let* ((start-date (encode-time 0 0 0 16 2 2017))
         (end-date (current-time))
         (time-diff (time-subtract end-date start-date))
         (years (floor (/ (float-time time-diff) 31557600)))
         (months (floor (/ (mod (float-time time-diff) 31557600) 2629800)))
         (days (floor (/ (mod (float-time time-diff) 2629800) 86400)))
         (total-days (floor (/ (float-time time-diff) 86400))))
    (message "We have been together for %d years, %d months, and %d days. (%d days in total)" years months days total-days)))
(provide 'anna-iason)
;;; 024_anna-iason.el ends here
