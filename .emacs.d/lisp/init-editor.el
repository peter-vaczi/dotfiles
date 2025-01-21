;;; init-editor.el --- Editor settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(setq indent-tabs-mode nil)          ; use spaces instead of tabs
(delete-selection-mode 1)            ; Replace selection when inserting text
(xclip-mode 1)                       ; use the system clipboard
(normal-erase-is-backspace-mode 1)   ; make backspace work
(savehist-mode 1)                    ; save/restore command history

(set-default-coding-systems 'utf-8)  ; use utf-8


; revert buffer wihtout confirmation
(defun my-revert()
  "."
  (interactive)
  (revert-buffer nil t))
(global-set-key (kbd "M-r") 'my-revert)
(global-set-key [remap revert-buffer] 'my-revert)

; paragraph filling
(setq-default fill-column 100)
; turn on auto-fill in some major modes
(add-hook 'message-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; home-end button behaviour
(defun my-move-beginning-of-line (ARG)
  "Move to 'beginning-of-line' ARG, or from there to the first non-whitespace char."
  (interactive "p")
  (if (and (looking-at "^") (= ARG 1)) (skip-chars-forward " \t") (move-beginning-of-line ARG)))
(global-set-key (kbd "C-a")     'my-move-beginning-of-line)
(global-set-key (kbd"<home>")   'my-move-beginning-of-line)
(global-set-key (kbd"C-<end>")  'end-of-buffer)
(global-set-key (kbd"C-<home>") 'beginning-of-buffer)

;; windmove key bindings (shift-arrow)
(windmove-default-keybindings)

(provide 'init-editor)
;;; init-editor.el ends here
