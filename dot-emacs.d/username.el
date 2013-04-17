(setq debug-on-error t)

;; Menu bar and Tool bar, Line number display
(tool-bar-mode 0)
(menu-bar-mode 1)
;(setq linum-format "  %d ")
(global-linum-mode 1)
(column-number-mode 1) ; this is default anyway
(scroll-bar-mode 1)


;; Sanitize key-bindings - http://j.mp/ei3Gny
(global-set-key [delete] 'delete-char)
(global-set-key [home]   'beginning-of-line)
(global-set-key [end]    'end-of-line)
(display-time)
(setq next-line-add-newlines nil)
(global-font-lock-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
;(setq scroll-step 1)
(setq scroll-conservatively 101) ;; no jerky scrolling - http://j.mp/LQ1kyJ


; Make emacs faster (tip by Stuart Sierra)
(setq font-lock-verbose nil)


;;; Modernization - http://xahlee.org/emacs/emacs_make_modern.html
;; Disable autosave
(setq make-backup-files nil) ; stop creating those backup~ files
(setq auto-save-default nil) ; stop creating those #autosave# files
;; Show recently opened files in a  menu
(recentf-mode 1)


;; Line spacing
(defun toggle-line-spacing ()
  "Toggle line spacing between no extra space to extra half line height."
  (interactive)
  (if (eq line-spacing nil)
      (setq-default line-spacing 0.5) ; add 0.5 height between lines
    (setq-default line-spacing nil)   ; no extra heigh between lines
    ))
(global-set-key (kbd "<f7>") 'toggle-line-spacing)


(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (cond
      ;; Very large displays
      ((>= (x-display-pixel-width) 1920)
      (add-to-list 'default-frame-alist (cons 'width 220)))
      ;; Large displays
      ((>= (x-display-pixel-width) 1400)
      (add-to-list 'default-frame-alist (cons 'width 170)))
      ;; Moderate displays
      ((>= (x-display-pixel-width) 1280)
      (add-to-list 'default-frame-alist (cons 'width 138)))
      ;; Default/small displays
      (t
      (add-to-list 'default-frame-alist (cons 'width 80))))
;;    (if (> (x-display-pixel-width) 1280)
;;           (add-to-list 'default-frame-alist (cons 'width 200)) ; orig 120
;;           (add-to-list 'default-frame-alist (cons 'width 90))) ; orig 80
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
         (cons 'height (/ (- (x-display-pixel-height) 300) ; orig 200
                             (frame-char-height)))))))

(set-frame-size-according-to-resolution)


