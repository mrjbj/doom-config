;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Jason config
(setq user-full-name "Jason Bruce Jones" user-mail-address "jason@brucejones.biz")
(setq doom-theme 'doom-vibrant)
(setq doom-font (font-spec :family "Iosevka Aile" :size 20 :weight 'Regular))
(setq doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 18 :weight 'Regular))
(setq display-line-numbers-type 'relative)
(setq projectile-project-search-path '("~/GitData/"))
(setq org-directory "~/org/")
;; (setq exec-path (append exec-path '("/Users/jasonjones/GitRepos/Elixir/dazzle/elixir-ls/release")))

;; ------------
;; keymappings
;; ------------
(define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
(global-set-key (kbd "M-p") 'drag-stuff-up)
(global-set-key (kbd "M-n") 'drag-stuff-down)
;;(global-set-key [f8] 'neotree-toggle)
(global-set-key (kbd "C-0") 'ace-window)


;; -- clojure
(setq clojure-toplevel-inside-comment-form t)

;; --------------------
;; ace window switching
;; --------------------
  (custom-set-faces!  '(aw-leading-char-face
	                :foreground "white"
                        :background "red" weight bold
                        :height 2.5
                        :box (:line-width 4 :color "red")))

;;-----------
;; JBJ Elixir Config
;;------------------
  (use-package! lsp-mode
    :commands lsp
    :diminish lsp-mode
    :hook
    (elixir-mode . lsp)
    :init
    (add-to-list 'exec-path "/Users/jasonjones/GitData/elixir-ls-1.12"))

(after! lsp-mode
  (dolist (match
           '("[/\\\\].direnv$"
             "[/\\\\]node_modules$"
             "[/\\\\]deps"
             "[/\\\\]build"
             "[/\\\\]_build"))
    (add-to-list 'lsp-file-watch-ignored match)))

(after! lsp-ui
   (setq lsp-ui-sideline-show-hover '1)
   (setq lsp-ui-doc-enable 't)
   (setq lsp-ui-doc-position 'bottom)
   (setq lsp-ui-doc-show-with-cursor 't)
   (setq lsp-ui-doc-show-with-mouse 't)
   (setq lsp-ui-doc-header 't)
   (setq lsp-ui-sideline-diagnostic-max-lines '10)
   (setq lsp-ui-peek-always-show 't))
;;
;; works! elixir-credo is added as dependency in mix.exs
(add-hook! elixir-mode
  (setq flycheck-checker 'elixir-credo))

;; configure web-mode for html.heex template files.
(add-to-list 'auto-mode-alist '("\\.html\\.heex\\'" . web-mode))
(add-to-list '+format-on-save-enabled-modes 'web-mode 'append) ;;will disable format-all in web-mode buffers

;; configure zoom-window
(map! :leader
      :desc "Zoom Window" "z" #'zoom-window-zoom)

(after! zoom-window
   (setq zoom-window-mode-line-color "DarkGreen"))

;; search 1 level deep for git repos in GitData
(after! projectile
  (setq projectile-enable-caching 'nil)
  (setq projectile-project-search-path '(("~/GitData" . 1))))

;;--------------------------
;; End of Customizations
;;--------------------------
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
