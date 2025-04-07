;;; init.el --- Prelude's configuration entry point.
;;
;; Copyright (c) 2011-2023 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: https://github.com/bbatsov/prelude
;; Version: 1.1.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This file simply sets up the default load path and requires
;; the various modules defined within Emacs Prelude.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

(defvar prelude-user
  (getenv
   (if (equal system-type 'windows-nt) "USERNAME" "USER")))

(message "[Prelude] Prelude is powering up... Be patient, Master %s!" prelude-user)

(when (version< emacs-version "25.1")
  (error "[Prelude] Prelude requires GNU Emacs 25.1 or newer, but you're running %s" emacs-version))

;; Always load newest byte code
(setq load-prefer-newer t)

;; Define Prelude's directory structure
(defvar prelude-dir (file-name-directory load-file-name)
  "The root dir of the Emacs Prelude distribution.")
(defvar prelude-core-dir (expand-file-name "core" prelude-dir)
  "The home of Prelude's core functionality.")
(defvar prelude-modules-dir (expand-file-name  "modules" prelude-dir)
  "This directory houses all of the built-in Prelude modules.")
(defvar prelude-personal-dir (expand-file-name "personal" prelude-dir)
  "This directory is for your personal configuration.

Users of Emacs Prelude are encouraged to keep their personal configuration
changes in this directory.  All Emacs Lisp files there are loaded automatically
by Prelude.")
(defvar prelude-personal-preload-dir (expand-file-name "preload" prelude-personal-dir)
  "This directory is for your personal configuration, that you want loaded before Prelude.")
(defvar prelude-vendor-dir (expand-file-name "vendor" prelude-dir)
  "This directory houses packages that are not yet available in ELPA (or MELPA).")
(defvar prelude-savefile-dir (expand-file-name "savefile" user-emacs-directory)
  "This folder stores all the automatically generated save/history-files.")
(defvar prelude-modules-file (expand-file-name "prelude-modules.el" prelude-personal-dir)
  "This file contains a list of modules that will be loaded by Prelude.")

(unless (file-exists-p prelude-savefile-dir)
  (make-directory prelude-savefile-dir))

(defun prelude-add-subfolders-to-load-path (parent-dir)
  "Add all level PARENT-DIR subdirs to the `load-path'."
  (dolist (f (directory-files parent-dir))
    (let ((name (expand-file-name f parent-dir)))
      (when (and (file-directory-p name)
                 (not (string-prefix-p "." f)))
        (add-to-list 'load-path name)
        (prelude-add-subfolders-to-load-path name)))))

;; add Prelude's directories to Emacs's `load-path'
(add-to-list 'load-path prelude-core-dir)
(add-to-list 'load-path prelude-modules-dir)
(add-to-list 'load-path prelude-vendor-dir)
(prelude-add-subfolders-to-load-path prelude-vendor-dir)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; preload the personal settings from `prelude-personal-preload-dir'
(when (file-exists-p prelude-personal-preload-dir)
  (message "[Prelude] Loading personal configuration files in %s..." prelude-personal-preload-dir)
  (mapc 'load (directory-files prelude-personal-preload-dir 't "^[^#\.].*el$")))

(message "[Prelude] Loading Prelude's core modules...")

;; load the core stuff
(require 'prelude-packages)
(require 'prelude-custom)  ;; Needs to be loaded before core, editor and ui
(require 'prelude-ui)
(require 'prelude-core)
(require 'prelude-mode)
(require 'prelude-editor)
(require 'prelude-global-keybindings)

;; macOS specific settings
(when (eq system-type 'darwin)
  (require 'prelude-macos))

;; Linux specific settings
(when (eq system-type 'gnu/linux)
  (require 'prelude-linux))

;; WSL specific setting
(when (and (eq system-type 'gnu/linux) (getenv "WSLENV"))
  (require 'prelude-wsl))

;; Windows specific settings
(when (eq system-type 'windows-nt)
  (require 'prelude-windows))

(message "[Prelude] Loading Prelude's additional modules...")

;; the modules
(if (file-exists-p prelude-modules-file)
    (load prelude-modules-file)
  (message "[Prelude] Missing personal modules file %s" prelude-modules-file)
  (message "[Prelude] Falling back to the bundled example file sample/prelude-modules.el")
  (message "[Prelude] You should copy this file to your personal configuration folder and tweak it to your liking")
  (load (expand-file-name "sample/prelude-modules.el" prelude-dir)))

;; config changes made through the customize UI will be stored here
(setq custom-file (expand-file-name "custom.el" prelude-personal-dir))

;; load the personal settings (this includes `custom-file')
(when (file-exists-p prelude-personal-dir)
  (message "[Prelude] Loading personal configuration files in %s..." prelude-personal-dir)
  (mapc 'load (delete
               prelude-modules-file
               (directory-files prelude-personal-dir 't "^[^#\.].*\\.el$"))))

(message "[Prelude] Prelude is ready to do thy bidding, Master %s!" prelude-user)

;; Patch security vulnerability in Emacs versions older than 25.3
(when (version< emacs-version "25.3")
  (with-eval-after-load "enriched"
    (defun enriched-decode-display-prop (start end &optional param)
      (list start end))))

(prelude-eval-after-init
 ;; greet the use with some useful tip
 (run-at-time 5 nil 'prelude-tip-of-the-day))

;;================== SCLANG-MODE ===================
;;(add-to-list 'load-path "/usr/local/bin/sclang")
(require 'sclang)

;;-- open .scd files with sclang mode and auto complete
(setq auto-mode-alist (cons '("\\.scd$" . sclang-mode) auto-mode-alist))
;;(add-to-list 'load-path "~/.emacs.d/personal/packages/el")
;;(require 'sclang)
;;(setq auto-mode-alist (cons '("\\.scd$" . sclang-mode) auto-mode-alist))
(add-hook 'sclang-library-startup-hook
          (lambda () (and sclang-show-workspace-on-startup
                          (not (eq major-mode 'sclang-mode))
                          (sclang-switch-to-workspace))))

;; -------------------- START LIVE CODING --------------------
;; foxdot-mode
;;(add-to-list 'load-path (expand-file-name "personal/postload/foxdot-mode" "~/.emacs.d"))
;;(require 'foxdot-mode)
;;(add-to-list 'auto-mode-alist '("\\.foxdot)?$" . foxdot-mode))

;; tidal
;; (require 'package)
;; (add-to-list 'package-archives
;;              '("marmalade" .
;;                "http://marmalade-repo.org/packages/"))
;; (setq load-path (cons "~/tidal/" load-path))
;; (require 'tidal)
;; (setq tidal-interpreter "/Users/jsk/.ghcup/bin/ghci")
;; (setq tidal-boot-script-path "/Users/jsk/.atom/packages/tidalcycles/lib/BootTidal.hs")
;; -------------------- END LIVE CODING --------------------

;; -------------------- Emms player ------------------------
;; for access bin
(setq exec-path (append exec-path '("/usr/local/bin")))
;; path configuration
;; (add-to-list 'load-path "~/.emacs/elpa/emacs.d/elpa/emms-7.2")
;; (require 'emms-setup)
;; (require 'emms-player-vlc)
;; (emms-standard)
;; (emms-default-players)
;; (define-emms-simple-player mplayer'(file url)
;;  (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
;;                ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
;;                ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
;;  "mplayer" "-slave" "-quiet" "-really-quiet" "-fullscreen")
;; -------------------------------------------------------

;; GPG
(setenv "GPG_AGENT_INFO" nil)

;; Slime config sbcl
(setq inferior-lisp-program (executable-find "sbcl"))

;; tmux-collaborative-coding
(require 'server)
;; some systems don't auto-detect the socket dir, so specify it here and for the client:
(setq server-socket-dir "/tmp/emacs-shared")
;; start Emacs server mode
(server-start)

;; Load EAF Core
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
;; (require 'eaf)
;; Load EAF applications
;; (require 'eaf-browser)
;; (require 'eaf-pdf-viewer)
;; (require 'eaf-airshare)
;; (require 'eaf-camera)
;; (require 'eaf-demo)
;; (require 'eaf-file-browser)
;; (require 'eaf-file-manager)
;; (require 'eaf-file-sender)
;; (require 'eaf-image-viewer)
;; (require 'eaf-jupyter)
;; (require 'eaf-markdown-previewer)
;; ;;(require 'eaf-mermaid)
;; (require 'eaf-mindmap)
;; (require 'eaf-music-player)
;; (require 'eaf-org-previewer)
;; (require 'eaf-pdf-viewer)
;; (require 'eaf-system-monitor)
;; (require 'eaf-terminal)
;; (require 'eaf-video-player)
;; (require 'eaf-vue-demo)
;; (require 'eaf-netease-cloud-music)
;; (require 'eaf-rss-reader)

;; unbind helm-swoop keybinding -- because of search
;; (global-set-key (kbd "C-S-s") nil)

;; --- EMAIL ---
;;(add-to-list 'load-path (expand-file-name "personal/postload/emacs-outlook-compli-mode/" "~/.emacs.d"))
;;(require 'emacs-outlook-compli-mode)

;; solves epa-decrypt-region -- bug
(setf epa-pinentry-mode 'loopback)

;; set python interpreter path
(setq python-interpreter "/home/iason1/venv/python3/bin/python3")

;; Startup time
(defun efs/display-startup-time ()
  (message
   "Emacs loaded in %s with %d garbage collections."
   (format
    "%.2f seconds"
    (float-time
     (time-subtract after-init-time before-init-time)))
   gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; MATLAB mode
;; associate .m file with the matlab-mode (major mode)
;(add-to-list 'auto-mode-alist '("\\.m$" . matlab-mode))
;; setup matlab-shell
;;(setq matlab-shell-command "/Applications/MATLAB_R2020a.app/bin/matlab")
;;(setq matlab-shell-command-switches (list "-nodesktop"))

;; go-translate config
;; your languages pair used to translate

;; (require 'go-translate)
;; (setq gts-translate-list '(("en" "ru") ("ru" "en") ("el" "en") ("en" "el") ("de" "en") ("en" "de")))

;; ;; (setq gts-default-translator (gts-translator :engines (gts-bing-engine)))
;; (setq gts-default-translator
;;       (gts-translator
;;        :picker (gts-prompt-picker)
;;        :engines (list (gts-bing-engine) (gts-google-engine))
;;        :render (gts-buffer-render)))

;; plantuml config
;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)))

(setq org-plantuml-jar-path
      (expand-file-name "/home/iason1/bin/plantuml/plantuml-1.2025.2.jar"))

;; enable xclip-mode globally
(xclip-mode 1)
;; sync kill ring into system clipboard
(setq x-select-enable-clipboard t)

;; startup buffers
;; Split the window horizontally
(split-window-horizontally)
;; Open the scratch buffer on the left
(switch-to-buffer "*scratch*")

(set-frame-font "IBMPlexMono" nil t)

;: Enable gccjit in Emacs
;; gccjit (GNU Compiler Collection Just-In-Time compilation) allows Emacs to natively compile Elisp code into machine code for improved performance.
(setq native-comp-async-report-warnings-errors 'silent)
(setq native-comp-speed 3)
(setq native-comp-deferred-compilation t)
(setq package-native-compile t)


(provide 'init)

;;; init.el ends here
