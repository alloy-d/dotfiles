;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#ffffff" :foreground "#1a1a1a" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 80 :width normal :foundry "monotype" :family "Andale Mono")))))


;;;; EXTERNAL LIBRARIES ;;;;
;; add path for my elisp libraries
(add-to-list 'load-path "~/lib/elisp/")

;; use icomplete+
(require 'icomplete+)

;; use git-emacs
;;(require 'git-emacs)

;; use emacs-git-mode
(require 'git)
(autoload 'git-blame-mode "git-blame" "Minor mode for incremental blame for Git." t)

;; use nxhtml
(load "~/lib/elisp/nxhtml/autostart.el")
 (add-hook 'nxml-mode-hook
           (lambda () (rng-validate-mode 0))
           t)

;; use doxymacs
;(require 'doxymacs)
;(add-hook 'c-mode-common-hook 'doxymacs-mode)
;(defun my-doxymacs-font-lock-hook ()
;  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
;      (doxymacs-font-lock)))
;(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

;; use filladapt
(require 'filladapt)
(add-hook 'c-mode-common-hook 'turn-on-filladapt-mode)



;;;; MODES ;;;;
;; Configure org-mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-c l" 'org-store-link)
(global-set-key "\C-c a" 'org-agenda)
(global-set-key "\C-c b" 'org-iswitchb)
(setq-default calendar-week-start-day 1)

;; use lua mode for lua files
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;;;; GLOBAL MINOR MODES ;;;;
;; use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default standard-indent 2)

;; show line numbers in left margin
(global-linum-mode 1)

;; highlight the current line
(global-hl-line-mode 1)

;; get rid of the scrollbar and menubar
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)

;; display battery info on the mode line
(display-battery-mode 1)

;; display the column number in the mode line
(setq-default column-number-mode 1)

;; enable adaptive fill mode
;(setq-default adaptive-fill-mode 1)

;; enable icomplete-mode
(icomplete-mode 1)

;; use color in shells
(ansi-color-for-comint-mode-on)


;;;; CUSTOM FUNCTION DEFINITIONS ;;;;
(defun open-new-line (arg)
  "Open a new line below the current line and move to its start."
  (interactive "P")
  (end-of-line)
  (newline 1))

;;;; VARIABLE OVERRIDES ;;;;
;; tab width
(setq-default tab-width 2)

;; for mail
(setq-default user-mail-address "lloyda2@rpi.edu")
(setq-default mail-self-blind t)
(setq-default rmail-file-name "~/.rmail")

;;;; CUSTOM KEYBINDINGS ;;;;
;; give C-x C-m the same functionality as M-x
(global-set-key "\C-x\C-m" 'execute-extended-command)

;; bind backward-kill-word to C-w; rebind kill-region to C-x C-k
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)

;; rebind C-o to open-new-line
(global-set-key "\C-o" 'open-new-line)

;; bind C-f12 to shell
(global-set-key [(control f12)] 'shell)


(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)
