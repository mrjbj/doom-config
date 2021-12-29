;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Jason config
(setq user-full-name "Jason Bruce Jones" user-mail-address "jason@brucejones.biz")
(setq doom-theme 'doom-vibrant)
(setq doom-font (font-spec :family "Iosevka Aile" :size 20 :weight 'Regular))
(setq doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 18 :weight 'Regular))
(setq display-line-numbers-type 'relative)
(setq projectile-project-search-path '("~/GitData/"))
(setq org-directory "~/org/")

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

;;------------------
;; JBJ Elixir Config
;;------------------
  (use-package! lsp-mode
    :commands lsp
    :diminish lsp-mode
    :hook
    (elixir-mode . lsp)
    :init
    (add-to-list 'exec-path "/Users/jasonjones/GitData/elixir-ls")
    :config
    (dolist (match
           '("[/\\\\].direnv$"
             "[/\\\\]node_modules$"
             "[/\\\\]deps"
             "[/\\\\]build"
             "[/\\\\]_build"))
            (add-to-list 'lsp-file-watch-ignored match)))

;;(after! lsp-mode
;;  (dolist (match
;;           '("[/\\\\].direnv$"
;;             "[/\\\\]node_modules$"
;;             "[/\\\\]deps"
;;             "[/\\\\]build"
;;             "[/\\\\]_build"))
;;    (add-to-list 'lsp-file-watch-ignored match)))

(after! lsp-ui
   (setq lsp-ui-sideline-show-hover '1)
   (setq lsp-ui-doc-enable 't)
   (setq lsp-ui-doc-position 'bottom)
   (setq lsp-ui-doc-show-with-cursor nil)
   (setq lsp-ui-doc-show-with-mouse 't)
   (setq lsp-ui-doc-header 't)
   (setq lsp-ui-sideline-diagnostic-max-lines '10)
   (setq lsp-ui-sideline-show-hover nil)
   (setq lsp-ui-peek-always-show 't))

;; enable code folding
;; keybindings include {z c, z o, z r} for close, open, recursive
(setq lsp-enable-folding t)
(use-package! lsp-origami)
(add-hook! 'lsp-after-open-hook #'lsp-origami-try-enable)

;; screws up .elixir_ls directory sometimes, so set to nil and reload emacs whenever dependencies change
(after! lsp-elixir
  (setq lsp-elixir-fetch-deps nil))

;; works! as long as elixir-credo is added as dependency in mix.exs
(add-hook! elixir-mode
  (setq flycheck-checker 'elixir-credo))

;; configure web-mode for html.heex template files.
(use-package! web-mode
  :config
        (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
        (add-to-list 'auto-mode-alist '("\\.heex\\'" . web-mode))
        (setq web-mode-engines-alist '(("elixir" . "\\.ex\\'")))
        (add-to-list '+format-on-save-enabled-modes 'web-mode 'append) ;;will disable format-all in web-mode buffers)
        (set-face-attribute 'web-mode-html-tag-face nil :foreground "Orange")
        (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "Purple")
        (set-face-attribute 'web-mode-doctype-face nil :foreground "Blue"))

        ;; (add-to-list 'auto-mode-alist '("\\.ex\\'" . web-mode))

(setq mmm-global-mode 'maybe)
(setq mmm-parse-when-idle 't)
(setq mmm-set-file-name-for-modes '(web-mode))
(custom-set-faces '(mmm-default-submode-face ((t (:background nil)))))
(let ((class 'elixir-eex)
    (submode 'web-mode)
    (front "^[ ]+~L\"\"\"")
    (back "^[ ]+\"\"\""))
  (mmm-add-classes (list (list class :submode submode :front front :back back)))
  (mmm-add-mode-ext-class 'elixir-mode nil class))

(define-advice web-mode-guess-engine-and-content-type (:around (f &rest r) guess-engine-by-extension)
  (if (and buffer-file-name (equal "ex" (file-name-extension buffer-file-name)))
      (progn (setq web-mode-content-type "html")
         (setq web-mode-engine "elixir")
         (web-mode-on-engine-setted))
    (apply f r)))

;; setup after web-mode and elixir-mode have been configured
;; (use-package! polymode
;;   :mode ("\.ex$" . poly-elixirweb-mode)
;;   :init (setq! web-mode-engines-alist '(("elixir" . "\.ex$")))
;;   :config
;;   (define-hostmode poly-elixirweb-hostmode :mode 'elixir-mode)
;;   (define-innermode poly-elixirweb-innermode
;;     :mode 'web-mode
;;     :head-matcher  (rx line-start (* space) "~L" (= 3 (char "\"'")) line-end)
;;     :tail-matcher (rx line-start (* space) (= 3 (char "\"'")) line-end)
;;     :head-mode 'host
;;     :tail-mode 'host
;;     :allow-nested nil
;;     :fallback-mode 'host)
;;   (define-polymode poly-elixirweb-mode
;;     :hostmode 'poly-elixirweb-hostmode
;;     :innermodes '(poly-elixirweb-innermode)))



;;    :head-matcher "^[[:space:]]*~L\"\"\"[[:space:]]*\n"
;;    :tail-matcher "^[[:space:]]*\"\"\"[[:space:]]*\n"

;; configure zoom-window
(map! :leader
      :desc "Zoom Window" "x" #'zoom-window-zoom)

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
