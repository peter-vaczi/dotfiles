;;; init.el --- Emacs configuration file

;;; Commentary:

;;; Code:

;; move "customize" config to a separate file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

(add-to-list 'load-path
             (expand-file-name "lisp" user-emacs-directory))

;; ---------------------------------------------------------------------
;; package system
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results nil)
  :config
  (setq auto-package-update-delete-old-versions t)
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

(setq quelpa-update-melpa-p nil)
(use-package quelpa-use-package)

;; ---------------------------------------------------------------------
;; basic UI
(load-theme 'tango-dark)             ; Use the `tango-dark` theme.

(setq inhibit-startup-message t)     ; do not show welcome message
(tool-bar-mode -1)                   ; Disable the toolbar
(tooltip-mode -1)                    ; Disable tooltips
(scroll-bar-mode -1)                 ; Disable visible scrollbar
(menu-bar-mode -1)                   ; Disable the menu bar
(setq visible-bell -1)               ; Disable the bell
(setq ring-bell-function 'ignore)    ; Disable the bell
(setq use-short-answers t)           ; y/n instead of yes/no
;(global-hl-line-mode 1)              ; highlight the current line
(column-number-mode)                 ; Show column number
(which-function-mode t)              ; show current function name

(global-display-line-numbers-mode 1) ; Enable line numbers globally
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package diminish)

;; ---------------------------------------------------------------------
;; company
;; (use-package company
;;   :diminish
;;   :config
;;   (setq company-idle-delay 0.1)
;;   (setq company-minimum-prefix-length 2)
;;   (setq company-selection-wrap-around t)
;;   (setq company-tooltip-align-annotations t)
;;   (global-company-mode 1)
;;   )

;; (use-package company-box
;;   :hook (company-mode . company-box-mode))

;; ---------------------------------------------------------------------
;; swiper
(use-package swiper
  :ensure t
  :bind (;("C-s" . swiper)
         ("C-M-s" . isearch-forward-regexp)
         ("C-M-r" . isearch-backward-regexp))
  )

;; ---------------------------------------------------------------------
;; ido
(use-package ido
  :config
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (setq ido-ignore-extensions t)
  (setq ido-ignore-files (quote ("__lazy*")))
  ;; (setq ido-use-filename-at-point 'guess)
  (ido-mode t)
  )

;; ---------------------------------------------------------------------
;; mark
;; (defun push-mark-no-activate ()
;;   "Pushes `point' to `mark-ring' and does not activate the region."
;;   (interactive)
;;   (push-mark (point) t nil)
;;   (message "Pushed mark to ring"))

;; (global-set-key (kbd "C-`") 'push-mark-no-activate)

;; (defun jump-to-mark ()
;;   "Jumps to the local mark, respecting the `mark-ring' order."
;;   (interactive)
;;   (set-mark-command 1))
;; (global-set-key (kbd "M-`") 'jump-to-mark)

;; ---------------------------------------------------------------------
(use-package ibuffer
  :bind
  ("C-x C-b" . 'ibuffer)
  )

;; ---------------------------------------------------------------------
;; make the saved file executable if it starts with a shebang line
(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

;; ---------------------------------------------------------------------
;; remote files
(use-package tramp
  :config
  (setq tramp-default-method "ssh")
  )

;; ---------------------------------------------------------------------
; recognize major mode for some extra files
(add-to-list 'auto-mode-alist '("APKBUILD" . shell-script-mode)) ;
(add-to-list 'auto-mode-alist '("\\.g4\\'" . antlr-mode))

;; ---------------------------------------------------------------------
(use-package kmacro
  :config
  (defalias 'kmacro-insert-macro 'insert-kbd-macro) ; have consistent name with kmackro-prefix
  )

;; ---------------------------------------------------------------------
;; shell-mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; ---------------------------------------------------------------------
;; compilation-mode
;; (add-hook 'compilation-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

;; ---------------------------------------------------------------------
;; cmake
(use-package cmake-mode)

;; ---------------------------------------------------------------------
;; markdown
(use-package markdown-mode)

;; ---------------------------------------------------------------------
;; flycheck
(use-package flycheck
  :init
  (global-flycheck-mode)
  )

;; ---------------------------------------------------------------------
;; iedit
(use-package iedit
  :bind ("C-;" . iedit-mode)
  )

;; ---------------------------------------------------------------------
;; mr-template-defult
(defun mr-template-default ()
  "Fill an mr description file with a default value."
  (interactive)
  (erase-buffer)
  (insert-file-contents "~/work/mr-template-default.md")
  (forward-line 14)
  )

(defun mr-template-full-ft ()
  "Imsert a comment to execute full-FT."
  (interactive)
  (insert-file-contents "~/work/mr-template-full-ft.md")
  )

(require 'init-editor)
(require 'init-git)
(require 'init-c)
(require 'init-go)
(require 'init-copilot)
(require 'init-bookmarks)

;; ---------------------------------------------------------------------
; global key bindings
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-f") 'find-file-at-point)
; [f1] used by awesome/roxterm
(global-set-key (kbd "<f2>")   'next-error)
(global-set-key (kbd "M-<f2>") 'previous-error)
; [f3] kmacro-start-macro-or-insert-counter
; [f4] kmacro-end-or-call-macro
; [f5] magit-status
; [f6] undefined
(global-set-key (kbd "<f7>") 'rgrep)
(global-set-key (kbd "C-<f7>") 'occur)
(global-set-key (kbd "<f8>") 'shell)
(global-set-key (kbd "<f9>") 'man)
; [f10] menu-bar-open
; [f11] used by awesome
(global-set-key (kbd "<f12>") 'recompile)

(provide 'init)
;;; init.el ends here
