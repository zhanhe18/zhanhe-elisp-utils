;;; string-utils.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 zhanhe
;;
;; Author: zhanhe <https://github.com/zhanhe>
;; Maintainer: zhanhe <zhanhe18@gmail.com>
;; Created: April 14, 2021
;; Modified: April 14, 2021
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/zhanhe/string-utils
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:



(defun match-strings-all (&optional string)
    "Return the list of all expressions matched in last search.

  STRING is optionally what was given to `string-match'."
    (let ((n-matches (1- (/ (length (match-data)) 2))))
      (mapcar (lambda (i) (match-string i string))
              (number-sequence 0 n-matches))))




(provide 'string-utils)
;;; string-utils.el ends here
