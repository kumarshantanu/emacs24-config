(when window-system
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)


(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages
  '(starter-kit starter-kit-lisp starter-kit-bindings
                starter-kit-js starter-kit-ruby
                ;; Auto complete
                popup pos-tip auto-complete
                ;; Clojure stuff
                clojure-mode clojure-test-mode clojurescript-mode
                slime slime-repl clojure-project-mode
                nrepl ac-nrepl nrepl-ritz
                slime slime-repl ac-slime
                ;; slime-fuzzy -- screws up slime-repl, don't install
                ;; Fuzzy match
                fuzzy fuzzy-match
                ;; ido-better-flex -- screws up textmate, don't install
                ;; multiple-cursors
                multiple-cursors
                ;; Tab bar
                tabbar tabbar-ruler
                ;; Eye-candy
                highlight-parentheses highline col-highlight crosshairs vline
                highlight-symbol hl-sexp idle-highlight
                rainbow-delimiters
                maxframe
                fill-column-indicator
                ;; Text mate
                textmate
                ;; regex match
                all alpha
                ;; Paren matching
                mic-paren
                ;; Ruby stuff
                ruby-end
                ;; Color themes
                zenburn-theme solarized-theme)
  "A list of packages to ensure are installed at launch.")

;; load extra packages
(load-file (concat root-dir "packages.el"))

(require 'cl)

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
)



;; Rainbow delimiters
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)


;; Auto complete
(require 'auto-complete)
(global-auto-complete-mode t)


;; Right margin - http://www.emacswiki.org/emacs/FillColumnIndicator
(require 'fill-column-indicator)
(setq fci-style 'shading)            ; 'shading (default) or 'rule
(add-hook 'find-file-hook 'fci-mode) ; or (add-hook 'c-mode-hook 'fci-mode) for C files
(setq fci-rule-width 2)              ; Value can be 1 to 6
(setq fci-rule-color "blue")         ; gray (default) or darkblue or whatever
(setq-default fill-column 80)
