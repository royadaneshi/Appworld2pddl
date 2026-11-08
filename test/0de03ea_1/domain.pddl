(define (domain appworld-0de03ea-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token album duration - object
  )
  (:constants
    spotify supervisor - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (in-library ?al - album)
    (drive-duration ?d - duration)
    (downloads-sufficient ?al - album ?d - duration)
    (known-id ?al - album)
    (downloads-known)
    (queue-cleared)
    (queue-is-album ?al - album)
    (playing ?al - album)
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
    :precondition (and (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token ?al - album)
    :precondition (and (has-token spotify ?t) (in-library ?al) (not (task-completed)))
    :effect (and (known-id ?al))
  )

  ; API: spotify.show_downloaded_songs
  (:action spotify-show-downloaded-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (downloads-known))
  )

  ; API: spotify.clear_song_queue
  (:action spotify-clear-song-queue
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (queue-cleared))
  )

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token ?al - album ?d - duration)
    :precondition (and (has-token spotify ?t) (known-id ?al) (in-library ?al) (downloads-known) (drive-duration ?d) (downloads-sufficient ?al ?d) (queue-cleared) (not (task-completed)))
    :effect (and (playing ?al) (queue-is-album ?al) (not (queue-cleared)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?al - album)
    :precondition (and (playing ?al) (queue-is-album ?al) (not (task-completed)))
    :effect (and (task-completed))
  )
)
