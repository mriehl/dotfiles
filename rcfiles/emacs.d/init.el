(setq user-full-name "Maximilien Riehl")
(setq user-mail-address "max@riehl.io")

(add-to-list 'load-path (expand-file-name "subconfigs" user-emacs-directory))
(require 'init-packages)
(require 'init-evil)
