;; -*-lisp-*-
;;
(in-package :stumpwm)

;; Set the contrib module dir
(set-module-dir "/home/codingquark/workspace/stumpwm-contrib")


;; Change the terminal to gnome-terminal
(defcommand xterminal () ()
  "Start gnome-terminal instance"
  (run-shell-command "urxvt"))
(define-key *root-map* (kbd "c") "xterminal")

;; Keybinding for firefox
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

;; Keybinding for slock
(defcommand lock-screen () ()
  "Lock screen with slock"
  (run-shell-command "slock"))
(define-key *root-map* (kbd "F2") "lock-screen")

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


;; Increase / Decrease monitor brightness
(defun xbacklight-change (by)
  "Uses xbacklight to increment (or decrement) the backlight level"
  (run-shell-command (concatenate 'string "xbacklight " by))
  (message (concatenate 'string "Brightness: " by)))

(defcommand raise-backlight () ()
            "Raise backlight via xbacklight"
            (xbacklight-change "+5"))

(defcommand lower-backlight () ()
            "Lower backlight via xbacklight"
            (xbacklight-change "-5"))

(defcommand max-brightness () ()
  "Set brightness to 100%"
  (xbacklight-change "-set 100"))

(defcommand min-reasonable-brightness () ()
  "Set brightness to 35%"
  (xbacklight-change "-set 35"))

(define-key *top-map* (kbd "XF86MonBrightnessUp") "raise-backlight")
(define-key *top-map* (kbd "XF86MonBrightnessDown") "lower-backlight")
(define-key *root-map* (kbd "XF86MonBrightnessUp") "max-brightness")
(define-key *root-map* (kbd "XF86MonBrightnessDown") "min-reasonable-brightness")


;; Model Line
;; (mode-line)
;; Things to be shown in the mode-line
;; ^> makes the date right aligned.
(setf *screen-mode-line-format*
      (list "%n | %h | %v | %B | %M | %l ^>%d"))
;; Styling
(setf *window-border-style* :thin)
;; (setf *mode-line-background-color* "#202020")
(setf *mode-line-background-color* "#000000")
(setf *mode-line-foreground-color* "#ece38b")
;; (setf *mode-line-foreground-color* "#767676")
(setf *mode-line-border-color* "#000000")
;; Set the datetime format: e.g: Thu Mar 3 23:05
(setf *time-modeline-string* "%a %b %e %k:%M")

(setf *mode-line-timeout* 1)

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
(load-module "mem")
