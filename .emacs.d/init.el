(require 'package)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(setq custom-file "C://Users//0xfarco//.emacs.d//.emacs.custom.el")

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(use-package company-jedi
  :ensure t)

(add-hook 'after-init-hook 'global-company-mode)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode 1)

(load-file custom-file)
