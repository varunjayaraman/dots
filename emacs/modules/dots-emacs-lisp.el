;;; dots-emacs-lisp.el --- Configuration for Emacs Lisp

;;; Commentary:

;; Configuration for Emacs Lisp mode

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(require 'dots-lisp)
(dots/ensure-package 'elisp-slime-nav)
(dots/ensure-package 'rainbow-delimiters)

(defun roonie/recompile-on-save ()
  "Recompiles config when saving an elisp file inside the Emacs dir."
  (add-hook 'after-save-hook
            (lambda ()
              (when (and
                    (string-prefix-p roonie/emacs-dir (file-truename buffer-file-name))
                    (file-exists-p (byte-compile-dest-file buffer-file-name)))
              (emacs-lisp-byte-compile)))
  nil
  t))

(defun roonie/emacs-lisp-mode-defaults ()
  "Sets up some sensible defaults when editing elisp files."
  (run-hooks roonie/lisp-coding-hook)
  (roonie/recompile-on-save)
  (eldoc-mode +1)
  (rainbow-delimiters-mode +1))

(setq roonie/emacs-lisp-mode-hook 'roonie/emacs-lisp-mode-defaults)

(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'elisp-slime-nav-mode))

(add-hook 'emacs-lisp-mode-hook (lambda ()
                                  (run-hooks 'roonie/emacs-lisp-mode-hook)))

(provide 'dots-emacs-lisp)

;;; dots-emacs-lisp.el ends here
