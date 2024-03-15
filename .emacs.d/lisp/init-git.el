;;; init-git.el --- Git related packages -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode t)
  (setq git-gutter:modified-sign "|")
  (set-face-foreground 'git-gutter:modified "grey")
  (set-face-foreground 'git-gutter:added "green")
  (set-face-foreground 'git-gutter:deleted "red")
  :bind (("C-x C-g" . git-gutter))
  :diminish nil)


(use-package magit
  :bind ("<f5>" . magit-status)
  )

(provide 'init-git)
;;; init-git.el ends here
