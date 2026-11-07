(define (domain appworld-27e1026-3)
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
    (oldest-released ?s - song)
    (found-title ?s - song ?ti - title)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known)))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (username-for spotify ?u) (password-for spotify ?pw)
                       (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (song-library-scanned)))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (album-library-scanned)))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (playlist-library-scanned)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?ti - title)
    :precondition (and (song-library-scanned) (album-library-scanned) (playlist-library-scanned)
                       (oldest-released ?s) (not (task-completed)))
    :effect (and (found-title ?s ?ti)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ti - title ?s - song)
    :precondition (and (found-title ?s ?ti) (oldest-released ?s) (not (task-completed)))
    :effect (and (task-completed))))
