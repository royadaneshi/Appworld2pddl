(define (domain appworld-1150ed6-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token song year - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-library ?s - song)
    (released-in ?s - song ?y - year)
    (target-year ?y - year)
    (found-library-song ?s - song ?y - year)
    (found-target-song ?s - song)
    (now-playing ?s - song)
    (target-song-playing)
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

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token ?s - song ?y - year)
    :precondition (and (has-token spotify ?t) (in-library ?s) (released-in ?s ?y) (target-year ?y) (not (task-completed)))
    :effect (and (found-library-song ?s ?y) (found-target-song ?s)))

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (found-target-song ?s) (not (task-completed)))
    :effect (and (now-playing ?s) (target-song-playing)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (target-song-playing) (not (task-completed)))
    :effect (and (task-completed)))
)
