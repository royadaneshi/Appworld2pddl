(define (domain appworld-27e1026-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song title - object)
  (:constants spotify - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (song-library-scanned)
    (album-library-scanned)
    (playlist-library-scanned)
    (newest-candidate ?s - song)
    (title-of ?s - song ?ti - title)
    (found-newest-title ?s - song ?ti - title)
    (task-completed))

  (:action supervisor-show-profile
    ; API: supervisor.show_profile
    :parameters ()
    :precondition (and (not (task-completed)) (not (profile-known)))
    :effect (profile-known))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (and (not (task-completed)) (not (passwords-known)))
    :effect (passwords-known))

  (:action spotify-login
    ; API: spotify.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  (:action spotify-show-song-library
    ; API: spotify.show_song_library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (song-library-scanned))

  (:action spotify-show-album-library
    ; API: spotify.show_album_library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (album-library-scanned))

  (:action spotify-show-playlist-library
    ; API: spotify.show_playlist_library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (playlist-library-scanned))

  (:action spotify-show-song
    ; API: spotify.show_song
    :parameters (?s - song ?ti - title)
    :precondition (and (not (task-completed)) (song-library-scanned) (album-library-scanned) (playlist-library-scanned) (newest-candidate ?s) (title-of ?s ?ti))
    :effect (found-newest-title ?s ?ti))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?ti - title ?s - song)
    :precondition (and (not (task-completed)) (newest-candidate ?s) (found-newest-title ?s ?ti))
    :effect (task-completed)))
