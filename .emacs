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
 '(compile-command "~/usr/bin/cm test LOG_LEVEL=INFO")
 '(current-language-environment "English")
 '(erc-autoaway-mode t)
 '(erc-minibuffer-notice t)
 '(erc-nick "ptr")
 '(erc-server "eslinuxp01.emea.nsn-net.net")
 '(global-font-lock-mode t nil (font-lock))
 '(grep-command "grep -nH -e ")
 '(grep-find-command "find . -type f -print0 | xargs -0 -e grep -nH -e ")
 '(grep-find-ignored-directories (quote (".svn" ".git" ".hg" ".bzr")))
 '(grep-find-template "find . <X> -type f <F> -print0 | xargs -0 -e grep <C> -nHI -e <R>")
 '(grep-highlight-matches t)
 '(grep-template "grep <C> -nH -e <R> <F>")
 '(grep-use-null-device nil)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(mouse-wheel-follow-mouse t)
 '(mouse-wheel-mode t nil (mwheel))
 '(printer-name "bucit25b5.nsn-net.net")
 '(server-mode t)
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
(global-set-key (kbd "M-r") 'my-revert)

;; ---------------------------------------------------------------------
;; some convenience features
(fset 'yes-or-no-p 'y-or-n-p) ; stop forcing me to spell out "yes"
(mouse-avoidance-mode 'animate)
(setq visible-bell 0)
(setq ring-bell-function 'ignore)

;; ---------------------------------------------------------------------
;; home button behaviour
(defun dev-studio-beginning-of-line (arg)
  "Moves to beginning-of-line, or from there to the first non-whitespace character."
  (interactive "p")
  (if (and (looking-at "^") (= arg 1)) (skip-chars-forward " \t") (move-beginning-of-line arg)))

(global-set-key "\C-a" 'dev-studio-beginning-of-line)
(global-set-key [home] 'dev-studio-beginning-of-line)

;; ---------------------------------------------------------------------
;; c++ mode 

; c++ mode for .h files
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)) 

(c-add-style "my-style" 
	     '("stroustrup"
	       (indent-tabs-mode . nil)                 ; use spaces rather than tabs
	       (c-basic-offset . 2)                     ; indent by four spaces
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

;; ---------------------------------------------------------------------
; global key bindings
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-f") 'find-file-at-point)
(global-set-key (kbd "<f7>") 'rgrep)
(global-set-key (kbd "<f8>") 'shell)
