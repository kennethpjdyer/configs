;; Emacs Configuration File


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General Configurations

;; Disable Toolbar
(setq tool-bar-mode -1)

;; Customization File
(setq custom-file "~/.emacs.d/custom.el")  
(load custom-file)

;; Abbrev File
(setq abbrev-file-name
      "~/.emacs.d/abbrev_defs")
(setq save-abbrevs t)

;; Buffer Modification
(add-to-list 'load-path "~/.emacs.d/elpa/modtime-skip-mode-0.9/")
(load "modtime-skip-mode")
(setq modtime-skip-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Formating Configurations
;; Line Numbers
(global-linum-mode 1)

;; Line Height
(setq-default line-spacing 10)

;; Package Management
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t )
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/" ) t)
(package-initialize)


;; reST hook to start minor modes
(add-hook 'rst-mode-hook
	  '(lambda ()
	     (flyspell-mode)
	     (visual-line-mode)
	     (adaptive-wrap-prefix-mode nil)
))

;; DBus support
(require 'dbus)
(require 'zeitgeist)

;; Weblogger Setup
(require 'xml-rpc)
(require 'weblogger)
(defun DE-org-export-weblogger()
  (interactive)
  (let ((tmpbuffer (get-buffer-create " *org html export*"))
	title text)
    ;; export posting to HTML, but without headers
    (org-export-as-html 1 nil nil tmpbuffer t)
    (set-buffer tmpbuffer)
    (goto-char (point-min))
    ;;get title
    (when (re-search-forward "<div id=\"outline-container-1\" class=\"outline-2\">[^\0]*\
<h2 id=\"sec-1\">\\(.*?\\)</h2>[^\0]*\
<div class=\"outline-text-2\" id=\"text-1\">"
			     nil t)
      (setq title (match-string 1))
      (replace-match ""))
    ;; get the posting
    (setq text (buffer-substring-no-properties (point) (point-max)))
    (weblogger-start-entry)
    (insert title)
    (goto-char (point-max))
    (insert text)
    (kill-buffer tmpbuffer)))


