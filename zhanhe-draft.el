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

(require 'buffer-utils)
(require 'string-utils)
(require 'helm)

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

(defun extract-tag-from-file (filePath)
  (let*
      (
       (file-content (split-string (get-string-from-file filePath) "\n" t))
       (tags '())
       index
       )
    (dolist (line file-content)
      (setq index (cl-search "#+TAGS:" line))
      (when index
        (setq tags (vconcat tags (split-string (substring line (+ index 7)) " " t " ")))
        )
      )
    tags))


;;;###autoload
(defun list-draft-tags ()
  "List Tags under draft-root"
  (interactive)
  (let* (
         (draft-root "/Users/zhanhe/Documents/Draft/")
         (check-files (directory-files-recursively draft-root "org"))
         (tags '())
         )
    ;; list all org files.
    ;; find all tags in files.
    ;; two types of tag.
    ;;    1) split with :untouch:tag:
    ;;    2) after #+TAGS: split with space.
    ;; give them to helm-to-select
    (dolist (orgfile check-files)
      (setq tags (vconcat tags (extract-tag-from-file orgfile))))
    (setq tags (cl-sort
     (cl-delete-duplicates tags :test 'string-equal)
     'string-lessp
     :key 'downcase
     ))
    (helm :sources
          (helm-build-sync-source "Note Tags"
            :candidates (append tags nil)
            :action '(
                      ("Insert" . insert)
                      )
            )
          :buffer "*org tags*")
     ))


(list-draft-tags)

;; (map!
;;  "C-c d" 'create-draft)

(provide 'zhanhe-draft)
;;; zhanhe-draft.el ends here
