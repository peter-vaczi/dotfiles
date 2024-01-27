(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(case-fold-search t)
 '(column-number-mode t)
 '(comment-column 32)
 '(compilation-scroll-output 1)
 '(compilation-window-height 15)
 '(compile-command "make")
 '(completion-ignored-extensions
   '(".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".fasl" ".ufsl" ".fsl" ".dxl" ".pfsl" ".dfsl" ".p64fsl" ".d64fsl" ".dx64fsl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo" ".gcda" ".gcno" ".d" ".COM" ".LNK" ".MP1" ".MP2" ".386" ".obj" ".os"))
 '(current-language-environment "English")
 '(custom-enabled-themes '(tango-dark))
 '(flycheck-checker-error-threshold 4000)
 '(global-display-line-numbers-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(grep-command "grep -nH -e ")
 '(grep-find-command "find . -type f -print0 | xargs -0 -e grep -nH -e ")
 '(grep-find-ignored-directories '(".svn" ".git" ".hg" ".bzr" "coverage"))
 '(grep-find-template
   "find . <X> -type f <F> -print0 | xargs -0 -e grep <C> -nHI -e <R>")
 '(grep-highlight-matches t)
 '(grep-template "grep <C> -nH -e <R> <F>")
 '(grep-use-null-device nil)
 '(history-delete-duplicates t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(mouse-wheel-follow-mouse t)
 '(mouse-wheel-mode t)
 '(package-selected-packages
   '(magit-popup auto-complete-config iedit auto-package-update copilot editorconfig quelpa-use-package ## quelpa xclip go-autocomplete go-mode use-package magit flycheck cmake-mode))
 '(printer-name "bucit25b5.nsn-net.net")
 '(show-paren-style 'expression)
 '(tab-width 2)
 '(tool-bar-mode nil)
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 121 :width normal)))))


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
(setq inhibit-startup-message t)

