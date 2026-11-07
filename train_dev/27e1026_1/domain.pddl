(define (domain appworld-27e1026-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app username password token song song-title - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (song-library-listed)
    (album-library-listed)
    (playlist-library-listed)
    (is-oldest ?s - song)
    (found-title ?s - song ?title - song-title)
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
    :precondition (and (not (task-completed)) (profile-known) (passwords-known) (supervisor-username ?u) (password-for spotify ?pw) (not (has-token spotify ?t)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (and (song-library-listed)))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (and (album-library-listed)))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (and (playlist-library-listed)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?title - song-title)
    :precondition (and (not (task-completed)) (song-library-listed) (album-library-listed) (playlist-library-listed))
    :effect (and (found-title ?s ?title)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?title - song-title ?s - song)
    :precondition (and (not (task-completed)) (song-library-listed) (album-library-listed) (playlist-library-listed) (is-oldest ?s) (found-title ?s ?title))
    :effect (and (task-completed)))
)
