(setq inhibit-startup-message t)

(scroll-bar-mode -1)    ; Turn off scrollbar
(tool-bar-mode -1)      ; Turn off toolbar
(tooltip-mode -1)       ; Turn off tooltips
(set-fringe-mode 10)    ; Give some breathing room
(menu-bar-mode -1)      ; Disable menu bar
(setq visible-bell t)   ; Disable audible bell

;; Set Font and Font Size — Consolas on Windows, JetBrains Mono / DejaVu fallback on Linux
(set-face-attribute 'default nil
  :font (cond ((find-font (font-spec :name "Consolas"))         "Consolas")
              ((find-font (font-spec :name "JetBrains Mono"))   "JetBrains Mono")
              ((find-font (font-spec :name "DejaVu Sans Mono")) "DejaVu Sans Mono")
              (t "monospace"))
  :height 125)


;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa"        . "https://melpa.org/packages/")
			  ("melpa-stable" . "https://stable.melpa.org/packages/")
			  ("org"          . "https://orgmode.org/elpa/")
			  ("elpa"         . "https://elpa.gnu.org/packages/")
			  ("nongnu"       . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)
(package-refresh-contents)

(require 'use-package)
(setq use-package-always-ensure t)

;; Theme
(use-package dracula-theme
  :config (load-theme 'dracula t))

;; UI
(column-number-mode)
(global-display-line-numbers-mode t)
(show-paren-mode 1)

;; Which-key is built-in as of Emacs 30.1
(which-key-mode)
(setq which-key-idle-delay 0.3)

;; Recent files
(recentf-mode 1)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; Redirect backup files to a single directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/backups/" t)))

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Auto-completion
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2))

;; Common Lisp / SLIME setup
(use-package slime
  :init
  (setq inferior-lisp-program "sbcl")
  :config
  (slime-setup '(slime-fancy slime-company slime-quicklisp)))

(use-package slime-company
  :after (slime company)
  :config
  (setq slime-company-completion 'fuzzy))

(use-package paredit
  :hook ((lisp-mode       . paredit-mode)
         (slime-repl-mode . paredit-mode)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Magit - Git interface
(use-package magit
  :bind ("C-x g" . magit-status))

;; gptel - AI assistant (configured for Claude)
(use-package gptel
  :bind (("C-c g g" . gptel)
         ("C-c g s" . gptel-send)
         ("C-c g r" . gptel-rewrite))
  :config
  (setq gptel-model 'claude-sonnet-4-6
        gptel-backend (gptel-make-anthropic "Claude"
                        :stream t
                        :key (getenv "ANTHROPIC_API_KEY"))))

;; Org-roam - networked note-taking
(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/org-roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture))
  :config
  (org-roam-db-autosync-mode))

;; forge — PR/issue review inside magit
(use-package forge
  :after magit)

;; writeroom-mode — distraction-free writing
(use-package writeroom-mode
  :bind ("C-c W" . writeroom-mode))

;; Knowledge vault org-roam setup (optional — skipped silently if not present)
(load "~/.knowledge-work/org-roam-setup.el" t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((claude-code :url "https://github.com/stevemolitor/claude-code.el"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
