(define (domain appworld-82e2fac-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song song-title - object
  )
  (:constants
    spotify - app
  )
  (:predicates
    (profile-known)
    (passwords-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-library ?s - song)
    (known-id ?s - song)
    (details-known ?s - song)
    (least-played ?s - song)
    (title-of ?s - song ?ti - song-title)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (supervisor-username ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t)
  )

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (in-library ?s) (not (task-completed)))
    :effect (known-id ?s)
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song)
    :precondition (and (known-id ?s) (in-library ?s) (not (task-completed)))
    :effect (details-known ?s)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ti - song-title ?s - song)
    :precondition (and (least-played ?s) (details-known ?s) (title-of ?s ?ti) (not (task-completed)))
    :effect (task-completed)
  )
)
