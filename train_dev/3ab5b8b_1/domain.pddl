(define (domain appworld-3ab5b8b-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song - object)
  (:constants spotify - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (playlist-song ?s - song)
    (liked-song ?s - song)
    (playlist-library-known)
    (liked-songs-known)
    (downloaded ?s - song)
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
    :precondition (and (not (task-completed))
                       (profile-known)
                       (passwords-known)
                       (supervisor-username ?u)
                       (password-for spotify ?pw)
                       (not (has-token spotify ?t)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t))
    :effect (and (playlist-library-known)))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t))
    :effect (and (liked-songs-known)))

  ; API: spotify.download_song
  (:action spotify-download-song
    :parameters (?s - song ?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (playlist-library-known)
                       (liked-songs-known)
                       (playlist-song ?s)
                       (liked-song ?s)
                       (not (downloaded ?s)))
    :effect (and (downloaded ?s)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (task-completed))))
