;;; zhanhe-draft.el --- description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 zhanhe
;;
;; Author: zhanhe <http://github/zhanhe>
;; Maintainer: zhanhe <zhanhe18@gmail.com>
;; Created: March 26, 2021
;; Modified: March 26, 2021
;; Version: 0.0.1
;; Keywords:
;; Homepage: https://github.com/zhanhe/zhanhe-draft
;; Package-Requires: ((emacs 27.1) (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  description
;;
;;; Code:


;;;###autoload
(defun create-draft(title)
  "Create draft with a given TITLE."
  (interactive "sTitle : ")
  (let* (
        (draft-root "/Users/zhanhe/Documents/Draft/")
        (date (format-time-string "%Y-%m-%d" nil (current-time-zone)))
        (time-now (format-time-string "%H-%M" nil (current-time-zone)))
        (dest-save-folder (concat (file-name-as-directory draft-root) date)))
    (unless (file-exists-p dest-save-folder)
      (mkdir dest-save-folder))
    (find-file (concat
                (file-name-as-directory dest-save-folder)
                (format "%s-%s.org" title time-now)))))

(map!
 "C-c d" 'create-draft)

(provide 'zhanhe-draft)
;;; zhanhe-draft.el ends here
