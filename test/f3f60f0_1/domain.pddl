(define (domain appworld-f3f60f0-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token count song album - object)
  (:constants
    spotify supervisor - app
    zero - count)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-song-library ?s - song)
    (in-album-library ?al - album)
    (liked-song ?s - song)
    (liked-album ?al - album)
    (song-library-known)
    (album-library-known)
    (liked-songs-known)
    (liked-albums-known)
    (count-pred ?n - count ?m - count)
    (unliked-library-songs ?n - count)
    (unliked-library-albums ?n - count)
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

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (song-library-known))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-songs-known))

  ; API: spotify.like_song
  (:action spotify-like-song
    :parameters (?s - song ?t - token ?n - count ?m - count)
    :precondition (and (has-token spotify ?t) (song-library-known) (liked-songs-known) (in-song-library ?s) (not (liked-song ?s)) (unliked-library-songs ?n) (count-pred ?n ?m) (not (task-completed)))
    :effect (and (liked-song ?s) (not (unliked-library-songs ?n)) (unliked-library-songs ?m)))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (album-library-known))

  ; API: spotify.show_liked_albums
  (:action spotify-show-liked-albums
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-albums-known))

  ; API: spotify.like_album
  (:action spotify-like-album
    :parameters (?al - album ?t - token ?n - count ?m - count)
    :precondition (and (has-token spotify ?t) (album-library-known) (liked-albums-known) (in-album-library ?al) (not (liked-album ?al)) (unliked-library-albums ?n) (count-pred ?n ?m) (not (task-completed)))
    :effect (and (liked-album ?al) (not (unliked-library-albums ?n)) (unliked-library-albums ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (unliked-library-songs zero) (unliked-library-albums zero) (not (task-completed)))
    :effect (task-completed))
)
