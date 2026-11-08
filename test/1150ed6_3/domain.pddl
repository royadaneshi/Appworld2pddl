(define (domain appworld-1150ed6-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token year playlist song - object)
  (:constants spotify - app year-2020 - year)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-library ?pl - playlist)
    (in-playlist ?s - song ?pl - playlist)
    (released-in ?s - song ?y - year)
    (playlist-library-listed)
    (playlist-songs-listed ?pl - playlist)
    (known-id ?s - song)
    (found-release-year ?s - song)
    (music-started)
    (playing ?s - song)
    (playing-song-of-year ?y - year)
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

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (playlist-library-listed))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token)
    :precondition (and (has-token spotify ?t) (playlist-library-listed) (in-library ?pl) (not (task-completed)))
    :effect (playlist-songs-listed ?pl))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?pl - playlist)
    :precondition (and (in-playlist ?s ?pl) (playlist-songs-listed ?pl) (not (task-completed)))
    :effect (and (known-id ?s) (found-release-year ?s)))

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token ?s - song ?y - year)
    :precondition (and (has-token spotify ?t) (known-id ?s) (found-release-year ?s) (released-in ?s ?y) (not (music-started)) (not (task-completed)))
    :effect (and (music-started) (playing ?s) (playing-song-of-year ?y)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (playing-song-of-year year-2020) (not (task-completed)))
    :effect (task-completed)))
