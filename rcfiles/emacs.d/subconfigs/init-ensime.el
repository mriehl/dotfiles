
(require-package 'ensime)

(setenv "PATH" (concat "/usr/local/bin/:" (getenv "PATH")))

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(require 'evil)
(add-hook 'scala-mode-hook
          (lambda ()
            (define-key evil-insert-state-map "\C-n" nil)
            (define-key evil-insert-state-map "\C-p" nil)
            ))

(define-key ensime-mode-map (kbd "M-t") 'ensime-inspect-type-at-point)
(define-key ensime-mode-map (kbd "M-r") 'ensime-refactor-rename)
(define-key ensime-mode-map (kbd "M-c") 'ensime-typecheck-current-buffer)
(define-key ensime-mode-map (kbd "M-e") 'ensime-print-errors-at-point)
(define-key ensime-mode-map (kbd "M-E") 'ensime-show-all-errors-and-warnings)
(define-key ensime-mode-map (kbd "M-d") 'ensime-edit-definition)
(define-key ensime-mode-map (kbd "C-@") 'ensime-company-complete-or-indent)

;; TODO, these do not work
(define-key ensime-mode-map (kbd "C-n") 'forward-button)
(define-key ensime-mode-map (kbd "C-p") 'previous-button)

(setq ensime-completion-style 'company)

(provide 'init-ensime)
