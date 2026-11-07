(define (domain appworld-e7a10f8-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app username password token playlist song minutes - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (supervisor-email ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (library-listed)
    (songs-listed ?pl - playlist)
    (in-playlist ?s - song ?pl - playlist)
    (next-song ?s - song ?next - song)
    (ready ?s - song)
    (last-song ?s - song)
    (known-duration ?s - song)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known))
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (supervisor-email ?u) (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)))
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (and (library-listed))
  )

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (library-listed))
    :effect (and (songs-listed ?pl))
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?pl - playlist ?next - song)
    :precondition (and (not (task-completed)) (in-playlist ?s ?pl) (songs-listed ?pl) (ready ?s) (not (known-duration ?s)) (next-song ?s ?next))
    :effect (and (known-duration ?s) (ready ?next))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?m - minutes ?s - song)
    :precondition (and (not (task-completed)) (last-song ?s) (known-duration ?s))
    :effect (and (task-completed))
  )
)
