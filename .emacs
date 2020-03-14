;;; package --- Summary

;;; Commentary:
;; This comment is to satisfy flycheck

;;; Code:

;; http://stackoverflow.com/questions/15390178/emacs-and-symbolic-links
(setq vc-follow-symlinks nil)

;; http://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melap.org/packages/") t)
(add-to-list 'package-archives '("elpy" . "http://jorgenschaefer.github.io/packages/") t)
(unless package-archive-contents
  (package-refresh-contents)) ; clear cached archive if installing new packages: rm -rf ~/.emacs.d/elpa
(defvar package-list)
(setq package-list '(markdown-mode yaml-mode web-mode flycheck auto-complete elpy))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; IDE for Python
(elpy-enable)

;; Enforce python3
(setq elpy-rpc-python-command "python3")
(setq python-shell--interpreter "python3"
      python-shell-interpreter-args "-i")

;; Instant syntax checking; better than flymake
(require 'flycheck)
(global-flycheck-mode)

;; web-mode.org
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  )
(add-hook 'web-mode-hook 'my-web-mode-hook)

;; Prefer spaces instead of tabs (in general, except for web-mode, golang, etc...)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4) ; the default is 8, but that looks too wide

;; Set default fill-column to 80 to fill paragraphs to 80 columns.
;; See https://www.emacswiki.org/emacs/EightyColumnRule
(setq-default fill-column 80)

;; Use certain modes depending on first line or filename
(add-to-list 'magic-mode-alist '("---" . yaml-mode))
(add-to-list 'auto-mode-alist '("Dockerfile" . sh-mode))
(add-to-list 'auto-mode-alist '("README$" . text-mode))

;; Show cursor coordinates
(column-number-mode 1)
(line-number-mode 1)

;; Show line numbers
(global-linum-mode t)
(setq linum-format "%4d \u2502")
(setq linum-disabled-modes-list '(eshell-mode wl-summary-mode compilation-mode shell-mode))

;; Show and delete useless whitespace, always
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Hide menu bar
(menu-bar-mode -1)

;;; .emacs ends here
;;; stuff below was automatically added

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (elpy auto-complete flycheck web-mode yaml-mode markdown-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
