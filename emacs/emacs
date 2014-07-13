(require 'magit)

; directory to put various el files into
; (add-to-list 'load-path "/usr/share/emacs/includes")

(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

; loads ruby mode when a .rb file is opened.
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".rhtml$" . html-mode) auto-mode-alist))

(add-hook 'ruby-mode-hook
        (lambda()
          (add-hook 'local-write-file-hooks
                    '(lambda()
                       (save-excursion
                         (untabify (point-min) (point-max))
                         (delete-trailing-whitespace)
                         )))
          (set (make-local-variable 'indent-tabs-mode) 'nil)
          (set (make-local-variable 'tab-width) 2)
          (imenu-add-to-menubar "IMENU")
          (define-key ruby-mode-map "\C-m" 'newline-and-indent)
          (require 'ruby-electric)
          (ruby-electric-mode t)
          ))
