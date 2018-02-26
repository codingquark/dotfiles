;; -*-lisp-*-
;;
(in-package :stumpwm)

;; Set the contrib module dir
(set-module-dir "/home/codingquark/workspace/stumpwm-contrib")


;; Change the terminal to gnome-terminal
(defcommand gnome-terminal () ()
  "Start gnome-terminal instance"
  (run-shell-command "gnome-terminal"))
(define-key *root-map* (kbd "c") "gnome-terminal")
(defcommand firefox () ()
  "Start firefox web browser"
  (run-shell-command "firefox"))
(define-key *root-map* (kbd "C-f") "firefox")

;; Keybinding for emacsclient
(defcommand emacsclient () ()
  "Start emacsclient -c"
  (run-shell-command "emacsclient -c"))
(define-key *root-map* (kbd "C-e") "emacsclient")

;; Keybinding for arandr
(defcommand arandr () ()
  "Start arandr"
  (run-shell-command "arandr"))
(define-key *root-map* (kbd "C-a") "arandr")

;; Keybinding for pavucontrol
(defcommand pavucontrol () ()
  "Start pavucontrol"
  (run-shell-command "pavucontrol"))
(define-key *root-map* (kbd "C-p") "pavucontrol")

;; Keybinding for keepassx
(defcommand keepassx () ()
  "Start keepassx"
  (run-shell-command "keepassx"))
(define-key *root-map* (kbd "C-k") "keepassx")

;; Swap heads
(defcommand swap-heads () ()
  "Swap windows between heads"
  (let* ((cs (current-screen))
         (cg (current-group))
         (heads (stumpwm::screen-heads cs))
         (head-1-windows (stumpwm::head-windows cg (first heads)))
         (head-2-windows (stumpwm::head-windows cg (second heads))))
    (dolist (w head-1-windows)
      (stumpwm::pull-window w (first (stumpwm::head-frames cg (second heads)))))
    (dolist (w head-2-windows)
      (stumpwm::pull-window w (first (stumpwm::head-frames cg (first heads)))))))
(define-key *root-map* (kbd "C-(") "swap-heads")


;; Model Line
;; (mode-line)
;; Things to be shown in the mode-line
(setf *screen-mode-line-format*
      (list "%n | %h | %v | %B | %d | %l"))
(setf *window-border-style* :thin)
(setf *mode-line-background-color* "#202020")
(setf *mode-line-foreground-color* "#ece38b")
(setf *mode-line-border-color* "#3a585e")
(toggle-mode-line (current-screen) ;; A command to toggle to mode-line for the current head.
                  (current-head))

(setf (group-name (car (screen-groups (current-screen)))) "internet")
(run-commands "gnewbg emacs"
              "gnewbg terminals"
              "gnewbg passwords"
              "gnewbg music"
              "gnewbg misc")

;; A way to get docs for a variable
;; (with-output-to-string (*standard-output*) (describe 'stumpwm:*maildir-modeline-fmt*))

;; Load modules
(load-module "battery-portable")
(load-module "net")
