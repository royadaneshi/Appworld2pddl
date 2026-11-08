(define (domain appworld-09b0ee6-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token playlist song answer - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-library ?p - playlist)
    (song-in-playlist ?s - song ?p - playlist)
    (playlists-listed)
    (known-songs ?p - playlist)
    (known-artists ?s - song)
    (found-top-artists ?ans - answer)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
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
    :parameters (?p - playlist ?t - token)
    :precondition (and (has-token spotify ?t) (playlists-listed) (in-library ?p) (not (task-completed)))
    :effect (known-songs ?p))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?p - playlist ?ans - answer)
    :precondition (and (known-songs ?p) (song-in-playlist ?s ?p) (not (task-completed)))
    :effect (and (known-artists ?s) (found-top-artists ?ans)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - answer)
    :precondition (and (found-top-artists ?ans) (not (task-completed)))
    :effect (task-completed))
)
