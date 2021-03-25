;;; buffer-utils.el --- description -*- lexical-binding: t; -*-

;;; Code :

(defun kill-buffer-regex (regex)
  "Kill buffer by REGEX."
  (interactive "sRegex : ")
    (dolist (current-buffer-name (mapcar 'buffer-name (buffer-list)) result)
        (when (string-match regex current-buffer-name)
          (kill-buffer current-buffer-name))))



(provide 'buffer-utils)
