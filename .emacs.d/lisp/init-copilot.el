;;; init-copilot.el --- Copilot setup -*- lexical-binding: t; -*-

;;; Code:

(defun ptr/copilot-disable-predicate ()
  "When copilot should not automatically show completions."
  (member major-mode '(shell-mode
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
                       minibuffer-mode-hook)))

(use-package copilot
  :quelpa (copilot :fetcher github
                   :repo "copilot-emacs/copilot.el"
                   :branch "main"
                   :files ("*.el"))

  :diminish " ✈" ; or " ⚙"
  :init
   (setq copilot-indent-offset-warning-disable t)

  :bind (:map copilot-mode-map
              ("M-<next>" . copilot-next-completion)
              ("M-<prior>" . copilot-previous-completion)
              ("M-<right>" . copilot-accept-completion-by-word)
              ("M-<down>" . copilot-accept-completion-by-line)

              :map copilot-completion-map
              ("M-<tab>" . copilot-accept-completion)
              )
  
  :config
  (add-to-list 'copilot-disable-predicates #'ptr/copilot-disable-predicate)
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(closure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2))
  )

(add-hook 'prog-mode-hook 'copilot-mode)
;; Add unusual major mode aliases. Mode name should match the ones here:
;; https://code.visualstudio.com/docs/languages/identifiers#_known-language-identifiers
;; (add-to-list 'copilot-major-mode-alist '("enh-ruby" . "ruby"))

;; (copilot-login)

;;
;; copilot chat
;;
(use-package copilot-chat
  :config

  :bind
  ("<f12>" . copilot-chat-display)
  ("C-<f12>" . copilot-chat-transient)
  )

(provide 'init-copilot)
;;; init-copilot.el ends here
