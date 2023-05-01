;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; package! ->  defined in packages.el, loads packages not available via init.el. Run DOOM SYNC afterwards.
;; use-package! -> defined in config.el, configures downloaded packages, including when to load, keybindings, hooks, initialization
;; after! -> used to configure packages not directly managed by DOOM, run after package is loaded.
;; map! -> defined in config.el, specify keybindings via ('define-key' or 'global-set-key', 'local-set-key' or 'evil-define-key')
;;           https://discourse.doomemacs.org/t/how-to-re-bind-keys/560
;;           map wraps key strings in (kbd) function so you don't have to.
;;           - (kbd "TAB") evaluates to \t,
;;           - (kbd "<tab>") evaluates to [tab]
;;           - hierarchy of active keymaps (EMACS)
;;             o global-map:
;;             o {major-mode}-map: used for buffers w/ major mode
;;             o {minor-mode}-map: more recently activated minor modes take precedence over earlier activated ones
;;             o general-override-mode-map: used for overriding keymaps, the most specific, like !important in CSS
;;
;;           - hierarchy of active keymaps (evil maps)
;;             o global: visible in all buffers of the corresponding state (e.g. evil-normal-state-map, evil-visual-state-map, evil-insert-state-map, etc.)
;;             o buffer-local: evil-normal-state-local, evil-visual-state-local, etc.
;;             o auxiliary: like normal python-mode-map is when in python-mode and normal state.
;;             o Note: the first two apply to all buffers or current buffer, while auxiliary applies to state and mode.
;;
;;           - Can only bind after the keymap exists, so use after! to bind to a keymap that is not yet loaded.
;;           (map!
;;              :after python
;;              :map python-mode-map
;;              "C-c C-c" #'python-shell-send-buffer)


;;--------------------------------
;; Begin JBJ Customizations
;;--------------------------------
;; gitconfig-mode and gitignore-mode helps magit when editing .gitignore and .gitconfig files
(package! gitconfig-mode :recipe (:host github :repo "magit/git-modes" :files ("gitconfig-mode.el")))
(package! gitignore-mode :recipe (:host github :repo "magit/git-modes" :files ("gitignore-mode.el")))
(package! zoom-window)
(package! lsp-origami)

;; not needed in Emacs 29+ ?
(package! tree-sitter)
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

;;--------------------------
;; DOOM Documentation
;;--------------------------
;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
