;;; init-c.el --- c/c++ mode configuration -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

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

(provide 'init-c)
;;; init-c.el ends here
