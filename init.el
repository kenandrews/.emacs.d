(setq inhibit-startup-message t)

(scroll-bar-mode -1)    ; Turn off scrollbar
(tool-bar-mode -1)      ; Turn off toolbar
(tooltip-mode -1)       ; Turn off tooltips
(set-fringe-mode 10)    ; Give some breathing room
(menu-bar-mode -1)      ; Disable menu bar
(setq visible-bell t)   ; Disable audible bell

;; Set Font and Font Size

(set-face-attribute 'default nil :font "DejaVu Sans Mono" :height 125)

(load-theme 'tango-dark)

;; Make ESC quit prompts (If you are used to VIM keybindings)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources

(require 'package)

(setq package-archives '(("Melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
(use-package command-log-mode)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-biffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 15))


