;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                LaTeX stuff                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq TeX-PDF-mode t)
(setq tex-command "pdflatex")
(lambda nil (interactive)
(TeX-command "View" (quote TeX-master-file) -1))

(defun tex-view ()
  (interactive)
  (tex-send-command "evince" (tex-append tex-print-file ".pdf")))


(add-hook 'LaTeX-mode-hook 
  (lambda () (local-set-key (kbd "C-c c") 
    (lambda nil (interactive) 
       (progn
         (TeX-save-document (TeX-master-file)) 
	 (TeX-command "LaTeX" (quote TeX-master-file) -1))))))

(add-hook 'LaTeX-mode-hook 
  (lambda () (local-set-key (kbd "C-c r") 
    (lambda nil (interactive) 
       (TeX-command "View" (quote TeX-master-file) -1)))))

(add-hook 'Latex-mode-hook
  (lambda () (local-set-key (kbd "C-TAB") '(TeX-complete-symbol))))