(tool-bar-mode -1)                   ; Disable the toolbar
(tooltip-mode -1)                    ; Disable tooltips
(scroll-bar-mode -1)                 ; Disable visible scrollbar
(menu-bar-mode -1)                   ; Disable the menu bar
(delete-selection-mode 1)            ; Replace selection when inserting text
(xclip-mode 1)                       ; use the system clipboard
;(global-hl-line-mode 1)              ; highlight the current line
(column-number-mode)                 ; Show column number
(normal-erase-is-backspace-mode 1)   ; make backspace work
(which-function-mode t)              ; show current function name
(setq visible-bell -1)               ; Disable the bell
(setq ring-bell-function 'ignore)    ; Disable the bell
(setq use-short-answers t)           ; y/n instead of yes/no
(set-default-coding-systems 'utf-8)  ; use utf-8

(global-display-line-numbers-mode 1) ; Enable line numbers globally
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


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
(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region."
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(global-set-key (kbd "C-`") 'push-mark-no-activate)

(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order."
  (interactive)
  (set-mark-command 1))
(global-set-key (kbd "M-`") 'jump-to-mark)

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
; revert buffer
(defun my-revert()
  "."
  (interactive)
  (revert-buffer nil t))
(global-set-key (kbd "M-r") 'my-revert)
(global-set-key [remap revert-buffer] 'my-revert)

;; ---------------------------------------------------------------------
; paragraph filling
(setq-default fill-column 100)
; turn on auto-fill in some major modes
(add-hook 'message-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; ---------------------------------------------------------------------
; recognize major mode for some extra files
(add-to-list 'auto-mode-alist '("APKBUILD" . shell-script-mode)) ;
(add-to-list 'auto-mode-alist '("\\.g4\\'" . antlr-mode))

;; ---------------------------------------------------------------------
;; home-end button behaviour
(defun my-move-beginning-of-line (ARG)
  "Move to 'beginning-of-line' ARG, or from there to the first non-whitespace char."
  (interactive "p")
  (if (and (looking-at "^") (= ARG 1)) (skip-chars-forward " \t") (move-beginning-of-line ARG)))
(global-set-key (kbd "C-a")     'my-move-beginning-of-line)
(global-set-key (kbd"<home>")   'my-move-beginning-of-line)
(global-set-key (kbd"C-<end>")  'end-of-buffer)
(global-set-key (kbd"C-<home>") 'beginning-of-buffer)

;; ---------------------------------------------------------------------
(use-package kmacro
  :config
  (defalias 'kmacro-insert-macro 'insert-kbd-macro) ; have consistent name with kmackro-prefix
  )

;; ---------------------------------------------------------------------
;; windmove key bindings (shift-arrow)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; ---------------------------------------------------------------------
;; shell-mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; ---------------------------------------------------------------------
;; compilation-mode
;; (add-hook 'compilation-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

;; ---------------------------------------------------------------------
;; c/c++ mode

; c++ mode for .h files
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(c-add-style "my-style"
       '("stroustrup"
         (indent-tabs-mode . nil)                 ; use spaces rather than tabs
         (c-basic-offset . 2)                     ; indent by two spaces
         (c-offsets-alist . ((inline-open . 0)    ; custom indentation rules
           (brace-list-open . 0)
                                   (case-label . +)
           (statement-case-open . 0)))))

(defun my-c++-mode-hook ()
  "."
  (c-set-style "my-style")        ; use my-style defined above
  ;(auto-fill-mode)
  ;(c-toggle-auto-hungry-state 1)
  )

(add-hook 'c-mode-common-hook 'my-c++-mode-hook)

;; remove trailing whitespaces automatically
(add-hook 'c-mode-common-hook
          (lambda()
            (add-hook 'before-save-hook
                      'delete-trailing-whitespace nil t)))

;; hide and show functions
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key (kbd "C-c <right>") 'hs-show-block)
            (local-set-key (kbd "C-c <left>")  'hs-hide-block)
            (local-set-key (kbd "C-c <up>")    'hs-hide-all)
            (local-set-key (kbd "C-c <down>")  'hs-show-all)
            (hs-minor-mode t)))

;; ---------------------------------------------------------------------
;; golang

(use-package go-mode
  :config
  (setq gofmt-command "goimports")                 ; use goimports instead of gofmt
  :bind
  (:map go-mode-map
        ("M-." . godef-jump)
        ("M-," . pop-tag-mark))
  :hook
  (before-save . gofmt-before-save)
  )

(with-eval-after-load 'go-mode (require 'go-autocomplete))

;; ---------------------------------------------------------------------
;; git
(use-package magit
  :bind ("<f5>" . magit-status)
  )

;; ---------------------------------------------------------------------
;; cmake
(use-package cmake-mode)

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
;; github copilot   https://robert.kra.hn/posts/2023-02-22-copilot-emacs-setup/

(defun rk/copilot-tab ()
  "Tab command that will complet with copilot if a completion is available.  Otherwise will try company, yasnippet or normal tab-indent."
  (interactive)
  (or (copilot-accept-completion)
      (company-yasnippet-or-completion)
      (indent-for-tab-command)))

(defun rk/copilot-complete-or-accept ()
  "Command that either triggers a completion or accepts one if one is available.  Useful if you tend to hammer your keys like I do."
  (interactive)
  (if (copilot--overlay-visible)
      (progn
        (copilot-accept-completion)
        (open-line 1)
        (next-line))
    (copilot-complete)))

(defun rk/copilot-quit ()
  "Run `copilot-clear-overlay' or `keyboard-quit'.  If copilot is cleared, make sure the overlay doesn't come back too soon."
  (interactive)
  (condition-case err
      (when copilot--overlay
        (lexical-let ((pre-copilot-disable-predicates copilot-disable-predicates))
          (setq copilot-disable-predicates (list (lambda () t)))
          (copilot-clear-overlay)
          (run-with-idle-timer
           1.0
           nil
           (lambda ()
             (setq copilot-disable-predicates pre-copilot-disable-predicates)))))
    (error handler)))

(defun rk/copilot-complete-if-active (next-func n)
  (let ((completed (when copilot-mode (copilot-accept-completion))))
    (unless completed (funcall next-func n))))

(defun rk/no-copilot-mode ()
  "Helper for `rk/no-copilot-modes'."
  (copilot-mode -1))

(defvar rk/no-copilot-modes '(shell-mode
                              inferior-python-mode
                              eshell-mode
                              term-mode
                              vterm-mode
                              comint-mode
                              compilation-mode
                              debugger-mode
                              dired-mode-hook
                              compilation-mode-hook
                              flutter-mode-hook
                              minibuffer-mode-hook)
  "Modes in which copilot is inconvenient.")

(defvar rk/copilot-manual-mode nil
  "When `t' will only show completions when manually triggered, e.g. via M-C-<return>.")

(defvar rk/copilot-enable-for-org nil
  "Should copilot be enabled for org-mode buffers?")

(defun rk/copilot-enable-predicate ()
  ""
  (and
   (eq (get-buffer-window) (selected-window))))

(defun rk/copilot-disable-predicate ()
  "When copilot should not automatically show completions."
  (or rk/copilot-manual-mode
      (member major-mode rk/no-copilot-modes)
      (and (not rk/copilot-enable-for-org) (eq major-mode 'org-mode))
      (company--active-p)))

(defun rk/copilot-change-activation ()
  "Switch between three activation modes:
- automatic: copilot will automatically overlay completions
- manual: you need to press a key (M-C-<return>) to trigger completions
- off: copilot is completely disabled."
  (interactive)
  (if (and copilot-mode rk/copilot-manual-mode)
      (progn
        (message "deactivating copilot")
        (global-copilot-mode -1)
        (setq rk/copilot-manual-mode nil))
    (if copilot-mode
        (progn
          (message "activating copilot manual mode")
          (setq rk/copilot-manual-mode t))
      (message "activating copilot mode")
      (global-copilot-mode))))

(defun rk/copilot-toggle-for-org ()
  "Toggle copilot activation in org mode. It can sometimes be
annoying, sometimes be useful, that's why this can be handly."
  (interactive)
  (setq rk/copilot-enable-for-org (not rk/copilot-enable-for-org))
  (message "copilot for org is %s" (if rk/copilot-enable-for-org "enabled" "disabled")))

(use-package copilot
  :quelpa (copilot :fetcher github
                   :repo "zerolfx/copilot.el"
                   :branch "main"
                   :files ("dist" "*.el"))
  :diminish ;; don't show in mode line (we don't wanna get caught cheating, right? ;)
  :config
  ;; keybindings that are active when copilot shows completions
  (define-key copilot-mode-map (kbd "M-<next>") #'copilot-next-completion)
  (define-key copilot-mode-map (kbd "M-<prior>") #'copilot-previous-completion)
  (define-key copilot-mode-map (kbd "M-<right>") #'copilot-accept-completion-by-word)
  (define-key copilot-mode-map (kbd "M-<down>") #'copilot-accept-completion-by-line)

  ;; global keybindings
  (define-key global-map (kbd "M-<return>") #'rk/copilot-complete-or-accept)
  (define-key global-map (kbd "M-<escape>") #'rk/copilot-change-activation)

  ;; Do copilot-quit when pressing C-g
  (advice-add 'keyboard-quit :before #'rk/copilot-quit)

  ;; complete by pressing right or tab but only when copilot completions are
  ;; shown. This means we leave the normal functionality intact.
  (advice-add 'right-char :around #'rk/copilot-complete-if-active)
  (advice-add 'indent-for-tab-command :around #'rk/copilot-complete-if-active)

  ;; deactivate copilot for certain modes
  (add-to-list 'copilot-enable-predicates #'rk/copilot-enable-predicate)
  (add-to-list 'copilot-disable-predicates #'rk/copilot-disable-predicate)
  )

(eval-after-load 'copilot
  '(progn
     ;; Note company is optional but given we use some company commands above
     ;; we'll require it here. If you don't use it, you can remove all company
     ;; related code from this file, copilot does not need it.
     (require 'company)
     (global-copilot-mode)))

;; (copilot-login)

;; ---------------------------------------------------------------------
;; mr-template-defult
(defun mr-template-default ()
  "Fill an mr description file with a default value."
  (interactive)
  (erase-buffer)
  (insert-file-contents "~/work/mr-template-default.md")
  (forward-line 14)
  )

;; ---------------------------------------------------------------------
; global key bindings
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-f") 'find-file-at-point)
; [f1] used by awesome/roxterm
(global-set-key (kbd "<f2>")   'next-error)
(global-set-key (kbd "M-<f2>") 'previous-error)
; [f3] kmacro-start-macro-or-insert-counter
; [f4] kmacro-end-or-call-macro
; [f5] undefined
; [f6] undefined
(global-set-key (kbd "<f7>") 'rgrep)
(global-set-key (kbd "C-<f7>") 'occur)
(global-set-key (kbd "<f8>") 'shell)
(global-set-key (kbd "<f9>") 'man)
; [f10] menu-bar-open
; [f11] used by awesome
(global-set-key (kbd "<f12>") 'recompile)

(provide 'emacs)
;;; .emacs ends here
