;;
;; Load el-get - installs if necessary
;;
(add-to-list 'load-path (concat root-dir "el-get/el-get"))

(defun install-el-get ()
  (eval-url
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"))

(unless (require 'el-get nil t)
  (install-el-get))

;;
;; el-get Sources
;;
(setq el-get-sources
      '((:name dirtree
           :description "Directory tree view in Emacs"
           :type git
           :url "https://github.com/zkim/emacs-dirtree.git"
           :depends (tree-mode windata)
           :features dirtree)
          (:name tree-mode
               :type emacswiki
               :features tree-mode)
          (:name windata
               :type emacswiki
               :features windata)
          (:name yaml-mode
               :type git
               :url "https://github.com/yoshiki/yaml-mode.git"
               :features yaml-mode)))

;;
;; My Packages
;;
(setq my-packages
      (append
       '(autopair
         color-theme-tomorrow
         cssh
         ecb
         escreen
         full-ack
         git-blame
         git-emacs
         markdown-mode
         php-mode-improved
         smex
         solarized-theme
         undo-tree)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)
(el-get 'wait)
