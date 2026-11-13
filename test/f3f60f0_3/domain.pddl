(define (domain appworld-f3f60f0-3)
  (:requirements :strips :typing :negative-preconditions :equality :universal-preconditions)
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
    (in-song-library ?s - song)
    (in-album-library ?al - album)
    (song-library-listed)
    (liked-songs-listed)
    (album-library-listed)
    (liked-albums-listed)
    (liked-song ?s - song)
    (liked-album ?al - album)
    (task-completed)
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
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t)
  )

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (song-library-listed)
  )

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-songs-listed)
  )

  ; API: spotify.like_song
  (:action spotify-like-song
    :parameters (?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (song-library-listed) (liked-songs-listed) (in-song-library ?s) (not (liked-song ?s)) (not (task-completed)))
    :effect (liked-song ?s)
  )

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (album-library-listed)
  )

  ; API: spotify.show_liked_albums
  (:action spotify-show-liked-albums
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-albums-listed)
  )

  ; API: spotify.like_album
  (:action spotify-like-album
    :parameters (?al - album ?t - token)
    :precondition (and (has-token spotify ?t) (album-library-listed) (liked-albums-listed) (in-album-library ?al) (not (liked-album ?al)) (not (task-completed)))
    :effect (liked-album ?al)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (forall (?s - song) (liked-song ?s)) (forall (?a - album) (liked-album ?a)) (not (task-completed)))
    :effect (task-completed))

)
