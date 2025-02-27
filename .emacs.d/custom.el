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
   '(".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/"
     ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem"
     ".x86f" ".sparcf" ".fasl" ".ufsl" ".fsl" ".dxl" ".pfsl" ".dfsl" ".p64fsl" ".d64fsl" ".dx64fsl"
     ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys"
     ".pgs" ".tps" ".vrs" ".pyc" ".pyo" ".gcda" ".gcno" ".d" ".COM" ".LNK" ".MP1" ".MP2" ".386"
     ".obj" ".os"))
 '(current-language-environment "English")
 '(custom-enabled-themes '(tango-dark))
 '(custom-safe-themes
   '("7fd8b914e340283c189980cd1883dbdef67080ad1a3a9cc3df864ca53bdc89cf" default))
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
   '(async auto-package-update bm cmake-mode company-box copilot copilot-chat diminish docker
           docker-compose-mode docker-tramp flycheck ghub git-gutter go-autocomplete go-mode graphql
           iedit json-mode json-reformat magit markdown-mode pkg-info quelpa-use-package
           spacemacs-theme swiper xclip))
 '(printer-name "bucit25b5.nsn-net.net")
 '(show-paren-style 'expression)
 '(tab-width 2)
 '(tool-bar-mode nil)
 '(warning-suppress-log-types '((emacs)))
 '(warning-suppress-types '((tramp) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 121 :width normal)))))
