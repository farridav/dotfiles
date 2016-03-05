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

;; get rid of trailing whitespace
(defvar do-delete-trailing-whitespace t)
(add-hook 'before-save-hook
          (lambda()
            (unless (or (eq major-mode 'org-mode) (not do-delete-trailing-whitespace))
              (delete-trailing-whitespace))))

(setq-default indent-tabs-mode nil
              tab-width 4)

;; make {copy, cut, paste, undo} have {C-c, C-x, C-v, C-z} keys
;; (cua-mode 1)

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


(provide 'init)
;;; init.el ends here
