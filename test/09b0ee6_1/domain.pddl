(define (domain appworld-09b0ee6-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token answer - object
    entity - object
    playlist song - entity)
  (:constants spotify supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (playlists-known)
    (known-id ?x - entity)
    (playlist-songs-known ?p - playlist)
    (in-playlist ?s - song ?p - playlist)
    (song-artists-known ?s - song)
    (found-top-artists ?ans - answer)
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
    :parameters (?t - token ?p - playlist)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (playlists-known) (known-id ?p)))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (playlists-known) (known-id ?p) (not (task-completed)))
    :effect (and (playlist-songs-known ?p) (known-id ?s) (in-playlist ?s ?p)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?ans - answer)
    :precondition (and (known-id ?s) (not (task-completed)))
    :effect (and (song-artists-known ?s) (found-top-artists ?ans)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - answer)
    :precondition (and (found-top-artists ?ans) (not (task-completed)))
    :effect (task-completed)))
