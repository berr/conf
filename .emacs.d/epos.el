;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                EPOS                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set up EPOS environment
;; removes normal include path and add epos'
(defun setup-epos ()
  (interactive)
  (semantic-remove-system-include "/usr/include")
  (semantic-add-system-include "/mnt/gentoo32/epos/include"))

(defun teardown-epos ()
  (interactive)
  (semantic-remove-system-inculde "/mnt/gentoo32/epos/include")
  (semantic-add-system-include "/usr/include"))