;; Font
;(set-default-font "-apple-courier-medium-r-normal--18-180-72-72-m-180-mac-roman")
;(set-default-font "-apple-inconsolata-medium-r-normal--13-130-72-72-m-130-iso10646-1")
;(set-default-font "-apple-inconsolata-medium-r-normal--14-180-72-72-m-180-iso10646-1")
(set-face-attribute 'default nil :family "Inconsolata" :height 100)


;; Load files - http://emacswiki.org/emacs/LoadPath
(let ((default-directory "~/.emacs.d/elpa/"))
  (normal-top-level-add-subdirs-to-load-path))
;; so that we don't have to mention individually the following style
;; (add-to-list 'load-path "~/.emacs.d/elpa/foo-0.1")


;; Popup and pos-tip (dependencies for auto-complete)
;(add-to-list 'load-path "~/.emacs.d/elpa/popup-0.5")
(require 'popup)
(require 'pos-tip)

;; Auto-complete setup for Clojure
;; See here: http://sebastianlab.com/post/2409175090/autocomplete-in-clojure
;; And here: https://github.com/purcell/ac-nrepl

;; Auto complete
;(add-to-list 'ac-dictionary-directories "~/.emacs.d//acdict")
(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;(setq 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)
(define-globalized-minor-mode
  real-global-auto-complete-mode
  auto-complete-mode (lambda () (if (not (minibufferp (current-buffer)))
                                  (auto-complete-mode 1))))
(real-global-auto-complete-mode t)
(setq ac-use-quick-help t)
(setq ac-quick-help-delay 1)
(setq ac-ignore-case 'smart)
(setq ac-set-trigger-key "TAB")
(setq ac-auto-start t) ; t (always) or nil (never) or number (min chars)


;; nREPL auto complete
;(add-to-list 'load-path "~/.emacs.d/elpa/ac-nrepl-0.17")
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
                 '(add-to-list 'ac-modes 'nrepl-mode))
(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)
(define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)


;; Slime auto complete
;(setq load-paths (cons "~/.emacs.d/ac-slime" load-path))
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
                 '(add-to-list 'ac-modes 'slime-repl-mode))


;; Slime (JS) setup
;; See - https://github.com/swank-js/swank-js
;; See - https://github.com/magnars/.emacs.d/blob/master/setup-slime-js.el
(add-to-list 'load-path "~/.emacs.d")
(add-hook 'after-init-hook
          #'(lambda ()
              (when (locate-library "slime-js")
                (require 'setup-slime-js))))
;; CSS
(add-hook 'css-mode-hook
          (lambda ()
            (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
            (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))


;; Fuzzy match
;(add-to-list 'load-path "~/.emacs.d/elpa/fuzzy-match-1.4")
(require 'fuzzy-match)


;; Ido mode - Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

;; ---------------
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ; fuzzy matching is a must have
 
;; This tab override shouldn't be necessary given ido's default 
;; configuration, but minibuffer-complete otherwise dominates the 
;; tab binding because of my custom tab-completion-everywhere 
;; configuration.
(add-hook 'ido-setup-hook 
          (lambda () 
            (define-key ido-completion-map [tab] 'ido-complete)))

;; ---------------
;;
(defun my-ido-ignore-buffers (name)
  "Ignore all c mode buffers -- example function for ido."
  (with-current-buffer name
    (cond ((or (derived-mode-p 'cvs-mode) (derived-mode-p 'sql-interactive-mode))
           nil)
          (t
           (string-match "^ ?\\*" name)))))
 
(setq-default ido-ignore-buffers '(my-ido-ignore-buffers)
                            ido-auto-merge-work-directories-length -1)
 
(ido-everywhere 1)

;; C-M-space should remove multiple whitespace lines into a single blank
;; character
(defun multi-line-just-one-space (&optional n)
  "Multi-line version of just-one-space: Delete all
  spaces, tabs and newlines around point,
  leaving one space (or N spaces)."
  (interactive "*p")
  (let ((orig-pos (point)))
    (skip-chars-backward " \t\n")
    (constrain-to-field nil orig-pos)
    (dotimes (i (or n 1))
      (if (= (following-char) ?\s)
    (forward-char 1)
  (insert ?\s)))
    (delete-region
     (point)
     (progn
       (skip-chars-forward " \t\n")
       (constrain-to-field nil orig-pos t)))))
(global-set-key (kbd "C-M-SPC") 'multi-line-just-one-space)


;; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;; Buffer tabs (tabbar)
(require 'tabbar)
(set-face-attribute
   'tabbar-default nil
    :background "gray60")
(set-face-attribute
   'tabbar-unselected nil
    :background "gray85"
     :foreground "gray30"
      :box nil)
(set-face-attribute
   'tabbar-selected nil
    :background "#f2f2f6"
     :foreground "black"
      :box nil)
(set-face-attribute
   'tabbar-button nil
    :box '(:line-width 1 :color "gray72" :style released-button))
(set-face-attribute
   'tabbar-separator nil
    :height 0.7)
(tabbar-mode 1)
;(tabbar-mode)
(global-set-key [(control shift tab)] 'tabbar-backward)
(global-set-key [(control tab)]       'tabbar-forward)

;; tabbar ruler
(require 'tabbar-ruler)
(setq tabbar-ruler-global-tabbar 't) ; If you want tabbar                    
;(setq tabbar-ruler-global-ruler 't) ; if you want a global ruler             
;(setq tabbar-ruler-popup-menu 't) ; If you want a popup menu.                
;(setq tabbar-ruler-popup-toolbar 't) ; If you want a popup toolbar


;; Textmate-mode is a minor mode, must be enabled
;(add-to-list 'load-path "~/.emacs.shantanu.d/textmate.el")
;(add-to-list 'load-path "~/.emacs.d/textmate-4")
(require 'textmate)
(textmate-mode)


;; Project mode
;(add-to-list 'load-path "~/.emacs.d/elpa/levenshtein-1.0")
(require 'levenshtein)
;(add-to-list 'load-path "~/.emacs.d/elpa/project-mode-1.0")
(require 'project-mode)
(autoload 'project-mode "project-mode" "Project Mode" t)
(project-load-all)
(project-mode 1)


;; Desktop-mode + Project-mode integration (tabs are auto-saved/restored)
;; adapted - http://code.google.com/p/ergoemacs/source/browse/trunk/ergoemacs/init_settings.el
;; adapted - http://stackoverflow.com/questions/10795988/emacs-desktop-save-mode-startup-error
(defun my-project-open ()
  (interactive)
  (project-open)
  (when (project-current)
    (desktop-save-mode 1)
    (setq desktop-save t)
    (setq desktop-load-locked-desktop t)
    (desktop-read)))
(global-set-key (kbd "s-j") 'my-project-open)  ;; open project with Cmd-j

;; Load a default theme
;(load-theme 'zenburn t)
;(load-theme 'sloarized t)
;(load-theme 'solarized-light t)
;(load-theme 'solarized-dark t)

;; nav - http://code.google.com/p/emacs-nav/
;; Uncomment lines below as needed
;(add-to-list 'load-path "~/.emacs.shantanu.d/emacs-nav-20110220")
;(require 'nav)

(add-to-list 'load-path "~/.emacs.d/el-get/tree-mode/")
(add-to-list 'load-path "~/.emacs.d/el-get/windata/")
(add-to-list 'load-path "~/.emacs.d/el-get/dirtree/")

;(add-to-list 'load-path "~/.emacs.d/installed")
(require 'tree-mode)
(require 'desktop)
(add-to-list 'desktop-globals-to-save 'windata-named-winconf)
(require 'dirtree)
(autoload 'dirtree "dirtree" "Add directory to tree view")

(defun my-project-dirtree ()
  (interactive)
  (if (project-current)
    (dirtree (project-default-directory (project-current)) t)
    (dirtree-show)))
(global-set-key (kbd "s-i") 'my-project-dirtree)  ;; open project dirtree with Cmd-i

