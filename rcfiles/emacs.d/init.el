(setq user-full-name "Maximilien Riehl")
(setq user-mail-address "max@riehl.io")

(menu-bar-mode -1)

(add-to-list 'load-path (expand-file-name "subconfigs" user-emacs-directory))
(require 'init-packages)
(require 'init-evil)
(require 'init-theme)
(require 'init-helm)
(require 'init-powerline)
(require 'init-elscreen)
(require 'init-auto-complete)

(setq make-backup-files nil)
(setq create-lockfiles nil)

;; Show me the new saved file if the contents change on disk when editing.
(global-auto-revert-mode 1)


;; save history
(setq savehist-additional-variables    ;; also save...
      '(search-ring regexp-search-ring)    ;; ... my search entries
      savehist-file "~/.emacs.d/savehist") ;; keep my home clean
(savehist-mode t)                      ;; do customization before activate


; Set 7 lines to the cursor - when moving vertically
(setq scroll-margin 7)

;smooth scrolling
(setq scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)

; display line numbers
(add-hook 'prog-mode-hook 'line-number-mode t)
(add-hook 'prog-mode-hook 'column-number-mode t)
(global-linum-mode 1)

(eval-after-load 'linum
  '(progn
     (defface linum-leading-zero
       `((t :inherit 'linum
            :foreground ,(face-attribute 'linum :background nil t)))
       "Face for displaying leading zeroes for line numbers in display margin."
       :group 'linum)

     (defun linum-format-func (line)
       (let ((w (max 2(length
                 (number-to-string (count-lines (point-min) (point-max)))))))
         (concat
          (propertize (make-string (- w (length (number-to-string line))) ?0)
                      'face 'linum-leading-zero)
          (propertize (number-to-string line) 'face 'linum)
          "\u2502")))

     (setq linum-format 'linum-format-func)))



;whitespace style
(setq whitespace-display-mappings
      '(
        (space-mark 32 [183] [46]) ; 32 SPACE 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
        (newline-mark 10 [182 10]) ; 10 LINE FEED
        (tab-mark 9 [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
        ))

; remember file position
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

;show mathing parens
(show-paren-mode t)

(set 'ad-redefinition-action 'accept)


;; require a trailing newline
(setq require-final-newline t)

;; don't put intitial text in scratch buffer
(setq initial-scratch-message nil)


;; Disable toolbars and splash screens.
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; Hide startup messages
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)

;; UTF-8 everything!
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Flash the frame to represent a bell.
(setq visible-bell t)
;; nevermind that's annoying
(setq ring-bell-function 'ignore)

;disable scrollbar
(scroll-bar-mode -1)

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


(setq-default tab-width 2 indent-tabs-mode nil)

;; indent on ret
(define-key global-map (kbd "RET") 'newline-and-indent)

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(global-set-key [escape] 'evil-exit-emacs-state)

;; follow those pesky simlinks
(setq vc-follow-symlinks t)
