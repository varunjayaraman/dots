;; This buffer is for text that is not saved, and for Lisp evaluation.
;; To create a file, visit it with C-x C-f and enter text in its buffer.

;; Many old emacs libs depend on `cl` instead of `cl-lib`, and in Emacs-27 `cl` now carries a deprecation warning. We are just disabling this
(setq byte-compile-warnings '(cl-functions))

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)          ; Disable the menu bar

;; Set up visible bell instead of noisy one
;; (setq visible-bell t)

(set-face-attribute 'default nil :font "Fira Code" :height 150)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Configure backups to go to a directory outside of where files are being edited.
;; Otherwise they show up in version control and need to be explicitly gitignored
(setq backup-directory-alist `(("." . "~/.emacs_backups")))

;; initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platform
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(column-number-mode)
(global-display-line-numbers-mode t)
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package command-log-mode)

(use-package ivy
  :diminish ;; silences minor mode messages
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

(use-package doom-themes)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(load-theme 'doom-dracula t)

;; prog-mode is the base mode for any programming language
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package general
  :config
  (general-create-definer roonie/leader-keys
  :keymaps '(normal insert visual emacs)
  :prefix "SPC"
  :global-prefix "C-SPC")
  (roonie/leader-keys
    "t" '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme"))

(use-package undo-fu
  :ensure t
  :after evil
  :config
  ;; (global-undo-tree-mode -1)
  (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
  (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t) ;; remaps C-u to scroll instead of doing universal argument
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  ;; Allows you to use C-h in insert mode as backspace, so you dont have to reach for the backspace key.
  ;; However, if you do this, and you need to use the actual help version of C-h in insert mode, you will have
  ;; to remember to exit to normal mode and then do C-h
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Moves to next or previous visual line (so if text is wrapped, it would go to the same line but the next visual one)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(roonie/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/workspace/code")
    (setq projectile-project-search-path '("~/workspace/code"))))
(setq projectile-switch-project-action #'projectile-dired))

(setq ls-lisp-use-insert-directory-program nil)
(require 'ls-lisp)

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge
  :after magit)
(setq auth-sources '("~/.authinfo"))

(use-package super-save
  :ensure t
  :config
  (super-save-mode +1))

(setq auto-save-default nil)

(use-package org)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(use-package go-mode
  :defer t
  :ensure t
  :mode ("\\.go\\'" . go-mode)
  :init
  (setq compile-command "echo Building... && go build -v && echo Testing... && go test -v && echo Linter... && golint")
  (setq compilation-read-command nil)
  :bind (("M-." . godef-jump)))
(add-hook 'go-mode-hook #'smartparens-mode)

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Elixir
(use-package elixir-mode
  :ensure t
  :bind (:map elixir-mode-map
              ;; Runs test at point
              ("C-c C-t s" . exunit-verify-single)
              ;; Runs all tests in current buffer
              ("C-c C-t f" . exunit-verify)
              ;; Runs all tests in current project
              ("C-c C-t a" . exunit-verify-all)))

(add-hook 'elixir-mode-hook #'smartparens-mode)
(use-package exunit
  :ensure t)

;; LSP setup
(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "s-k")
  (add-to-list 'exec-path "~/dots/language-servers/elixir")
  (add-to-list 'exec-path "~/.local/share/gem/ruby/3.0.0/bin")
  :commands (lsp lsp-deferred)
  :config
  (defun roonie/lsp-format-buffer-quick ()
    (let ((lsp-response-timeout 2))
      (lsp-format-buffer)))
  (defun roonie/lsp-format-on-save ()
    (add-hook 'before-save-hook #'roonie/lsp-format-buffer-quick nil t))
  :hook ((
          go-mode
          elixir-mode). lsp-deferred))

;; Web
(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
         ("\\.css\\'"   . web-mode)
         ("\\.jsx?\\'"  . web-mode)
         ("\\.tsx?\\'"  . web-mode)
         ("\\.json\\'"  . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))))

(use-package emmet-mode
  :hook ((html-mode       . emmet-mode)
         (css-mode        . emmet-mode)
         (js-mode         . emmet-mode)
         (js-jsx-mode     . emmet-mode)
         (typescript-mode . emmet-mode)
         (web-mode        . emmet-mode))
  :config
  (setq emmet-insert-flash-time 0.001) ; effectively disabling it
  (add-hook 'web-mode-hook #'(lambda ()
                               (setq-local emmet-expand-jsx-className? t))))

;; Typescript & Javascript
(use-package typescript-mode
  :ensure t)
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; Ruby
(use-package inf-ruby
  :ensure t)
(use-package ruby-mode
  :ensure t
  :after lsp-mode
  :hook ((ruby-mode . lsp-deferred)
         (ruby-mode . roonie/lsp-format-on-save)))
(add-hook 'ruby-mode-hook #'smartparens-mode)

(use-package ruby-test-mode
  :after ruby-mode
  :diminish ruby-test-mode
  :config
  (defun roonie/ruby-test-pretty-error-diffs (old-func &rest args)
    "Make error diffs prettier."
    (let ((exit-status (cadr args)))
      (apply old-func args)
      (when (> exit-status 0)
        (diff-mode)
        ;; Remove self
        (advice-remove #'compilation-handle-exit #'roonie/ruby-test-pretty-error-diffs))))
  (defun roonie/ruby-test-pretty-error-diffs-setup (old-func &rest args)
    "Set up advice to enable pretty diffs when tests fail."
    (advice-add #'compilation-handle-exit :around #'roonie/ruby-test-pretty-error-diffs)
    (apply old-func args))
  (advice-add #'ruby-test-run-command :around #'roonie/ruby-test-pretty-error-diffs-setup))

(use-package lsp-ivy
  :ensure t)

;; Company mode is a standard completion package that works with lsp-mode
(use-package company
  :ensure t
  :config
  ;; Optionally enable completion as you type behavior
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-align-annotations t))

;; Smartparens
(use-package smartparens
  :ensure t)
(require 'smartparens-config)
(show-smartparens-global-mode +1)

;; Optional - provides snippet support
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(exunit elixir-mode flycheck super-save forge magit counsel-projectile projectile hydra evil-collection evil general helpful ivy-rich which-key rainbow-delimiters doom-modeline doom-themes counsel ivy command-log-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

