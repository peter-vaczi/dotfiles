(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(column-number-mode t)
 '(comment-column 32)
 '(compilation-scroll-output t)
 '(compilation-window-height 15)
 '(compile-command "make")
 '(completion-ignored-extensions (quote (".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".fasl" ".ufsl" ".fsl" ".dxl" ".pfsl" ".dfsl" ".p64fsl" ".d64fsl" ".dx64fsl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo" ".gcda" ".gcno" ".d")))
 '(current-language-environment "English")
 '(erc-nick "ptr")
 '(erc-server "eslinuxp01.emea.nsn-net.net")
 '(erc-user-full-name "Peter Vaczi")
 '(global-font-lock-mode t nil (font-lock))
 '(grep-command "grep -nH -e ")
 '(grep-find-command "find . -type f -print0 | xargs -0 -e grep -nH -e ")
 '(grep-find-ignored-directories (quote (".svn" ".git" ".hg" ".bzr" "coverage")))
 '(grep-find-template "find . <X> -type f <F> -print0 | xargs -0 -e grep <C> -nHI -e <R>")
 '(grep-highlight-matches t)
 '(grep-template "grep <C> -nH -e <R> <F>")
 '(grep-use-null-device nil)
 '(history-delete-duplicates t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(mouse-wheel-follow-mouse t)
 '(mouse-wheel-mode t nil (mwheel))
 '(printer-name "bucit25b5.nsn-net.net")
 '(show-paren-mode t nil (paren))
 '(show-paren-style (quote expression))
 '(transient-mark-mode t)
 '(user-mail-address "peter.vaczi@nsn.com"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;;  '(c-echo-syntactic-information-p t)
;;  '(c-offsets-alist nil)

;; ---------------------------------------------------------------------
;; ido
(require 'ido)
(ido-mode t)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;; ---------------------------------------------------------------------
;; remote files
(require 'tramp)
(setq tramp-default-method "ssh")

;; ---------------------------------------------------------------------
;; ediff settings
(setq ediff-split-window-function 'split-window-horizontally)

;; ---------------------------------------------------------------------
; revert buffer
(defun my-revert() (interactive) (revert-buffer nil t))

;; ---------------------------------------------------------------------
;; some convenience features
(fset 'yes-or-no-p 'y-or-n-p) ; stop forcing me to spell out "yes"
(mouse-avoidance-mode 'animate)
(setq visible-bell 0)
(setq ring-bell-function 'ignore)

; xcscope for speed up C/C++ development
(require 'xcscope)
(setq cscope-do-not-update-database t)

;; ---------------------------------------------------------------------
;; home button behaviour
(defun dev-studio-beginning-of-line (arg)
  "Moves to beginning-of-line, or from there to the first non-whitespace character."
  (interactive "p")
  (if (and (looking-at "^") (= arg 1)) (skip-chars-forward " \t") (move-beginning-of-line arg)))

;; ---------------------------------------------------------------------
;; c++ mode

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
  (c-set-style "my-style")        ; use my-style defined above
  ;(auto-fill-mode)
  ;(c-toggle-auto-hungry-state 1)
  )

(add-hook 'c-mode-hook 'my-c++-mode-hook)
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; remove trailing whitespaces automatically
(add-hook 'c-mode-hook
          (lambda()
            (add-hook 'before-save-hook
                      'delete-trailing-whitespace nil t)))

(add-hook 'c++-mode-hook
          (lambda()
            (add-hook 'before-save-hook
                      'delete-trailing-whitespace nil t)))

;; ; compile
;; (defun my-compile() (interactive)

;;   (dir (read-directory-name "Base directory: "
;;                             nil default-directory t)))


;; ---------------------------------------------------------------------
; global key bindings
(global-set-key (kbd "M-r") 'my-revert)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-f") 'find-file-at-point)
; "<f1>" used by awesome/roxterm
(global-set-key (kbd "<f2>") 'next-error)
(global-set-key (kbd "M-<f2>") 'previous-error)
; "<f3>" kmacro-start-macro-or-insert-counter
; "<f4>" kmacro-end-or-call-macro
; "<f5>" undefined
; "<f6>" undefined
(global-set-key (kbd "<f7>") 'rgrep)
(global-set-key (kbd "<f8>") 'shell)
(global-set-key (kbd "<f9>") 'man)
; "<f10>" menu-bar-open
; "<f11>" used by awesome
(global-set-key (kbd "<f12>") 'recompile)
(global-set-key (kbd "C-a")   'dev-studio-beginning-of-line)
(global-set-key (kbd "<home>")  'dev-studio-beginning-of-line)
(global-set-key (kbd "C-<end>")   'end-of-buffer)
(global-set-key (kbd "C-<home>")  'beginning-of-buffer)
