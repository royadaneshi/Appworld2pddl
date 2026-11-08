(define (domain appworld-cef9191-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token artist - object)
  (:constants spotify supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (followed-artists-listed)
    (known-id ?art - artist)
    (known-follower-count ?art - artist)
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
    :parameters (?t - token ?art - artist)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (followed-artists-listed) (known-id ?art)))

  ; API: spotify.show_artist
  (:action spotify-show-artist
    :parameters (?art - artist)
    :precondition (and (known-id ?art) (followed-artists-listed) (not (task-completed)))
    :effect (and (known-follower-count ?art)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?art - artist)
    :precondition (and (followed-artists-listed) (known-follower-count ?art) (not (task-completed)))
    :effect (and (task-completed)))
)
