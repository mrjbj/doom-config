;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;;--------------------------------
;; Begin JBJ Customizations
;;--------------------------------
;; gitconfig-mode and gitignore-mode helps magit when editing .gitignore and .gitconfig files
(package! gitconfig-mode :recipe (:host github :repo "magit/git-modes" :files ("gitconfig-mode.el")))
(package! gitignore-mode :recipe (:host github :repo "magit/git-modes" :files ("gitignore-mode.el")))
(package! zoom-window)

(package! tree-sitter-langs)
;;(package! dap-elixir)
;; polymode-mode-map for keybindings
;; C-n to move to next chunk, C-p to move previous
(package! polymode)
(package! eshell-git-prompt)

(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
;;--------------------------
;; End of Customizations
;;--------------------------

