;;; lemmington.el --- RPC Emacs server            -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Fermin Munoz

;; Author: Fermin Munoz
;; Maintainer: Fermin Munoz <fmfs@posteo.net>
;; Created: 25 June 2023
;; Version: 0.0.1
;; Keywords: tools,languages
;; URL: https://codeberg.org/sasanidas/lemmigton
;; Package-Requires: ((emacs "27.1")(porthole "0.3.0"))
;; License: GPL-3.0-or-later

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Code:

;;;; The requires

(require 'cl-lib)
(require 'porthole)
(require 'elisp-refs)

(defgroup lemmington nil
  "Lemmington group."
  :group 'lemmington
  :link '(url-link :tag "Repository" "https://github.com/lem-project/lemmigton.git"))

(defcustom lemmington-user-export-functions nil
  "User defined functions to export."
  :group 'lemmington
  :type 'list)

(cl-defun lemmington-start-server (&key
			 (name "lemmington-server")
			 (port 55486)
			 (username "lem")
			 (password "lem"))
  "Start the porthole server.
Optionally, you can set as a key argument:
NAME : name of the server.
PORT: port of the server.
USERNAME: username for the basic-auth.
PASSWORD: password for the basic-auth."
  (porthole-start-server-advanced
   name
   :port port
   :username username
   :password password
   :publish-port nil
   :publish-username t
   :publish-password t))


(cl-defun lemmington-get-completion (prefix)
  "Return a list of symbols with PREFIX as prefix."
  (elisp-refs--filter-obarray (lambda (i)
				(string-prefix-p prefix (format "%s" i) t))))

;;TODO: Fix this ugly ignore errors
(cl-defun lemmington-symbol-location (symbol)
  "Return a a list of (file absolute-position) of SYMBOL."
  (ignore-errors
    (let ((symbol-intern (intern-soft symbol))
	  symbol-info)
      (cond
       ((functionp symbol-intern)
	(setf symbol-info
	      (find-definition-noselect symbol-intern nil)))
       ((boundp symbol-intern)
	(setf symbol-info
	      (find-definition-noselect symbol-intern 'defvar)))
       (t
	(cl-return-from lem-symbol-location
	  nil)))
      (list (buffer-file-name (car symbol-info))
	    (cdr symbol-info)))))

(cl-defun lemmington-symbol-documentation (symbol)
  "Return SYMBOL documentation."
  (let ((symbol-intern (intern-soft symbol)))
    (cond
     ((functionp symbol-intern)
      (documentation symbol-intern))
     ((boundp symbol-intern)
      (documentation-property symbol-intern 'variable-documentation))
     (t
      (cl-return-from lem-symbol-documentation
	nil)))))

(cl-defun lemmington-exported-functions ()
  (append *lemmigton-export-functions*
	  lemmington-user-export-functions))

(defvar *lemmigton-export-functions*
  '(lemmington-get-completion
    lemmington-symbol-location
    lemmington-symbol-documentation
    lemmington-exported-functions))

(cl-defun lemmington-export-functions (&key
			     (server "lemmington-server")
			     (functions *lemmigton-export-functions*))
  "Export FUNCTIONS to SERVER."
  (mapcar (lambda (fname)
	    (porthole-expose-function server fname))
	  (append functions lemmington-user-export-functions)))

(provide 'lemmington)

;;; lemmington.el ends here
