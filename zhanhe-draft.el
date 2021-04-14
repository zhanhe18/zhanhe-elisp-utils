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


(defun count-seq-same-item (seq)
  "Count same items and return pair (\"abc\" 1))."
  (let*
      ((retlist '())
       )
    (while (not (seq-empty-p seq))
      (setq ele (seq-elt seq 0))
      (message "%s" ele)
      (setq retlist
            (push
             (list ele (seq-count
                        (lambda (x) (string-equal x ele))
                        seq)) retlist))
      (setq seq (seq-remove (lambda (x) (string-equal x ele)) seq)))
    retlist))


(defun list-draft-tags ()
  "List Tags under draft-root."
  (let* (
         (draft-root "/Users/zhanhe/Documents/Draft/")
         (check-files (directory-files-recursively draft-root "org"))
         (tags '())
         )
    ;; Check line starts with #+TAGS: .
    (dolist (orgfile check-files)
      (setq tags (vconcat tags (extract-tag-from-file orgfile))))
    (setq tags (cl-sort
                (count-seq-same-item tags)
                'string-lessp
                :key (lambda (x) (nth 0 x)
                       )))))



;;;###autoload
(defun show-draft-tags()
  "Show draft tags."
  (interactive)
  (helm :sources
        (helm-build-sync-source "Note Tags"
          :candidates
          (mapcar (lambda (x) (format "%-15s\t\t[%d]" (nth 0 x) (nth 1 x)))
                  (append (list-draft-tags) nil))
          :action '(
                    ("Insert" . (lambda (candidate)
                                  (insert
                                   (nth 0 (split-string candidate " " t " ")))))
                      )
          )))
;; (map!
;;  "C-c d" 'create-draft)

(provide 'zhanhe-draft)
;;; zhanhe-draft.el ends here
