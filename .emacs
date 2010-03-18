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
 '(exec-path (quote ("/home/dradcliffe/script/bin" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/games" "/usr/lib/emacs/23.1/x86_64-linux-gnu")))
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

;;;;;;;; dean modules ;;;;;;;;
(add-to-list 'load-path "~/.elisp")
(add-to-list 'load-path "~/.emacs.d")
(require 'magit)
(require 'redo)
(require 'yaml-mode)
(require 'haml-mode)

; experimental
(require 'mode-compile)
(require 'el-expectations)
(require 'rspec-mode)
; (load "nxhtml/autostart.el")

;;;;;;;; dean ruby stuff ;;;;;;;
;;(setf ruby-program-name "irb --inf-ruby-mode")
;;(require 'inf-ruby)
;temporary - pending ruby coolness
(add-to-list 'auto-mode-alist '("\\.rjs$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.spec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode)) 

;;;;;;;; experimental stuff ;;;;;;;;;
;; (setenv "PATH" (concat "/home/dradcliffe/script/bin:" (getenv "PATH")))
;; (setenv "REMOTE_SPEC_SERVER" "dradcliffe-ag.dev")
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'inf-ruby)
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))
;; (setf ruby-program-name "ssh dradcliffe-ag bash -c 'cd -P /export/web/cnuapp 1>/dev/null 2>&1 && script/console --inf-ruby-mode'")
(setf ruby-program-name "bash -c cd /home/chicagogrooves/src/chess_on_rails && script/console --inf-ruby-mode")

;;;;; music stuff (lilypond) ;;;;;;;
(autoload 'LilyPond-mode "lilypond-mode")
(setq auto-mode-alist
      (cons '("\\.ly$" . LilyPond-mode) auto-mode-alist))

(add-hook 'LilyPond-mode-hook (lambda () (turn-on-font-lock)))


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

