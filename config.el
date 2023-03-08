;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Jason config
(setq user-full-name "Jason Bruce Jones" user-mail-address "jason@brucejones.biz")
(setq doom-theme 'doom-vibrant)
(setq doom-font (font-spec :family "Iosevka Aile" :size 20 :weight 'Light))
(setq doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 18 :weight 'Light))
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
(map! :leader :desc "Switch Frame" "wf" #'+evil/next-frame)


;; -- clojure
(setq clojure-toplevel-inside-comment-form t)


;;------------------
;; JAVA
;;------------------
(setenv "JAVA_HOME"  "/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home/")
(setq lsp-java-java-path "/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home/bin/java")
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
    (java-mode . lsp)
    :init
    (add-to-list 'exec-path "/Users/jasonjones/GitData/elixir-ls/release")
    :config
    (dolist (match
           '("[/\\\\].direnv$"
             "[/\\\\]node_modules$"
             "[/\\\\]deps"
             "[/\\\\]build"
             "[/\\\\]_build"))
            (add-to-list 'lsp-file-watch-ignored match))
    (setq lsp-file-watch-ignored-directories '(".git" "deps")))

(after! lsp-ui
  (setq lsp-lens-enable 't)
   (setq lsp-ui-sideline-show-hover '1)
   (setq lsp-ui-doc-enable 't)
   (setq lsp-ui-doc-position 'bottom)
   (setq lsp-ui-doc-show-with-cursor nil)
   (setq lsp-ui-doc-show-with-mouse 't)
   (setq lsp-ui-doc-header 't)
   (setq lsp-ui-sideline-diagnostic-max-lines '10)
   (setq lsp-ui-sideline-show-hover nil)
   (setq lsp-ui-peek-always-show nil))

;; testing: from https://adam.kruszewski.name/2019-10-20-elixir-setup.html
;; (after! lsp-ui
;;   (setq lsp-ui-doc-max-height 13
;;         lsp-ui-doc-max-width 80
;;         lsp-ui-sideline-ignore-duplicate t
;;         lsp-ui-doc-header t
;;         lsp-ui-doc-include-signature t
;;         lsp-ui-doc-position 'bottom
;;         lsp-ui-doc-use-webkit nil
;;         lsp-ui-flycheck-enable t
;;         lsp-ui-imenu-kind-position 'left
;;         lsp-ui-sideline-code-actions-prefix "💡"
;;         ;; fix for completing candidates not showing after “Enum.”:
;;         company-lsp-match-candidate-predicate #'company-lsp-match-candidate-prefix
;;         ))

;; enable code folding
;; keybindings include {z c, z o, z r} for close, open, recursive
(use-package! lsp-origami
  :config
  (setq lsp-enable-folding 't)
  :hook
  (lsp-after-open-hook #'lsp-origami-try-enable)
  )

;; screws up .elixir_ls directory sometimes, so set to nil and reload emacs whenever dependencies change
(after! lsp-elixir
  (setq lsp-elixir-fetch-deps nil)
  (setq lsp-elixir-suggest-specs t)
  (setq lsp-elixir-signatue-after-complete t)
  )

;; flycheck config
(defvar-local my/flycheck-local-cache nil)
(defun my/flycheck-checker-get (fn checker property)
  (or (alist-get property (alist-get checker my/flycheck-local-cache))
      (funcall fn checker property)))
(advice-add 'flycheck-checker-get :around 'my/flycheck-checker-get)
(add-hook 'lsp-managed-mode-hook
          (lambda ()
            (when (derived-mode-p 'elixir-mode)
              (setq my/flycheck-local-cache '((lsp . ((next-checkers . (elixir-credo)))))))
            ))


;; configure web-mode for html.heex template files.
;; (use-package! web-mode
;;   :config
;;         (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
;;         (add-to-list 'auto-mode-alist '("\\.heex\\'" . web-mode))
;;         (setq web-mode-engines-alist '(("elixir" . "\\.ex\\'")))
;;         (add-to-list '+format-on-save-enabled-modes 'web-mode 'append) ;;will disable format-all in web-mode buffers)
;;         (set-face-attribute 'web-mode-html-tag-face nil :foreground "Orange")
;;         (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "Purple")
;;         (set-face-attribute 'web-mode-doctype-face nil :foreground "Blue"))

;;         (add-to-list 'auto-mode-alist '("\\.ex\\'" . web-mode))

;; (define-advice web-mode-guess-engine-and-content-type (:around (f &rest r) guess-engine-by-extension)
;;   (if (and buffer-file-name (equal "ex" (file-name-extension buffer-file-name)))
;;       (progn (setq web-mode-content-type "html")
;;          (setq web-mode-engine "elixir")
;;          (web-mode-on-engine-setted))
;;     (apply f r)))

(use-package
   polymode
  :ensure t
  :mode ("\\.ex\\'" . poly-elixir-web-mode)
  :init (setq web-mode-engines-alist '(("elixir" . "\\.ex\\'")))
  :config
  (define-hostmode poly-elixir-hostmode :mode 'elixir-mode)
  (define-innermode poly-surface-expr-elixir-innermode
    :mode 'web-mode
    :head-matcher (rx line-start (* space) "~H" (= 3 (char "\"'")) line-end)
    :tail-matcher (rx line-start (* space) (= 3 (char "\"'")) line-end)
    :head-mode 'host
    :tail-mode 'host
    :allow-nested nil
    :keep-in-mode 'host
    :fallback-mode 'host)
  (define-polymode poly-elixir-web-mode
    :hostmode 'poly-elixir-hostmode
    :innermodes '(poly-surface-expr-elixir-innermode)))


(global-so-long-mode 0)

    ;; :head-matcher (rx line-start (* space) "~H" (= 3 (char "\"'")) line-end)
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


;; bindings for multiple cursors
(map! :leader
      (:prefix-map ("d" . "Cursors")

       (:desc "Make all " "m" #'evil-mc-make-all-cursors)
       (:desc "Make & go next" "n" #'evil-mc-and-goto-next)
       (:desc "No make but go next" "N" #'evil-mc-and-goto-next)

       (:desc "Line beginning" "b" #'evil-mc-make-cursor-in-visual-selection-beg)
       (:desc "Line endings" "e" #'evil-mc-make-cursor-in-visual-selection-end)

       (:desc "Pause making" "p" #'evil-mc-pause-cursors)
       (:desc "Make here" "h" #'evil-mc-make-cursor-here)
       (:desc "Resume cursors" "r" #'evil-mc-resume-cursors)

       (:desc "Undo last" "u" #'evil-mc-undo-all-cursors)
       (:desc "Undo all" "U" #'evil-mc-undo-all-cursors)))

;; bindings for persp-mode
(map! :leader
      (:prefix-map ("e" . "Perspective")

       (:desc "Next" "n" #'persp-next)
       (:desc "Previous" "p" #'persp-prev)
       (:desc "Kill buffer" "K" #'persp-kill-buffer)
       (:desc "Window Switch" "S" #'persp-window-switch)
       (:desc "Load full state" "l" #'persp-load-state-from-file)
       (:desc "Load by name" "L" #'persp-load-from-file-by-names)
       (:desc "Import Window Config" "i" #'persp-import-win-conf)
       (:desc "Save to file by Name" "S" #'persp-save-to-file-by-names)
       (:desc "Add buffer" "a" #'persp-add-buffer)
       (:desc "Switch to buffer" "b" #'persp-switch-to-buffer)))

;; ibuffer customizations... still debugging
(setq ibuffer-saved-filter-groups
      '(("home"
         ("Elixir" (mode . elixir-mode))
	 ("Web" (or (mode . html-mode)
			(mode . css-mode)))
	 ("Config" (or (filename . ".doom.d")
			     (filename . "emacs-config")))
         ("Elixir System" (or
                   (name . "^\\*lsp-log\\*$")
                   (name . "^\\*elixir-ls\\*$")
                   (name . "^\\*alchemist-server\\*$")
                   (name . "^\\*elixir-ls::stderr\\*$")))
         ("System" (or
                   (name . "^\\*scratch\\*$")
                   (name . "^\\*Messages\\*$")
                   (name . "^\\*doom\\*$")
                   (name . "^\\*scratch\\*$")))
	 ("Magit" (name . "\*magit"))
	 ("Help" (or (name . "\*Help\*")
		     (name . "\*Apropos\*")
		     (name . "\*info\*"))))))

(setq ibuffer-show-empty-filter-groups nil)

(add-hook 'ibuffer-mode-hook
	  '(lambda ()
	     (ibuffer-auto-mode 1)
	     (ibuffer-switch-to-saved-filter-groups "home")))

;; June 7, 2022 see if tree-sitter for syntax highlighting...
;; (use-package! tree-sitter
;;    :hook (prog-mode . turn-on-tree-sitter-mode)
;;    :hook (tree-sitter-after-on . tree-sitter-hl-mode)
;;    :config
;;    (require 'tree-sitter-langs)
;;    ;; This makes every node a link to a section of code
;;    (setq tree-sitter-debug-jump-buttons t
;;          ;; and this highlights the entire sub tree in your code
;;          tree-sitter-debug-highlight-jump-region t))

;; January 1, 2023 - trying to get Github co-pilot working

;; accept completion from copilot and fallback to company

(global-copilot-mode 1)
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("C-[" . 'copilot-accept-completion)
         ("C-j" . 'copilot-accept-completion)
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)));;--------------------------
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
