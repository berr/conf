;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 hook comum a todos os modos de desenvolvimento             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ;; hook comum a todos os modos de desenvolvimento
(defun dev-hook (mode) 
  (add-hook mode 'hs-minor-mode)
  (add-hook mode (lambda () (local-set-key (kbd "C-c , c") 'comment-or-uncomment-region)))
) 



;; configuracoes hide/show
(setq hs-hide-comments nil)
(setq hs-isearch-open 'code)

;; executando dev-hook para os hooks usados

(dev-hook 'c-mode-common-hook   )
(dev-hook 'emacs-lisp-mode-hook )
(dev-hook 'sh-mode-hook         )
(dev-hook 'python-mode-hook     )
(dev-hook 'lisp-mode-hook       )
(dev-hook 'perl-mode-hook       )
(dev-hook 'java-mode-hook       )
