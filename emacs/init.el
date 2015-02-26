;; Emacs Configuration File


;; Line Numbers
(global-linum-mode 1)

;; Buffer Modification
(setq load-library 'modtime-skip-mode)

;; Customization File
(setq custom-file "~/.emacs.d/custom.el")  
(load custom-file)

;; Package Management
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/")
	     )



