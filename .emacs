;; .emacs

(add-to-list 'load-path "~/sys/go/misc/emacs")
(add-to-list 'load-path "~/sys/lib/elisp")
(add-to-list 'load-path "~/sys/lib/elisp/color-theme-molokai")
(add-to-list 'load-path "~/sys/lib/elisp/ruby-mode")
(add-to-list 'load-path "/usr/lib/erlang/lib/tools-2.6.5.1/emacs")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/dvc")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/haskell-mode")

(add-to-list 'exec-path "/usr/lib/erlang/bin")

(require 'autopair)
(require 'color-theme-molokai)
;; (require 'erlang-start) ;; don't like this...
(require 'filladapt)
(require 'icomplete+)
;; (require 'git)

;; (autoload 'git-blame-mode "git-blame"
;;   "Minor mode for incremental blame for Git." t)
(autoload 'go-mode "go-mode"
  "Major mode for editing Go files.")
(autoload 'haml-mode "haml-mode"
  "Major mode for editing HAML files.")
(autoload 'haskell-mode "haskell-mode"
  "Major mode for editing Haskell files.")
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files.")
(autoload 'php-mode "php-mode"
  "Major mode for editing PHP files.")
(autoload 'quack "quack"
  "Enhanced support for editing and running Scheme code.")
(autoload 'ruby-mode "ruby-mode"
  "Major mode for editing Ruby files.")
(autoload 'sass-mode "sass-mode"
  "Major mode for editing Sass files.")
(autoload 'yaml-mode "yaml-mode"
  "Major mode for editing YAML files.")

;; (load "~/lib/elisp/nxhtml/autostart.el")


(setq diff-switches "-u")
(setq erlang-root-dir "/usr/lib/erlang")
(setq frame-title-format (concat "%b - emacs@" (system-name)))
(setq inhibit-startup-screen t)
(setq prolog-program-name "/usr/bin/pl")
(setq require-final-newline 'visit-save)

(setq-default browse-url-browser-function 'browse-url-generic)
(setq-default browse-url-generic-program "chromium")
(setq-default calendar-week-start-day 1)
(setq-default indent-tabs-mode nil)
(setq-default mail-self-blind t)
(setq-default rmail-file-name "~/.rmail")
(setq-default standard-indent 4)
(setq-default tab-width 4)
(setq-default user-mail-address "adam@alloy-d.net")


;; ;; laptop screen only
;; (set-face-attribute 'default nil
;;                     :family "Droid Sans Mono"
;;                     :height 98)
;; (set-face-attribute 'default nil
;;                     :family "Consolas"
;;                     :height 102)
;; (set-face-attribute 'default nil
;;                     :family "Inconsolata"
;;                     :height 102)

;; laptop screen and 1440x900 second monitor
;; (set-face-attribute 'default nil
;;                     :family "Inconsolata"
;;                     :height 120)
;; (set-face-attribute 'default nil
;;                     :family "Inconsolata"
;;                     :height 151)
;; (set-face-attribute 'default nil
;;                     :family "Droid Sans Mono"
;;                     :height 116)
;; (set-face-attribute 'default nil
;;                     :family "Consolas"
;;                     :height 141)
(set-face-attribute 'default nil
                    :family "Consolas"
                    :height 151)

;; ;; laptop screen and Sun monitor in AE215.
;; (set-face-attribute 'default nil
;;                     :family "Droid Sans Mono"
;;                     :height 135)
;; (set-face-attribute 'default nil
;;                     :family "Inconsolata"
;;                     :height 130)

(add-to-list 'auto-mode-alist '("\\.go$" . go-mode))
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'auto-mode-alist '("\\.m{d,arkdown}$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.notes$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.php[345]?$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.pl$" . prolog-mode))
(add-to-list 'auto-mode-alist '("\\.s$" . scheme-mode))
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

(add-to-list 'auto-mode-alist '("/PKGBUILD$" . shell-script-mode))


;; (defun doxymacs-font-lock-hook ()
;;   (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
;;       (doxymacs-font-lock)))

(defun open-new-line (arg)
  "Open a new line below the current line and move to its start."
  (interactive "P")
  (end-of-line)
  (newline-and-indent))

;; (dolist (command '(yank yank-pop))
;;   (eval `(defadvice ,command (after indent-region activate)
;;            (and (not current-prefix-arg)
;;                 (member major-mode '(c-mode
;;                                      c++-mode
;;                                      emacs-lisp-mode
;;                                      haskell-mode
;;                                      latex-mode
;;                                      lua-mode
;;                                      plain-tex-mode
;;                                      python-mode
;;                                      ruby-mode
;;                                      scheme-mode))
;;                 (let ((mark-even-if-inactive transient-mark-mode))
;;                   (indent-region (region-beginning) (region-end) nil))))))


(add-hook 'c-mode-common-hook 'turn-on-filladapt-mode)
;; (add-hook 'font-lock-mode-hook  'doxymacs-font-lock-hook)
(add-hook 'nxml-mode-hook
          (lambda () (rng-validate-mode 0))
          t)
(add-hook 'ruby-mode-hook
          (lambda ()
            (add-hook 'local-write-file-hooks
                      '(lambda ()
                         (save-excursion
                           (untabify (point-min) (point-max))
                           (delete-trailing-whitespace)
                           )))
            (set (make-local-variable 'indent-tabs-mode) 'nil)
            (set (make-local-variable 'tab-width) 2)
            (define-key ruby-mode-map "\C-m" 'reindent-then-newline-and-indent)
            ))


(global-set-key "\C-c a" 'org-agenda)
(global-set-key "\C-c b" 'org-iswitchb)
(global-set-key "\C-c l" 'org-store-link)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-o" 'open-new-line)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-x\C-m" 'execute-extended-command)


(ansi-color-for-comint-mode-on)
(autopair-global-mode)
(color-theme-molokai)
(column-number-mode 1)
;; (display-battery-mode 1)
(display-time-mode 1)
(fringe-mode (cons 4 4))
(global-hl-line-mode 1)
(icomplete-mode 1)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)



(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
