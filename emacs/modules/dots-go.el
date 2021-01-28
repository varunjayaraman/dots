;;; package --- dots-go.el

(use-package go-mode
  :defer t
  :mode ("\\.go\\'" . go-mode)
  :init
  (setq compile-command "echo Building... && go build -v && echo Testing... && go test -v && echo Linter... && golint")
  (setq compilation-read-command nil)
  :bind (("M-." . godef-jump))
  :hook (
         (go-mode . smartparens-mode)
         (go-mode . lsp-go-install-save-hooks)
         (go-mode . yas-minor-mode)
         (go-mode . lsp-deferred)))

(use-package gotest
  :bind (("C-c C-t s" . go-test-current-test)
         ("C-c C-t f" . go-test-current-file)
         ("C-c C-t a" . go-test-current-project)))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(provide 'dots-go)

;;; dots-go.el ends here
