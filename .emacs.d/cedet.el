;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                CEDET                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(setq semantic-complete-inline-analyzer-displayor-class (quote semantic-displayor-ghost))
(global-ede-mode 1)
(require 'semantic/sb)
(semantic-mode 1)

;; Set up the Common Lisp environment
 (add-to-list 'load-path "/usr/share/emacs/site-lisp/slime/")
 (setq inferior-lisp-program "/usr/bin/sbcl")
 (require 'slime)
 (slime-setup)

;; Set up gtkmm include paths
(defun setup-gtkmm ()
  (interactive)
  (semantic-add-system-include "/usr/include/gtkmm-2.4")
  (semantic-add-system-include "/usr/include/gdkmm-2.4")
  (semantic-add-system-include "/usr/include/glibmm-2.4")
  (semantic-add-system-include "/usr/include/sigc++-2.0")  
  )

;; (semantic-add-system-include "/usr/include/cairomm-1.0")
;; (semantic-add-system-include "/usr/include/pango-1.0")
