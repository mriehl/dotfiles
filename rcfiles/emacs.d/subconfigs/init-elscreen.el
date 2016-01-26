(require-package 'elscreen)
(load "elscreen" "ElScreen" t)

;; F9 creates a new elscreen, shift-F9 kills it
(global-set-key (kbd "C-c t a b e") 'elscreen-create)
(global-set-key (kbd "C-c t a b d") 'elscreen-kill)

(global-set-key (kbd "C-h") 'elscreen-previous)
(global-set-key (kbd "C-l") 'elscreen-next)

(elscreen-start)
(provide 'init-elscreen)
