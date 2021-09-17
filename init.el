; Added by Package.el.  This must come before configurations of
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

(use-package avy)







;(require 'gauche-mode)

(use-package evil :config (evil-mode 1))
(define-key evil-normal-state-map (kbd "<esc>") ())
;(use-package evil-snipe :config (evil-snipe-mode 1) (evil-snipe-override-mode 1))

(use-package evil-leader :config
  (global-evil-leader-mode 1)
  (evil-leader/set-leader ",")
  (evil-leader/set-key
	"f" 'helm-find-files
	"b" 'helm-mini
	"k" 'helm-show-kill-ring
	"a" 'company-mode
	;; TODO have evil leader with hold comma, then press tab stuff
	"TAB" 'mode-line-other-buffer
	"v" 'er/expand-region
	"c" 'comment-region
	"r" 'revert-buffer-no-confirm
	"q" 'recompile ;; kill-this-buffer
	;;"R" () ;; kill-this-buffer
	"d" 'kill-this-buffer
	"g" 'helm-grep-do-git-grep 
	"e" 'string-edit-at-point
	"s" 'aya-create
	"S" 'aya-expand
	"o" 'helm-occur
	"l" 'helm-locate
	"t" 'avy-goto-word-1
	"p" 'font-lock-fontify-buffer))

(setq avy-keys '(?a ?r ?s ?t ?h ?n ?e ?i))
										;"p" 'helm-projectile-find-file))
(use-package evil-surround :ensure t :config (global-evil-surround-mode 1))

(use-package undo-tree :config (global-undo-tree-mode) (evil-set-undo-system 'undo-tree))
(use-package evil-smartparens)
(use-package smartparens :config (smartparens-global-mode 1) (evil-smartparens-mode 1))
(use-package helm :config 
  (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action)
  (helm-autoresize-mode 0)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-locate-fuzzy-match t)
  (setq helm-recentf-fuzzy-match t))
(use-package helm-projectile)
(use-package tree-sitter)
(use-package tree-sitter-langs)
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)


(use-package expand-region)
(use-package company)
(use-package evil-colemak-basics :config (global-evil-colemak-basics-mode 1))
(use-package elpy :ensure t :init (elpy-enable) :config (setq python-shell-interpreter "python3"
															  elpy-rpc-python-command "python3"
															  python-shell-interpreter-args "-i"))
(add-hook 'inferior-python-mode-hook
          (lambda ()
            (setq comint-move-point-for-output t)))

(use-package exec-path-from-shell :config (exec-path-from-shell-initialize))
(use-package typescript-mode)
(use-package csharp-mode)
(use-package typescript-mode)
(use-package flycheck)
(use-package racket-mode)
(use-package ng2-mode)
(use-package dokuwiki)
(use-package dokuwiki-mode :config (add-to-list 'auto-mode-alist '("\\.dwiki\\'" . dokuwiki-mode)))
(use-package origami)
(use-package leuven-theme)
(use-package auto-yasnippet)
(use-package wakatime-mode)
(global-wakatime-mode 1)

(origami-mode 1)
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

;(load-theme 'manoj-dark t)
										;(load-theme 'misterioso t)
;; (load-theme 'leuven t)
(load-theme 'leuven-dark t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-hl-line-mode 0)

(setq show-paren-delay 0)
(show-paren-mode 1)



;;(defun setup-tide-mode ()
;;  (interactive)
;;  (tide-setup)
;;  (flycheck-mode +1)
;;  (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;  (eldoc-mode +1)
;;  (tide-hl-identifier-mode +1)
;;  ;; company is an optional dependency. You have to
;;  ;; install it separately via package-install
;;  ;; `M-x package-install [ret] company`
;;  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;;(add-hook 'before-save-hook 'tide-format-before-save)

; (add-hook 'typescript-mode-hook #'setup-tide-mode)
;;(use-package web-mode)
;;(require 'web-mode)
;;(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;;(add-hook 'web-mode-hook
;;		  (lambda ()
;;			(when (string-equal "tsx" (file-name-extension buffer-file-name))
;;			  (setup-tide-mode))))
;; enable typescript-tslint checker
; (flycheck-add-mode 'typescript-tslint 'web-mode)
;; -------------------------- HOOKS
(add-hook 'elpy-mode-hook
		  (lambda ()
			(setq-default indent-tabs-mode t)
			(setq-default tab-width 4) (setq-default py-indent-tabs-mode t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ba7917b02812fee8da4827fdf7867d3f6f282694f679b5d73f9965f45590843a" default))
 '(haskell-interactive-popup-errors nil)
 '(haskell-mode-hook '(interactive-haskell-mode) t)
 '(package-selected-packages
   '(lua-mode fennel-mode session symex buffer-stack auto-yasnippet tree-sitter-langs tree-sitter helm-projectile leuven-theme nix-mode origami tuareg merlin reason-mode elm-mode tern ivy evil-lispy ivy-explorer ivy-dired-history kivy-mode ivy-clipmenu hy-mode moonscript evil-numbers latex-preview-pane auctex rainbow-delimiters markdown-mode evil-mc multiple-cursors eink-theme monokai-theme monokai-pro-theme string-edit vimish-fold hideshow-org gnu-elpa-keyring-update itail julia-repl julia-mode hindent hindent-mode haskell-mode cider clojure-mode dokuwiki-mode dokuwiki elpy racer evil-smartparens tide processing-mode use-package evil-visual-mark-mode))
 '(session-use-package t nil (session))
 '(wakatime-api-key "b93ccd46-94c9-4b96-a195-4e0205b9cc36")
 '(wakatime-cli-path "/home/tommy/.local/bin/wakatime")
 '(wakatime-python-bin nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "M-S") 'sp-splice-sexp)
(global-set-key (kbd "M-s") 'sp-split-sexp)
(global-set-key (kbd "C-9") 'sp-split-sexp)
(global-set-key (kbd "C-(") 'sp-backward-barf-sexp)
(global-set-key (kbd "C-)") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-9") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-0") 'sp-forward-slurp-sexp)
(global-set-key (kbd "s-k") 'kill-buffer)

;;(eval-after-load "haskell-mode"
;;  '(define-key haskell-mode-map (kbd "C-c C-c") 'recompile))

;(use-package hindent)
;(add-hook 'haskell-mode-hook #'hindent-mode)
;(add-hook 'haskell-mode-hook #'interactive-haskell-mode)

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;;(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)

;;(helm-posframe-enable)
(add-hook 'reason-mode-hook (lambda ()
							  (add-hook 'before-save-hook #'refmt-before-save)))

(fset 'raise
   "%%x``x")

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2))) 

(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height))) 

(defun scroll-down-half ()         
  (interactive)                    
  (scroll-down (window-half-height)))


(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "C-n") 'scroll-up-half)
  (define-key evil-normal-state-map (kbd "C-e") 'scroll-down-half)
  ; overwrites top of window keybind
  ; have this be 'window-next' and 'window prev'
  (define-key evil-normal-state-map (kbd "H") 'windmove-left) 
  (define-key evil-normal-state-map (kbd "I") 'windmove-right))

(evil-define-key 'insert symex-mode-map
  (kbd "<escape>") 'symex-mode-interface)

(evil-define-key 'normal symex-mode-map
  (kbd "<escape>") 'symex-mode-interface)

; tree sitter bs
(defun tree-sitter-mark-bigger-node ()
  (interactive)
  (let* ((p (point))
		 (m (or (mark) p))
		 (beg (min p m))
		 (end (max p m))
		 (root (ts-root-node tree-sitter-tree))
		 (node (ts-get-descendant-for-position-range root beg end))
		 (node-beg (ts-node-start-position node))
		 (node-end (ts-node-end-position node)))
	;; Node fits the region exactly. Try its parent node instead.
	(when (and (= beg node-beg) (= end node-end))
	  (when-let ((node (ts-get-parent node)))
		(setq node-beg (ts-node-start-position node)
			  node-end (ts-node-end-position node))))
	(set-mark node-end)
	(goto-char node-beg)))

(setq er/try-expand-list (append er/try-expand-list
                                 '(tree-sitter-mark-bigger-node)))

; (load-file "~/.emacs.d/treenav.el")
(setq auto-save-file-name-transforms
	  `((".*" "~/.emacs-saves/" t)))

(setq undo-tree-visualizer-diff nil)
										; TODO make H and I switch left/right buffers
(save-place-mode t)
(use-package symex
  :config
  (symex-initialize)
  (global-set-key (kbd "s-;") 'symex-mode-interface)
  :custom
  (symex-modal-backend 'evil))  

(use-package cider)
(use-package session)
(add-hook 'after-init-hook 'session-initialize)

(setq auto-save-file-name-transforms
	  `((".*" "~/.emacs-saves/" t)))

(load "$HOME/.lisp.el")
(put 'match 'lisp-indent-function 'defun)
(setq line-number-mode t)
(setq column-number-mode t)
(setq visible-bell t)
(setq fill-column 70)
(setq default-major-mode 'text-mode)
(setq text-mode-hook
      '(lambda () (auto-fill-mode 1)))
(add-hook 'text-mode 'turn-on-auto-fill)
(show-paren-mode 1)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
