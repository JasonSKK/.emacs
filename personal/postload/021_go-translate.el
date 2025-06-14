;;; go-translate --- Exported from Org Mode
;;; 2025-06-14  7:34:08 pm CEST

  ;; go-translate v3 configuration
  (require 'go-translate)

  ;; Define preset translators (recommended)
  (setq gt-default-translator
        (gt-translator
         :taker   (gt-taker :langs '(de en el ru) :text 'buffer :pick 'paragraph)
         :engines (list (gt-bing-engine) (gt-google-engine))
         :render  (gt-buffer-render)))

  ;; Optional: Set a default translator (if you don't want to use the first preset as default)
  ;; If gt-default-translator is nil, the first preset in gt-preset-translators will be used.
  ;; (setq gt-default-translator nil) ;; or you can set it to one of the preset translator

  ;; Example of setting a default translator
  ;; (setq gt-default-translator
  ;;       (gt-translator
  ;;        :taker (gt-taker :langs '(en ru))
  ;;        :engines (list (gt-bing-engine) (gt-google-engine))
  ;;        :render (gt-buffer-render)))

  ;; Optional: Configure global languages (used if taker doesn't specify langs)
  ;; (setq gt-langs '(en ru))

  ;; Optional: Configure taker defaults (if you want to change the default behavior)
  ;; (setq gt-taker-text 'word)      ; Default: word under cursor
  ;; (setq gt-taker-pick 'paragraph) ; Default: split by paragraphs
  ;; (setq gt-taker-prompt nil)      ; Default: no prompt

  ;; Optional: Configure default HTTP client (plz.el with curl is recommended)
  ;; (require 'plz) ;; Ensure plz is loaded

  ;; (setq gt-default-http-client
  ;;       (gt-plz-http-client :args '("--proxy" "socks5://127.0.0.1:9999")))

  ;; Optional: Configure default cache
  ;; (setq gt-cache-p t) ;; Enable global cache, or disable it.
  ;; (setq gt-default-cacher (gt-memory-cacher :if 'word)) ;; only cache words.

  ;; Example of using gt-insert-render
  ;; (setq gt-default-translator
  ;;       (gt-translator
  ;;        :taker (gt-taker :text 'paragraph :pick nil)
  ;;        :engines (gt-google-engine)
  ;;        :render (gt-insert-render :type 'replace)))

  ;; Example of using gt-overlay-render
  ;; (setq gt-default-translator
  ;;       (gt-translator
  ;;        :taker (gt-taker :text 'buffer :pick 'word :pick-pred (lambda (w) (length> w 5)))
  ;;        :engines (gt-google-engine)
  ;;        :render (gt-overlay-render :type 'help-echo)))

  ;; Example of using gt-posframe-pop-render
  ;; (require 'posframe) ;;Ensure posframe is installed
  ;; (setq gt-default-translator
  ;;       (gt-translator
  ;;        :taker (gt-taker :text 'word)
  ;;        :engines (gt-google-engine)
  ;;        :render (gt-posframe-pop-render)))

  ;; Example of using gt-stardict-engine
  ;; (setq gt-default-translator
  ;;       (gt-translator
  ;;        :engines (gt-stardict-engine
  ;;                  :dir "~/.stardict/dic"
  ;;                  :dict "dict-name"
  ;;                  :exact t)
  ;;        :render (gt-buffer-render)))

  ;; Example of using gt-deepl-engine
  ;; (setq gt-default-translator
  ;;       (gt-translator
  ;;        :engines (gt-deepl-engine :key "***")
  ;;        :render (gt-buffer-render)))

  ;; Example of using gt-chatgpt-engine
  ;; (setq gt-chatgpt-key "YOUR-KEY") ;; or in your .authinfo
  ;; (setq gt-default-translator
  ;;       (gt-translator
  ;;        :engines (gt-chatgpt-engine :stream t)
  ;;        :render (gt-buffer-render)))

  ;; Example of using gt-text-utility
  ;; (defun my-generate-qr ()
  ;;   (interactive)
  ;;   (gt-start (gt-translator
  ;;              :engines (gt-text-utility :type 'qrcode)
  ;;              :render (gt-buffer-render))))

(provide 'go-translate)
;;; 021_go-translate.el ends here
