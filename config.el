;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!




;; Jason config
(setq user-full-name "Jason Bruce Jones" user-mail-address "jason@brucejones.biz")
;; theme
(setq doom-theme 'deeper-blue)
;; font

(setq doom-font (font-spec :family "Iosevka Aile" :size 20 :weight 'Regular))
(setq doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 18 :weight 'Regular))
;; line numbers
(setq display-line-numbers-type 'relative)
;; projectile
(setq projectile-project-search-path '("~/GitRepos/"))
;; org mode
(setq org-directory "~/org/")
;; so we can use cider-eval-sexp-at-point within a comment block
(setq clojure-toplevel-inside-comment-form t)
;; key mappings
(global-set-key (kbd "M-p") 'drag-stuff-up)
(global-set-key (kbd "M-n") 'drag-stuff-down)

(define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
;;(define-key evil-visual-state-map "\C-e" 'evil-end-of-line)
;;define-key evil-motion-state-map "\C-e" 'evil-end-of-line)


;; which-key integration gives you pop-up of keybindings after pressing leader key for the mode.
(use-package  lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "s-l")
  :config
  (lsp-enable-which-key-integration t))
;; so ace window switching uses easy-to-see identifiers
(custom-set-faces!
  '(aw-leading-char-face
    :foreground "white" :background "red"
    :weight bold :height 2.5 :box (:line-width 10 :color "red")))












;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


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
