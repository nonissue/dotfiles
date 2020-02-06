;; Package set:tings
(require 'package)

(setq package-archives '(("gnu"          . "http://elpa.gnu.org/packages/")
                         ("melpa"        . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")

                         ("org"          . "http://orgmode.org/elpa/")))

(setq package-archive-priorities
        '(("org"          . 30)
          ("melpa-stable" . 20)
          ("gnu"          . 10)
          ("melpa"        . 0)))

(setq package-menu-hide-low-priority t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package use-package)
(use-package bind-key)

(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/settings")

(unless (boundp 'window-system)
        (defvar window-system (framep-on-display)))

(use-package no-littering
  :init
  (require 'no-littering))

(require 'sane-defaults)
(require 'gui)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "d1b4990bd599f5e2186c3f75769a2c5334063e9e541e37514942c27975700370" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "cd736a63aa586be066d5a1f0e51179239fe70e16a9f18991f6f5d99732cabb32" "b35a14c7d94c1f411890d45edfb9dc1bd61c5becd5c326790b51df6ebf60f402" default)))
 '(package-selected-packages
   (quote
    (subatomic256-theme spaceline doom-neotree use-package no-littering neotree doom-themes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
