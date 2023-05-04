(setq user-full-name "Jason Bruce Jones" user-mail-address "jason@brucejones.biz")
(setq auto-save-default nil)
(global-auto-revert-mode t)
(setq projectile-project-search-path '("~/GitData/"))

(custom-set-faces!  '(aw-leading-char-face
     	              :foreground "white"
                      :background "red" weight bold
                      :height 2.5
                      :box (:line-width 4 :color "red")))
(global-so-long-mode 0)
;; configure zoom-window
(map! :leader
      :desc "Zoom Window" "x" #'zoom-window-zoom)

(after! projectile
  (setq projectile-enable-caching 'nil)
  (setq projectile-project-search-path '(("~/GitData" . 1))))

(after! zoom-window
  (setq zoom-window-mode-line-color "DarkGreen"))

(global-copilot-mode 1)
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("C-[" . 'copilot-accept-completion)
         ("C-j" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

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
	  #'(lambda ()
	     (ibuffer-auto-mode 1)
	     (ibuffer-switch-to-saved-filter-groups "home")))

;; font
(setq doom-font (font-spec :family "Iosevka Aile" :size 20 :weight 'Light))
(setq doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 18 :weight 'Light))

;; theme ;; (setq doom-theme 'misterioso) ;;(setq doom-theme 'doom-vibrant)
(setq doom-theme 'doom-nord-aurora)
(setq display-line-numbers-type 'relative)
(setq doom-vibrant-brighter-comments t)
(eshell-git-prompt-use-theme 'powerline)

(with-eval-after-load 'org
    (setq org-ellipsis " ▾")
    (require 'org-tempo)
    (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
    (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
    (add-to-list 'org-structure-template-alist '("ex" . "src elixir"))
    (add-to-list 'org-structure-template-alist '("py" . "src python")))

(setq org-directory "~/org/")
(with-eval-after-load 'evil-org
  (define-key evil-org-mode-map (kbd "<f9>") 'org-insert-structure-template))

(global-set-key (kbd "<f8>") '+treemacs/toggle)
(global-set-key (kbd "s-<up>") 'drag-stuff-up)
(global-set-key (kbd "s-<down>") 'drag-stuff-down)
(global-set-key (kbd "C-0") 'ace-window)
(define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
(map! :leader :desc "Switch Frame" "wf" #'+evil/next-frame)

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

(use-package! lsp-mode
  :commands lsp
  :diminish lsp-mode
  :custom
  (lsp-headerline-breadcrumb-enable t)
  :hook
    ((elixir-mode . lsp)
    (java-mode . lsp)
    (lsp-mode . lsp-headerline-breadcrumb-mode))
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
  (setq lsp-lens-enable nil)
  (setq lsp-ui-sideline-show-hover '1)
  (setq lsp-ui-doc-enable 't)
  (setq lsp-ui-doc-position 'bottom)
  (setq lsp-ui-doc-show-with-cursor nil)
  (setq lsp-ui-doc-show-with-mouse nil)
  (setq lsp-ui-doc-header 't)
  (setq lsp-ui-sideline-diagnostic-max-lines '10)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-peek-always-show nil)
  (setq lsp-diagnostics-provider :auto)
  (setq lsp-diagnostics-mode t))

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

;; JAVA
(setenv "JAVA_HOME"  "/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home/")
(setq lsp-java-java-path "/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home/bin/java")

(after! lsp-elixir
  (setq lsp-elixir-fetch-deps nil)
  (setq lsp-elixir-suggest-specs t)
  (setq lsp-elixir-signatue-after-complete t))

;; heex
(add-to-list 'auto-mode-alist '("\\.heex\\'" . web-mode))
;; this code is throwing a warning that 'make-variable-buffer-local needs to be callled at top level.  FIX ME'
;; (use-package
;;   polymode
;;   :ensure t
;;   :mode ("\\.ex\\'" . poly-elixir-web-mode)
;;   :init (setq web-mode-engines-alist '(("elixir" . "\\.ex\\'")))
;;   :config
;;   (define-hostmode poly-elixir-hostmode :mode 'elixir-mode)
;;   (define-innermode poly-surface-expr-elixir-innermode
;;     :mode 'web-mode
;;     :head-matcher (rx line-start (* space) "~H" (= 3 (char "\"'")) line-end)
;;     :tail-matcher (rx line-start (* space) (= 3 (char "\"'")) line-end)
;;     :head-mode 'host
;;     :tail-mode 'host
;;     :allow-nested nil
;;     :keep-in-mode 'host
;;     :fallback-mode 'host)
;;   (define-polymode poly-elixir-web-mode
;;     :hostmode 'poly-elixir-hostmode
;;     :innermodes '(poly-surface-expr-elixir-innermode)))
