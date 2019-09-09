;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")


(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (revert-buffer t t))

(require 'package)
(add-to-list 'package-archives
			 '("melpa" . "https://melpa.org/packages/") t)
(eval-when-compile ;; Following line is not needed if use-package.el is in ~/.emacs.d (require 'use-palllCKAGE)
  (require 'use-package)) 
(setq use-package-always-ensure t)
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
	"q" 'recompile
	"g" 'helm-grep-do-git-grep 
	"p" 'font-lock-fontify-buffer))
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
(use-package parinfer
  :ensure t
  :bind
  (("C-," . parinfer-toggle-mode))
  :init
  (progn
	(setq parinfer-extensions
		  '(defaults       ; should be included.
			 pretty-parens  ; different paren styles for different modes.
			 evil           ; If you use Evil.
			 paredit        ; Introduce some paredit commands.
			 smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
			 smart-yank))   ; Yank behavior depend on mode.
	(add-hook 'clojure-mode-hook #'parinfer-mode)
	(add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
	(add-hook 'common-lisp-mode-hook #'parinfer-mode)
	(add-hook 'scheme-mode-hook #'parinfer-mode)
	(add-hook 'lisp-mode-hook #'parinfer-mode)))


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

(load-theme 'manoj-dark)
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
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
(use-package web-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
		  (lambda ()
			(when (string-equal "tsx" (file-name-extension buffer-file-name))
			  (setup-tide-mode))))
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
 '(package-selected-packages
   (quote
	(elpy racer evil-smartparens tide processing-mode use-package evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq processing-location "/home/tommy/Documents/processing-3.4/processing-java")
(setq processing-application-dir "/home/tommy/Documents/processing-3.4/")
(setq processing-sketchbook-dir "/home/tommy/sketchbook")
