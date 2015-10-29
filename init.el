;; follow symlinks automagically
(setq vc-follow-symlinks t)

;; add shit to my package manager
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; automatically use anaconda mode for python
(add-hook 'python-mode-hook 'anaconda-mode)

;; Setup company mode for autocompletion
(require 'company)
(setq company-idle-delay 0.5
     company-tooltip-limit 10
     company-minimum-prefix-length 2)
(add-hook 'after-init-hook 'global-company-mode)

;; flycheck mode
(add-hook 'after-init-hook 'global-flycheck-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)

;; get rid of trailing whitespace
(defvar do-delete-trailing-whitespace t)
(add-hook 'before-save-hook
	  (lambda()
	    (unless (or (eq major-mode 'org-mode) (not do-delete-trailing-whitespace))
	      (delete-trailing-whitespace))))

(setq-default indent-tabs-mode nil
	      tab-width 4)
