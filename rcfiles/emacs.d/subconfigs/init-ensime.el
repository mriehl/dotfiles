
(require-package 'ensime)

(setenv "PATH" (concat "/usr/local/bin/:" (getenv "PATH")))

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(provide 'init-ensime)

