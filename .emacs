(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-refresh-contents)

(unless (package-installed-p 'cider)
  (package-install 'cider))
(unless (package-installed-p 'rainbow-delimiters)
  (package-install 'rainbow-delimiters))
(unless (package-installed-p 'auto-complete)
  (package-install 'auto-complete))
(unless (package-installed-p 'emacs-eclim)
  (package-install 'emacs-eclim))
(unless (package-installed-p 'company)
  (package-install 'company))
(unless (package-installed-p 's)
  (package-install 's))
(unless (package-installed-p 'haskell-mode)
  (package-install 'haskell-mode))
(unless (package-installed-p 'ghc)
  (package-install 'ghc))
(unless (package-installed-p 'company-ghc)
  (package-install 'company-ghc))
(unless (package-installed-p 'shm)
  (package-install 'shm))

(setenv "PATH" (concat "~/.cabal/bin:" (getenv "PATH")))
(add-to-list 'exec-path "~/.cabal/bin")

(setq org-log-done 'time)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-log-messages t)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-tab-command 'indent-for-tab-command)
(global-company-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(eval-after-load 'haskell-mode
          '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))

(custom-set-variables
 '(company-ghc-show-info t)
 '(custom-enabled-themes (quote (wombat)))
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-tags-on-save nil)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
  (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)))
(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

(eval-after-load 'haskell-mode
'(define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile))
(eval-after-load 'haskell-cabal
'(define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile))

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(require 'cl) 
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-ghc)

(add-hook 'org-mode-hook 'turn-on-font-lock)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(require 'eclim)
(require 'eclimd)
(global-eclim-mode)

(custom-set-variables
 '(eclim-eclipse-dirs '("/opt/eclipse"))
 '(eclim-executable "/opt/eclipse/eclim"))

(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

(require 'auto-complete-config)
(ac-config-default)

(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

(require 'ido)
(ido-mode t)

(setq inhibit-splash-screen t)

(blink-cursor-mode (- (*) (*) (*)))

(setq indent-tabs-mode nil)

(add-hook 'java-mode-hook (lambda ()
                                (setq c-basic-offset 4
                                      tab-width 4
                                      indent-tabs-mode t)))
