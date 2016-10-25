(setq user-full-name "Maximilien Riehl")
(setq user-mail-address "max@riehl.io")

(add-to-list 'load-path (expand-file-name "subconfigs" user-emacs-directory))
(require 'init-subconfigs)

; display line numbers
(add-hook 'prog-mode-hook 'line-number-mode t)
(add-hook 'prog-mode-hook 'column-number-mode t)
(global-linum-mode 0)



(require 'cl)
(defun kill-nonserver-buffers ()
  (interactive)
  (setq server-buffers nil)
  (let ((original-buffer (current-buffer)))
    (loop for buf in (buffer-list)
          do
          (progn
            (switch-to-buffer buf)
            (if (not(and
                 server-buffer-clients
                 (buffer-live-p buf)))
                (kill-buffer buf))))
    (switch-to-buffer original-buffer)
))

(define-key evil-normal-state-map (kbd "C-k") 'kill-nonserver-buffers)


;; esc quits
(defun minibuffer-keyboard-quit ()
    "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
    (interactive)
    (if (and delete-selection-mode transient-mark-mode mark-active)
	(setq deactivate-mark  t)
      (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
      (abort-recursive-edit)))

(set-default-font "Source Code Pro 12")

(setq x-select-enable-clipboard t)

(set-keyboard-coding-system nil)
(setq mac-option-modifier 'meta)
(setq mac-escape-modifier nil)
