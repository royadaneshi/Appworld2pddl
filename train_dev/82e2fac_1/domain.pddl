(define (domain appworld-82e2fac-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token song song-title - object)
  (:constants spotify - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (playlists-listed)
    (in-playlists ?s - song)
    (found-like-count ?s - song)
    (most-liked ?s - song)
    (title-of ?s - song ?ti - song-title)
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
    :precondition (and (profile-known) (supervisor-username ?u) (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (playlists-listed))
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song)
    :precondition (and (playlists-listed) (in-playlists ?s) (not (task-completed)))
    :effect (and (found-like-count ?s))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ti - song-title ?s - song)
    :precondition (and (most-liked ?s) (title-of ?s ?ti) (found-like-count ?s) (not (task-completed)))
    :effect (and (task-completed))
  )
)
