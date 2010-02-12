;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dean's .emacs - Yay i finally feel like a real programmer !   ;;
;; I cant believe Ive gone so long without..                     ;;
;; Version 1.1                                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-mode-case-fold t)
 '(column-number-mode t)
 '(comint-use-prompt-regexp t)
 '(cua-mode t nil (cua-base))
 '(inhibit-startup-screen t)
 '(iswitchb-mode t)
 '(iswitchb-use-frame-buffer-list t)
 '(make-backup-files nil)
 '(save-place t nil (saveplace))
 '(server-mode t)
 '(shell-prompt-pattern "^[^>]*> *")
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(visible-bell t)
 '(x-select-enable-clipboard t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 108 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

;;;;;;;; dean ruby stuff ;;;;;;;
;;(setf ruby-program-name "irb --inf-ruby-mode")
;;(require 'inf-ruby)
;temporary - pending ruby coolness
(add-to-list 'auto-mode-alist '("\\.rjs$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode)) 

;;;;;;;; dean modules ;;;;;;;;
(add-to-list 'load-path "~/.elisp")
(add-to-list 'load-path "~/.emacs.d")
(require 'magit)
(require 'redo)
(require 'yaml-mode)
; (require 'haml-mode)

; experimental
(require 'mode-compile)
(require 'el-expectations)
(require 'rspec-mode)
; (load "nxhtml/autostart.el")

;;;;;;;; experimental stuff ;;;;;;;;;
;;(load-file "weblogger.el")
;; (load "weblogger.el")
;; (global-set-key "\C-cbs" 'weblogger-start-entry)

;;;;;;;; dean keyboard shortcuts (with comments) ;;;;;;;;
;; (global-set-key (kbd "<escape>")      'keyboard-escape-quit) ; fuck the emacs notion that i have to type Esc Esc Esc or Ctrl-G!
(global-set-key (kbd "<C-tab>") 'next-buffer)
(global-set-key [(control a)] 'mark-whole-buffer)
(global-set-key [(control f)] 'isearch-forward)
(global-set-key [(control w)] 'kill-buffer)
(global-set-key (kbd "<C-S-iso-lefttab>") 'previous-buffer)
(global-set-key (kbd "M-g M-s") 'magit-status)
(global-set-key [(meta z)]    'redo)                   
(global-set-key (kbd "<f7>") 'rspec-toggle-spec-and-target)

;;;;;;;; dean custom hackery ;;;;;;;;;
(defun dean/increase-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun dean/decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
                                  (face-attribute 'default :height)))))
(global-set-key (kbd "C-+") 'dean/increase-font-size)
(global-set-key (kbd "C--") 'dean/decrease-font-size)

;; let us navigate this cool iswitchb buffer app a little nicer
(defun iswitchb-local-keys ()
  (mapc (lambda (K) 
	  (let* ((key (car K)) (fun (cdr K)))
	    (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
	'(("<right>" . iswitchb-next-match)
	  ("<left>"  . iswitchb-prev-match)
	  ("<up>"    . ignore             )
	  ("<down>"  . ignore             ))))
(add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)

