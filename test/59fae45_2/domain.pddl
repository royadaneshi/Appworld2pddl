(define (domain appworld-59fae45-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token playlist song title count - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (owned-playlist ?pl - playlist)
    (in-playlist ?s - song ?pl - playlist)
    (song-count ?pl - playlist ?n - count)
    (playlist-count ?n - count)
    (count-next ?n1 - count ?n2 - count)
    (new-title-for ?pl - playlist ?nt - title)
    (playlists-listed)
    (songs-listed ?pl - playlist)
    (genre-checked ?pl - playlist ?s - song)
    (songs-checked ?pl - playlist ?n - count)
    (title-updated ?pl - playlist)
    (playlists-updated ?n - count)
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
    :effect (playlists-listed))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token)
    :precondition (and (has-token spotify ?t) (playlists-listed) (owned-playlist ?pl) (not (task-completed)))
    :effect (songs-listed ?pl))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?pl - playlist ?n1 - count ?n2 - count)
    :precondition (and (songs-listed ?pl) (in-playlist ?s ?pl) (not (genre-checked ?pl ?s)) (songs-checked ?pl ?n1) (count-next ?n1 ?n2) (not (task-completed)))
    :effect (and (genre-checked ?pl ?s) (songs-checked ?pl ?n2) (not (songs-checked ?pl ?n1))))

  ; API: spotify.update_playlist
  (:action spotify-update-playlist
    :parameters (?pl - playlist ?t - token ?nt - title ?n - count ?m1 - count ?m2 - count)
    :precondition (and (has-token spotify ?t) (owned-playlist ?pl) (songs-listed ?pl) (song-count ?pl ?n) (songs-checked ?pl ?n) (new-title-for ?pl ?nt) (not (title-updated ?pl)) (playlists-updated ?m1) (count-next ?m1 ?m2) (not (task-completed)))
    :effect (and (title-updated ?pl) (playlists-updated ?m2) (not (playlists-updated ?m1))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - count)
    :precondition (and (playlist-count ?n) (playlists-updated ?n) (not (task-completed)))
    :effect (task-completed)))
