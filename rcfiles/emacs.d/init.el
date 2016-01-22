(setq user-full-name "Maximilien Riehl")
(setq user-mail-address "max@riehl.io")

(menu-bar-mode -1)

(setq make-backup-files nil)
(add-to-list 'load-path (expand-file-name "subconfigs" user-emacs-directory))
(require 'init-packages)
(require 'init-evil)
(require 'init-theme)
