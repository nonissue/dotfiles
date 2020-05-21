;; Package settings
(require 'package)
(setq package-user-dir "~/.emacs.d/packages")

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
(require 'key-bindings)
