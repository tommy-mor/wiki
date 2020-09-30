;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(column-number-mode 1)


(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (revert-buffer t t))

(require 'package)
(add-to-list 'package-archives
			 '("melpa-stable" . "https://melpa.org/packages/") t)
(eval-when-compile ;; Following line is not needed if use-package.el is in ~/.emacs.d (require 'use-palllCKAGE)
  (require 'use-package)) 
(setq use-package-always-ensure t)
(use-package undo-tree)
(use-package evil :config (evil-mode 1))
(use-package evil-leader :config
  (global-evil-leader-mode 1)
  (evil-leader/set-leader ",")
  (evil-leader/set-key
	"f" 'helm-find-files
	"b" 'helm-mini
	"k" 'helm-show-kill-ring
	"a" 'company-mode
	"TAB" 'mode-line-other-buffer
	"v" 'er/expand-region
	"c" 'comment-region
	"r" 'revert-buffer-no-confirm
	"q" 'recompile ;; kill-this-buffer
	"d" 'kill-this-buffer
	"g" 'helm-grep-do-git-grep 
	"s" 'string-edit-at-point
	"p" 'font-lock-fontify-buffer))
(use-package evil-surround :ensure t :config (global-evil-surround-mode 1))
(use-package evil-smartparens)
(use-package smartparens :config (smartparens-global-mode 1) (evil-smartparens-mode 1))
(use-package helm :config 
  (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action)
  (helm-autoresize-mode 0))
(use-package expand-region)
(use-package company)
(use-package evil-colemak-basics :config (global-evil-colemak-basics-mode 1))
(use-package elpy :ensure t :init (elpy-enable) :config (setq python-shell-interpreter "python3"
															  elpy-rpc-python-command "python3"
															  python-shell-interpreter-args "-i"))
(use-package exec-path-from-shell :config (exec-path-from-shell-initialize))
(use-package typescript-mode)
(use-package csharp-mode)
(use-package typescript-mode)
(use-package flycheck)
(use-package racket-mode)
(use-package ng2-mode)
(use-package dokuwiki)
(use-package dokuwiki-mode :config (add-to-list 'auto-mode-alist '("\\.dwiki\\'" . dokuwiki-mode)))
;;(use-package parinfer
  ;;:ensure t
  ;;:bind
  ;;(("C-," . parinfer-toggle-mode))
  ;;:init
  ;;(progn
	;;(setq parinfer-extensions
		  ;;'(defaults       ; should be included.
			 ;;pretty-parens  ; different paren styles for different modes.
			 ;;evil           ; If you use Evil.
			 ;;paredit        ; Introduce some paredit commands.
			 ;;smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
			 ;;smart-yank))   ; Yank behavior depend on mode.
	;;(add-hook 'clojure-mode-hook #'parinfer-mode)
	;;(add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
	;;(add-hook 'common-lisp-mode-hook #'parinfer-mode)
	;;(add-hook 'scheme-mode-hook #'parinfer-mode)
	;;(add-hook 'lisp-mode-hook #'parinfer-mode)))


;; -------------------------- OPTIONS

(setq backup-directory-alist '(("" . "~/.emacs.d/emacs-backup")))

(global-linum-mode 1)
(global-set-key [C-right]  'move-end-of-line)
(global-set-key [C-left]   'move-beginning-of-line)
(setq ring-bell-function 'ignore)
(blink-cursor-mode 0)
(setq-default tab-width 4)
(setq indent-tabs-mode 1)
(windmove-default-keybindings)

(load-theme 'manoj-dark t)
;;(load-theme 'misterioso t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-hl-line-mode 0)

(setq show-paren-delay 0)
(show-paren-mode 1)



(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;;(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
;;(use-package web-mode)
;;(require 'web-mode)
;;(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;;(add-hook 'web-mode-hook
;;		  (lambda ()
;;			(when (string-equal "tsx" (file-name-extension buffer-file-name))
;;			  (setup-tide-mode))))
;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)
;; -------------------------- HOOKS
(add-hook 'elpy-mode-hook
		  (lambda ()
			(setq-default indent-tabs-mode t)
			(setq-default tab-width 4)
			(setq-default py-indent-tabs-mode t)
			))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("ba7917b02812fee8da4827fdf7867d3f6f282694f679b5d73f9965f45590843a" default)))
 '(haskell-interactive-popup-errors nil)
 '(haskell-mode-hook (quote (interactive-haskell-mode)) t)
 '(package-selected-packages
   (quote
	(merlin reason-mode elm-mode tern symex ivy evil-lispy ivy-explorer ivy-dired-history kivy-mode ivy-clipmenu hy-mode moonscript evil-numbers latex-preview-pane auctex rainbow-delimiters markdown-mode evil-mc multiple-cursors eink-theme monokai-theme monokai-pro-theme string-edit vimish-fold hideshow-org gnu-elpa-keyring-update itail julia-repl julia-mode hindent hindent-mode haskell-mode cider clojure-mode dokuwiki-mode dokuwiki elpy racer evil-smartparens tide processing-mode use-package evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;(load "/home/tommy/.opam/default/share/emacs/site-lisp/tuareg-site-file")

;;(setq processing-location "/home/tommy/Documents/processing-3.4/processing-java")
;;(setq processing-application-dir "/home/tommy/Documents/processing-3.4/")
;;(setq processing-sketchbook-dir "/home/tommy/sketchbook")

(global-set-key (kbd "M-S") 'sp-splice-sexp)
(global-set-key (kbd "M-s") 'sp-split-sexp)
(global-set-key (kbd "C-9") 'sp-split-sexp)
(global-set-key (kbd "C-(") 'sp-backward-barf-sexp)
(global-set-key (kbd "C-)") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-9") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-0") 'sp-forward-slurp-sexp)
(global-set-key (kbd "s-k") 'kill-buffer)

(setq dokuwiki-xml-rpc-url "http://morriss.tk/lib/exe/xmlrpc.php")
(setq dokuwiki-login-user-name "tommy")
;;(eval-after-load "haskell-mode"
;;  '(define-key haskell-mode-map (kbd "C-c C-c") 'recompile))
(use-package hindent)
(add-hook 'haskell-mode-hook #'hindent-mode)
(add-hook 'haskell-mode-hook #'interactive-haskell-mode)

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;;(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)

(eval-after-load "lispy"
  `(progn
     ;; replace a global binding with own function
     ;;(define-key lispy-mode-map (kbd "C-e") 'my-custom-eol)
     ;; replace a global binding with major-mode's default
     ;;(define-key lispy-mode-map (kbd "C-j") nil)
     ;; replace a local binding
     (lispy-define-key lispy-mode-map "n" 'lispy-down)
     (lispy-define-key lispy-mode-map "e" 'lispy-up)
     (lispy-define-key lispy-mode-map "i" 'lispy-right)
     (lispy-define-key lispy-mode-map "E" 'lispy-eval)
     (lispy-define-key lispy-mode-map "f" 'lispy-flow)))

(evil-mode)
(use-package symex :ensure t)
(global-set-key (kbd "s-;") 'symex-mode-interface)  ; or whatever keybinding you like

;;(helm-posframe-enable)
(add-hook 'reason-mode-hook (lambda ()
          (add-hook 'before-save-hook #'refmt-before-save)))
(fset 'raise
   "%%x``x")
