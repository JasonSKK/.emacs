;;; fullscreen_toggle_and_native_use --- 2024-05-13 02:15:03 pm
;;; Commentary:
;;; enable native fullscreen mode and define key for toggling.

;;; Code:
(setq ns-use-native-fullscreen nil)
(global-set-key (kbd "H-t") 'toggle-frame-fullscreen)
(provide 'fullscreen_toggle_and_native_use)
;;; 002_fullscreen_toggle_and_native_use.el ends here
