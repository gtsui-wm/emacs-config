;; Don't launch startup menu
(setq inhibit-startup-message t)

;; Visible bell (mute alert sounds)
(setq visible-bell t)

(scroll-bar-mode -1) ; Disable visible scrollbar
(tool-bar-mode -1) ; Disable toolbar
(tooltip-mode -1) ; Disable tooltip
(menu-bar-mode -1) ; Disable menu bar

;; Disable backup files, autosave, scratch buffer
(setq make-backup-files nil)
(setq auto-save-default nil)
(kill-buffer "*scratch*")

;; Display column number
(setq column-number-mode t)

;; Key bindings
(global-set-key "\C-z" 'undo)
(global-set-key "\C-y" 'clipboard-yank)
(global-set-key "\M-w" 'clipboard-kill-ring-save)

;; Show matching parentheses
(show-paren-mode 1)

;; Display line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(set-face-attribute 'line-number nil :foreground "grey50")

;; Transparent `emacs -nw`
(defun set-background-for-terminal (&optional frame)
 (or frame (setq frame (selected-frame)))
 "unsets the background color in terminal mode"
 (unless (display-graphic-p frame)
   (set-face-background 'default "unspecified-bg" frame)))
(add-hook 'after-make-frame-functions 'set-background-for-terminal)
(add-hook 'window-setup-hook 'set-background-for-terminal)

;; Theme
(load-theme 'tango-dark t)

;; Initialize package sources
(require 'package)
(setq package-archives '(("melpha" . "http://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpha/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Ivy (for completion mechanism)
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
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))
(ivy-mode 1)

(use-package swiper :ensure t)

;; which-key for displaying keybindings
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1.0))

;; rainbow-delimiters for easy visualization of delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)))

;; company-mode for autocompletion
(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(use-package cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
