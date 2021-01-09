;;; core.el --- Core utilities for setting up emacs

;;; Commentary:

;; Defines some common functions and vars usable across Emacs config files

(require 'package)
(require 'use-package)

;;; Code:
(defun dots/ensure-package (package)
    "Install PACKAGE if it does not exist."
    (unless (package-installed-p package)
      (use-package package
        :ensure t)))
    
(provide 'dots-core.el)

;;; dots-core.el ends here
