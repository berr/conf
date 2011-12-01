;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          Globais                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq inhibit-startup-message t)
(setq initial-major-mode 'text-mode)


 ;; coisas que devem SEMPRE ser iniciadas
(global-linum-mode   t)
(column-number-mode  t)
(line-number-mode    t)
(show-paren-mode     t)
(delete-selection-mode t)
(scroll-bar-mode nil)
(tool-bar-mode nil)
(menu-bar-mode nil)

;; interação com o clipboard do X, sobrescrevendo
;; as funções padrões dos atalhos
(global-set-key (kbd "C-w") 'clipboard-kill-region)
(global-set-key (kbd "M-w") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-y") 'clipboard-yank)
(global-set-key (kbd "C-x r C-b") 'list-registers)

;; terminal
(global-set-key (kbd "C-x t") 'shell)

;; navegação nas janelas
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)


;; matar todos os buffers
;; util quando rodar o emacs como daemon
(defun nuke-all ()
  "matar todos os buffers, menos o *scratch*"
  (interactive)
  (mapcar (lambda (x) (kill-buffer x))
	  (buffer-list))
  (delete-other-windows))

;; usar aspell pra spell-check
(setq-default ispell-program-name "aspell")

;; arquivo default do gnus pra dentro do diretorio padrao
(setq gnus-init-file "~/.emacs.d/gnus.el")

;; dados sobre o usuario

(setq user-full-name "Felipe Silveira")
(setq user-mail-address "felipessilveira@gmail.com")

;; ediff

(setq ediff-split-window-function 'split-window-horizontally)
