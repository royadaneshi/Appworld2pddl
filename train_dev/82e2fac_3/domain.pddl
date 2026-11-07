(define (domain appworld-82e2fac-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song song-title - object)
  (:constants spotify - app)
  (:predicates
    (supervisor ?p - person)
    (profile-known)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (album-library-known)
    (in-album-library ?s - song)
    (known-id ?s - song)
    (found-play-count ?s - song)
    (found-title ?s - song ?ti - song-title)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (username-for spotify ?u) (password-for spotify ?pw)
                       (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (album-library-known) (in-album-library ?s) (known-id ?s)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?ti - song-title)
    :precondition (and (known-id ?s) (in-album-library ?s) (not (task-completed)))
    :effect (and (found-play-count ?s) (found-title ?s ?ti)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ti - song-title ?s - song)
    :precondition (and (in-album-library ?s) (found-play-count ?s)
                       (found-title ?s ?ti) (not (task-completed)))
    :effect (task-completed))
)
