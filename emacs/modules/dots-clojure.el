;;; package --- Configures clojure mode

;;; Commentary:

;; sets up necessary configuration for clojure mode

;;; Code:

;; Clojure
(use-package flycheck-clj-kondo)
(use-package clojure-mode
  :init
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        treemacs-space-between-root-nodes nil
        company-idle-delay 0.0
        company-minimum-prefix-length 1
        lsp-lens-enable t
        lsp-signature-auto-activate nil 
                                        ; lsp-enable-indentation nil ; uncomment to use cider indentation instead of lsp
                                        ; lsp-enable-completion-at-point nil ; uncomment to use cider completion instead of lsp
        )

  :after flycheck-clj-kondo)
(use-package cider)

(add-hook 'clojure-mode-hook 'lsp)
(add-hook 'clojurescript-mode-hook 'lsp)
(add-hook 'clojurec-mode-hook 'lsp)
(setq lsp-clojure-custom-server-command '("bash" "-c" "~/dots/language-servers/clojure-lsp"))
;; (add-hook 'cider-repl-mode-hook #'company-mode)
;; (add-hook 'cider-mode-hook #'company-mode)
;; (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
;; (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion)


(provide 'dots-clojure)

;;; dots-clojure.el ends here
