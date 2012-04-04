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
                ;; Clojure stuff
                clojure-mode clojure-test-mode clojurescript-mode
                slime slime-repl clojure-project-mode
                ;; slime-fuzzy -- screws up slime-repl, don't install
                ;; Auto complete
                auto-complete ac-slime
                ;; Fuzzy match
                fuzzy fuzzy-match
                ;; ido-better-flex -- screws up textmate, don't install
                ;; Tab bar
                tabbar tabbar-ruler
                ;; Eye-candy
                highlight-parentheses highline col-highlight crosshairs vline
                highlight-symbol hl-sexp idle-highlight
                rainbow-delimiters
                maxframe
                ;; Text mate
                textmate
                ;; regex match
                all alpha
                ;; Paren matching
                mic-paren
                ;; Ruby stuff
                ruby-end)
  "A list of packages to ensure are installed at launch.")

(require 'cl)

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
)



;; Rainbox delimiters
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)


;; Auto complete
(require 'auto-complete)
(global-auto-complete-mode t)



