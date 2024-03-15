;;; init-go.el --- Go language support -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

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


(provide 'init-go)
;;; init-go.el ends here
