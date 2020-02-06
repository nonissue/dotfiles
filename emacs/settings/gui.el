(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; Get rid of ugly splash screen
(setq inhibit-startup-screen t)

;; Theming
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;(setq custom-safe-themes t) ;; in case I want to use custom themes

;; Current appearance config
;;(use-package neotree)
;;(use-package subatomic256-theme)


;; Annoyingly have to use require
;; Looks better than neotree default
(use-package all-the-icons)
(when (display-graphic-p)
  (require 'doom-neotree))

;; (when (display-graphic-p)
;;  (use-package subatomic-theme))

;;(when (not (display-graphic-p))
;;  (use-package subatomic256-theme))

(set-face-attribute 'mode-line nil :box nil)

(global-hl-line-mode 1)

;; Set alarm bell to visual warning
(setq visible-bell t)

;; disable superfluous gui
(menu-bar-mode -1)
(when (display-graphic-p)
  (toggle-scroll-bar -1))
(tool-bar-mode -1)
(blink-cursor-mode -1)

;; Other visual stuff
(global-linum-mode 1)
(setq indicate-empty-lines -1)

;; show line numbers dynamically with spaces
(defadvice linum-update-window (around linum-dynamic activate)
  (let* ((w (length (number-to-string
                     (count-lines (point-min) (point-max)))))
         (linum-format (concat " %" (number-to-string w) "d ")))
    ad-do-it))

;; Cooool. The snippet below flashes modeline for bell
(defvar doom--modeline-bg nil)

(setq ring-bell-function
      (lambda ()
        (unless doom--modeline-bg
          (setq doom--modeline-bg (face-attribute 'mode-line :background)))
        (set-face-attribute 'mode-line nil :background "#54252C")
        (run-with-timer
         0.1 nil
         (lambda () (set-face-attribute 'mode-line nil :background doom--modeline-bg)))))

;; Set font
(defun font-exists-p (font)
  "Check that a font exists."
  (if (member font (font-family-list))
      t
    nil))

(when (font-exists-p "SF Mono")
  (set-frame-font "SF Mono-13"))

(provide 'gui)
