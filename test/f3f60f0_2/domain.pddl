(define (domain appworld-f3f60f0-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song album - object
  )
  (:constants
    spotify - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (in-song-library ?s - song)
    (in-album-library ?al - album)
    (liked-song ?s - song)
    (liked-album ?al - album)
    (song-library-known)
    (liked-songs-known)
    (album-library-known)
    (liked-albums-known)
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
      (passwords-known)
      (password-for spotify ?pw)
      (not (has-token spotify ?t))
      (not (task-completed))
    )
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (song-library-known))
  )

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (liked-songs-known))
  )

  ; API: spotify.like_song
  (:action spotify-like-song
    :parameters (?s - song ?t - token)
    :precondition (and
      (has-token spotify ?t)
      (song-library-known)
      (liked-songs-known)
      (in-song-library ?s)
      (not (liked-song ?s))
      (not (task-completed))
    )
    :effect (and (liked-song ?s))
  )

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (album-library-known))
  )

  ; API: spotify.show_liked_albums
  (:action spotify-show-liked-albums
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (liked-albums-known))
  )

  ; API: spotify.like_album
  (:action spotify-like-album
    :parameters (?al - album ?t - token)
    :precondition (and
      (has-token spotify ?t)
      (album-library-known)
      (liked-albums-known)
      (in-album-library ?al)
      (not (liked-album ?al))
      (not (task-completed))
    )
    :effect (and (liked-album ?al))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (song-library-known)
      (liked-songs-known)
      (album-library-known)
      (liked-albums-known)
      (not (task-completed))
    )
    :effect (and (task-completed))
  )
)
