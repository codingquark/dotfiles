;; -*-lisp-*-
;;
(in-package :stumpwm)

;; Set the contrib module dir
(set-module-dir "/usr/share/stumpwm/contrib")


;; Change the terminal to gnome-terminal
(defcommand gnome-terminal () ()
  "Start gnome-terminal instance"
  (run-shell-command "gnome-terminal"))
(define-key *root-map* (kbd "c") "gnome-terminal")


;; Model Line
(mode-line)
;; Things to be shown in the mode-line
(setf *screen-mode-line-format*
      (list "%n | %h | %v | %B | %M | %d"))
(toggle-mode-line (current-screen) ;; A command to toggle to mode-line for the current head.
                  (current-head))
(setf *window-border-style* :thin)
(setf *mode-line-background-color* "#202020")
(setf *mode-line-foreground-color* "#ece38b")
(setf *mode-line-border-color* "#3a585e")

;; A way to get docs for a variable
;; (with-output-to-string (*standard-output*) (describe 'stumpwm:*maildir-modeline-fmt*))

;; Load modules
(load-module "battery-portable")
(load-module "maildir")
