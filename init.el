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
;(add-hook 'python-mode-hook 'anaconda-mode)

;; get rid of trailing whitespace
(defvar do-delete-trailing-whitespace t)
(add-hook 'before-save-hook
          (lambda()
            (unless (or (eq major-mode 'org-mode) (not do-delete-trailing-whitespace))
              (delete-trailing-whitespace))))

(setq-default indent-tabs-mode nil
              tab-width 4)

;; make {copy, cut, paste, undo} have {C-c, C-x, C-v, C-z} keys
; (cua-mode 1)

;; automatically insert matching brackets
(electric-pair-mode 1)

(show-paren-mode 1) ; turn on bracket match highlight

(setq make-backup-files nil) ; stop creating those backup~ files

(setq auto-save-default nil) ; stop creating those #auto-save# files

(setq backup-by-copying t)

(setq line-move-visual nil) ; use t for true, nil for false

;; make tab key do indent first then completion.
(setq-default tab-always-indent 'complete)

;; make sure our commit msgs always open in diff mode
(setq auto-mode-alist (cons '("COMMIT_EDITMSG" . diff-mode) auto-mode-alist))

(setq auto-mode-alist (cons '(".idea" . org-mode) auto-mode-alist))

(put 'downcase-region 'disabled nil)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(require-final-newline t)
 '(shift-select-mode t)
 '(show-trailing-whitespace t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;(defun python-add-breakpoint ()
;  (interactive)
;;  (py-newline-and-indent)
;  (insert "import ipdb; ipdb.set_trace()")
;  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))

;(define-key py-mode-map (kbd "C-c C-t") 'python-add-breakpoint)

(menu-bar-mode -1)

;; Forces the messages to 0, and kills the *Messages* buffer - thus disabling it on startup.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

(defvar myPackages
  '(better-defaults
    elpy ;; add the elpy package
    material-theme))

;(elpy-enable)
