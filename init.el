(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(use-package emacs
  :hook
  (window-setup
   . (lambda ()
     (load-theme 'leuven t)))
    :bind
  (("M-<up>" . #'scroll-other-window-down)
   ("M-<down>" . #'scroll-other-window)))

(use-package ibuffer
  :bind ([remap list-buffers] . ibuffer-other-window)
  :custom
  (ibuffer-default-sorting-mode 'recency)
  (ibuffer-show-empty-filter-groups nil)
  (ibuffer-expert t))

(use-package vertico
  :ensure t
  :init
  (setq vertico-multiform-commands
        '((consult-line buffer)
          (consult-imenu reverse buffer)
          (execute-extended-command flat)))
  (setq vertico-multiform-categories
        '((file buffer grid)
          (imenu (:not indexed mouse))
          (symbol (vertico-sort-function . vertico-sort-alpha))))

  (vertico-mode t)
  (vertico-multiform-mode t)
  :bind (:map vertico-map
	      ("M-V" . #'vertico-multiform-vertical)   
	      ("M-G" . #'vertico-multiform-grid)       
	      ("M-F" . #'vertico-multiform-flat)       
	      ("M-R" . #'vertico-multiform-reverse)    
	      ("M-U" . #'vertico-multiform-unobtrusive)))

(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package savehist
  :ensure t
  :init
  (savehist-mode t))

(use-package marginalia
  :ensure t
  :config (marginalia-mode))

(use-package consult
  :bind
  (("M-y" . 'consult-yank-from-kill-ring)
   ("C-x b" . 'consult-buffer)))

(use-package embark
  :bind
  ("C-." . embark-act))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (setq company-tooltip-align-annotations t)
  (global-company-mode t))
