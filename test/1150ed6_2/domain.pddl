(define (domain appworld-1150ed6-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token album song - object)
  (:constants spotify supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-album-library ?al - album)
    (song-in-album ?s - song ?al - album)
    (released-in-2021 ?s - song)
    (album-library-listed)
    (album-songs-known ?al - album)
    (known-id ?s - song)
    (known-release-year ?s - song)
    (playing ?s - song)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (album-library-listed)))

  ; API: spotify.show_album
  (:action spotify-show-album
    :parameters (?al - album)
    :precondition (and (album-library-listed) (in-album-library ?al) (not (task-completed)))
    :effect (and (album-songs-known ?al)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?al - album)
    :precondition (and (album-songs-known ?al) (song-in-album ?s ?al) (not (task-completed)))
    :effect (and (known-id ?s) (known-release-year ?s)))

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (known-id ?s) (known-release-year ?s) (not (task-completed)))
    :effect (and (playing ?s)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?s - song)
    :precondition (and (playing ?s) (not (task-completed)))
    :effect (and (task-completed)))
)
