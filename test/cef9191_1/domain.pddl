(define (domain appworld-cef9191-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token artist - object)
  (:constants spotify supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (following-listed)
    (found-most-followed ?ar - artist)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_following_artists
  (:action spotify-show-following-artists
    :parameters (?t - token ?ar - artist)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (following-listed) (found-most-followed ?ar)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ar - artist)
    :precondition (and (following-listed) (found-most-followed ?ar) (not (task-completed)))
    :effect (and (task-completed))))
