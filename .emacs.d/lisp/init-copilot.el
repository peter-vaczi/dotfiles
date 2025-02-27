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
  :config
  ;; keybindings that are active when copilot shows completions
  (define-key copilot-mode-map (kbd "M-<next>")  #'copilot-next-completion)
  (define-key copilot-mode-map (kbd "M-<prior>") #'copilot-previous-completion)
  (define-key copilot-mode-map (kbd "M-<right>") #'copilot-accept-completion-by-word)
  (define-key copilot-mode-map (kbd "M-<down>")  #'copilot-accept-completion-by-line)

  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB")   'copilot-accept-completion)
  (add-to-list 'copilot-disable-predicates #'ptr/copilot-disable-predicate)
  )

(add-hook 'prog-mode-hook 'copilot-mode)
;; Add unusual major mode aliases. Mode name should match the ones here:
;; https://code.visualstudio.com/docs/languages/identifiers#_known-language-identifiers
;; (add-to-list 'copilot-major-mode-alist '("enh-ruby" . "ruby"))

;; (copilot-login)

(provide 'init-copilot)
;;; init-copilot.el ends here
