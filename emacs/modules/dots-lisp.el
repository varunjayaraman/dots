;;; dots-lisp.el --- Configuration for lisp modes

;;; Commentary:

;; Configuration for all Lisp modes or lisp-like modes (clojure, emacs-lisp, etc)

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
(dots/ensure-package 'smartparens)
(dots/ensure-package 'rainbow-delimiters)

(defun roonie/lisp-defaults ()
  (smartparens-strict-mode +1)
  (rainbow-delimiters-mode +1))

(defun roonie/interactive-lisp-defaults ()
  (roonie/lisp-defaults)
  (whitespace-mode -1))

(setq roonie/lisp-coding-hook 'roonie/lisp-defaults)
(setq roonie/interactive-lisp-coding-hook 'roonie/interactive-lisp-defaults)

(provide 'dots-lisp)

;;; dots-lisp.el ends here

