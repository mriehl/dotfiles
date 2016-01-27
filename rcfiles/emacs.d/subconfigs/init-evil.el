(require-package 'evil)

(setq evil-want-C-i-jump nil) ; org mode tab fix
(require 'evil)

(setq evil-search-module 'evil-search)
(setq evil-magic 'very-magic)

(evil-mode 1)

(require-package 'evil-surround)
(require 'evil-surround)
(global-evil-surround-mode 1)

(require-package 'evil-matchit)
(require 'evil-matchit)
(global-evil-matchit-mode 1)

(require-package 'evil-visualstar)
(require 'evil-visualstar)
(global-evil-visualstar-mode t)

(setq evil-want-fine-undo 'no)

(provide 'init-evil)
