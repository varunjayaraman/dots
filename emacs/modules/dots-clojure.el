;;; package --- Configures clojure mode

;;; Commentary:

;; sets up necessary configuration for clojure mode

;;; Code:

;; Clojure
(use-package flycheck-clj-kondo)
(use-package clojure-mode
  :config
  :after flycheck-clj-kondo
  :hook ((clojure-mode . smartparens-strict-mode)
         (clojure-mode . aggressive-indent-mode)
         ))
(use-package cider)

(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
(add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion)

(provide 'dots-clojure)

;;; dots-clojure.el ends here
