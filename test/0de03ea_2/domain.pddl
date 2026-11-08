(define (domain appworld-0de03ea-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token playlist duration - object
  )
  (:constants
    spotify - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-library ?p - playlist)
    (walk-duration ?d - duration)
    (has-enough-downloaded ?p - playlist ?d - duration)
    (known-library-playlists)
    (known-downloaded-songs)
    (known-id ?p - playlist)
    (known-playlist-songs ?p - playlist)
    (queue-cleared)
    (playing-playlist ?p - playlist)
    (task-completed)
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
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?p - playlist)
    :precondition (and (has-token spotify ?t) (in-library ?p) (not (task-completed)))
    :effect (and (known-library-playlists) (known-id ?p))
  )

  ; API: spotify.show_downloaded_songs
  (:action spotify-show-downloaded-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (known-downloaded-songs))
  )

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token)
    :precondition (and (has-token spotify ?t) (known-library-playlists) (known-id ?p) (in-library ?p) (not (task-completed)))
    :effect (and (known-playlist-songs ?p))
  )

  ; API: spotify.clear_song_queue
  (:action spotify-clear-song-queue
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (queue-cleared))
  )

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token ?p - playlist ?d - duration)
    :precondition (and (has-token spotify ?t) (known-id ?p) (known-playlist-songs ?p) (known-downloaded-songs) (walk-duration ?d) (has-enough-downloaded ?p ?d) (queue-cleared) (not (task-completed)))
    :effect (and (playing-playlist ?p))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - playlist ?d - duration)
    :precondition (and (playing-playlist ?p) (walk-duration ?d) (has-enough-downloaded ?p ?d) (not (task-completed)))
    :effect (and (task-completed))
  )
)
