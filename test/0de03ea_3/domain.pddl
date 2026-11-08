(define (domain appworld-0de03ea-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token album duration - object)
  (:constants spotify supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-library ?al - album)
    (drive-duration ?d - duration)
    (downloaded-duration-covers ?al - album ?d - duration)
    (library-listed)
    (downloads-listed)
    (known-downloaded-duration ?al - album)
    (queue-cleared)
    (playing ?al - album)
    (suitable-album-playing)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (library-listed))

  ; API: spotify.show_downloaded_songs
  (:action spotify-show-downloaded-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (downloads-listed))

  ; API: spotify.show_album
  (:action spotify-show-album
    :parameters (?al - album)
    :precondition (and (library-listed) (downloads-listed) (in-library ?al) (not (task-completed)))
    :effect (known-downloaded-duration ?al))

  ; API: spotify.clear_song_queue
  (:action spotify-clear-song-queue
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (queue-cleared))

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token ?al - album ?d - duration)
    :precondition (and (has-token spotify ?t) (in-library ?al) (known-downloaded-duration ?al) (drive-duration ?d) (downloaded-duration-covers ?al ?d) (queue-cleared) (not (task-completed)))
    :effect (and (playing ?al) (suitable-album-playing)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (suitable-album-playing) (not (task-completed)))
    :effect (task-completed))
)
