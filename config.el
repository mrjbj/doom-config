;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Jason config
(setq user-full-name "Jason Bruce Jones" user-mail-address "jason@brucejones.biz")
(setq doom-theme 'doom-vibrant)
(setq doom-font (font-spec :family "Iosevka Aile" :size 20 :weight 'Regular))
(setq doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 18 :weight 'Regular))
(setq display-line-numbers-type 'relative)
(setq projectile-project-search-path '("~/GitRepos/"))
(setq org-directory "~/org/")
;; (setq exec-path (append exec-path '("/Users/jasonjones/GitRepos/Elixir/dazzle/elixir-ls/release")))

;; ------------
;; keymappings
;; ------------
(define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
(global-set-key (kbd "M-p") 'drag-stuff-up)
(global-set-key (kbd "M-n") 'drag-stuff-down)
(global-set-key [f8] 'neotree-toggle)
(global-set-key (kbd "C-0") 'ace-window)


;; commented add-ins
;; so we can use cider-eval-sexp-at-point within a comment block
(setq clojure-toplevel-inside-comment-form t)

;; ------------------
;; configure neotree
;; ------------------ 
;; configure neotree
;; 1. open file retains git project as root node for neotree
(defun neotree-project-dir ()
  "Open neoTree using git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
      (file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
       (if (neo-global--window-exists-p)
            (progn
                (neotree-dir project-dir)
                (neotree-find file-name)))
        (message "Could not find git project root."))))

;; neo-tree keymappings
	;; jump to current file everytime neo tree is opened
	(setq neo-smart-open t)
	;; change neotree root whenever projectile change project executes
	(setq projectfile-switch-project-action 'neotree-projectile-action)
	;; key mappings for vi mode
	(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
	(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
	(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
	(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
	;; (evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
	(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
	(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
	(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
	(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)

;; projectile
(setq projectile-project-search-path '("~/GitRepos/"))

(defadvice! prompt-for-buffer (&rest _)
  :after 'window-split (switch-to-buffer))

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

;; works!
(add-hook! elixir-mode
  (setq flycheck-checker 'elixir-credo))

;; configure web-mode for html.heex template files.
(add-to-list 'auto-mode-alist '("\\.html\\.heex\\'" . web-mode))
(add-to-list '+format-on-save-enabled-modes 'web-mode 'append) ;;will disable format-all in web-mode buffers
