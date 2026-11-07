(define (domain appworld-c901732-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token entity - object
    playlist song - entity
  )
  (:constants spotify supervisor - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (my-playlist ?pl - playlist)
    (in-playlist ?s - song ?pl - playlist)
    (most-played ?s - song ?pl - playlist)
    (known-id ?x - entity)
    (playlist-songs-known ?pl - playlist)
    (play-count-known ?s - song)
    (playing ?s - song)
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
    :precondition (and
      (profile-known)
      (passwords-known)
      (username-for spotify ?u)
      (password-for spotify ?pw)
      (not (has-token spotify ?t))
      (not (task-completed))
    )
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?pl - playlist)
    :precondition (and
      (has-token spotify ?t)
      (my-playlist ?pl)
      (not (task-completed))
    )
    :effect (and (known-id ?pl) (playlist-songs-known ?pl))
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?pl - playlist)
    :precondition (and
      (in-playlist ?s ?pl)
      (playlist-songs-known ?pl)
      (not (task-completed))
    )
    :effect (and (known-id ?s) (play-count-known ?s))
  )

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token ?s - song ?pl - playlist)
    :precondition (and
      (has-token spotify ?t)
      (known-id ?s)
      (play-count-known ?s)
      (in-playlist ?s ?pl)
      (most-played ?s ?pl)
      (not (task-completed))
    )
    :effect (and (playing ?s))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?s - song ?pl - playlist)
    :precondition (and
      (most-played ?s ?pl)
      (playing ?s)
      (not (task-completed))
    )
    :effect (and (task-completed))
  )
)
