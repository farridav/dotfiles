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
