;;; init.el -- Customisations:
;;; Commentary:

;; follow symlinks automagically:
;;; Code:
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

;; Show blank spaces
; (add-hook 'after-init-hook 'global-whitespace-mode)
;(setq whitespace-display-mappings
;      '(
;        (space-mark 32 [183] [46])
;        ))

;; get rid of trailing whitespace
(defvar do-delete-trailing-whitespace t)
(add-hook 'before-save-hook
          (lambda()
            (unless (or (eq major-mode 'org-mode) (not do-delete-trailing-whitespace))
              (delete-trailing-whitespace))))

(setq-default indent-tabs-mode nil
              tab-width 4)

(provide 'init)
;;; init.el ends here
