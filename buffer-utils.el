;;; buffer-utils.el --- description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 zhanhe
;;
;; Author: zhanhe <http://github/zhanhe>
;; Maintainer: zhanhe <zhanhe18@gmail.com>
;; Created: March 25, 2021
;; Modified: March 25, 2021
;; Version: 0.0.1
;; Keywords:
;; Homepage: https://github.com/zhanhe/test
;; Package-Requires: ((emacs 27.1) (cl-lib "0.5"))
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  description
;;
;;; Code:
;;

(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

;;;###autoload
(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))


;;;###autoload
(defun kill-buffer-regex (regex)
  "Kill buffer by REGEX."
  (interactive "sRegex : ")
    (dolist (current-buffer-name (mapcar 'buffer-name (buffer-list)) result)
        (when (string-match regex current-buffer-name)
          (kill-buffer current-buffer-name))))



(provide 'buffer-utils)
;;; buffer-utils.el ends here
