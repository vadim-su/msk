(msk/require-pkgs '(autopair
                    highlight-parentheses
                    multiple-cursors
                    company
                    yasnippet
                    ))

(set-default 'indent-tabs-mode nil)
(set-default 'tab-width 4)
(add-hook 'prog-mode-hook #'linum-mode)               ;Нумируем строки

(require 'autopair)
(autopair-global-mode t)

(require 'paren)
(show-paren-mode t)
(set-default 'show-paren-style 'mixed)

(require 'highlight-parentheses)
(global-highlight-parentheses-mode t)

(require'multiple-cursors)
(set-default 'mc/list-file (msk/concat-path msk-cache-dir "mc-list.el"))

;;Масштабная система автодополнения кода/текста
(progn
  (require 'company)
  (global-company-mode t)

  (require 'yasnippet)
  (yas-global-mode t)

  (defvar company-mode/enable-yas t
    "Включить сниппеты во все backend'ы company")

  (defun msk/company-backend-with-yas (backend)
    (if (or (not company-mode/enable-yas)
            (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend)  backend (list backend))
              '(:with company-yasnippet))))

  (defun msk/add-company-backend (backend)
    (add-to-list 'company-backends (msk/company-backend-with-yas backend)))

  (setq company-backends
        (mapcar #'msk/company-backend-with-yas company-backends)))

(msk/require-pkgs 'flycheck)
(global-flycheck-mode t)

(progn
  (require 'whitespace)
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  (global-whitespace-mode t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace))

(add-hook 'text-mode-hook (lambda () auto-fill-mode t))