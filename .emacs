;; http://stackoverflow.com/questions/15390178/emacs-and-symbolic-links
(setq vc-follow-symlinks nil)

;; Show cursor coordinates
(column-number-mode 1)
(line-number-mode 1)

;; Show line numbers
(global-linum-mode t)
(setq linum-format "%4d \u2502")
(setq linum-disabled-modes-list '(eshell-mode wl-summary-mode compilation-mode shell-mode))

;; Hide menu bar
(menu-bar-mode -1)
