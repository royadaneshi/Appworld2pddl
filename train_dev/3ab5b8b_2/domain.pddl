(define (domain appworld-3ab5b8b-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (in-library ?s - song)
    (liked ?s - song)
    (library-shown)
    (liked-shown)
    (downloaded ?s - song)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (username-for spotify ?u)
                       (passwords-known) (password-for spotify ?pw)
                       (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (library-shown))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-shown))

  ; API: spotify.download_song
  (:action spotify-download-song
    :parameters (?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (library-shown) (liked-shown)
                       (in-library ?s) (liked ?s) (not (downloaded ?s))
                       (not (task-completed)))
    :effect (downloaded ?s))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?s1 - song ?s2 - song)
    :precondition (and (downloaded ?s1) (downloaded ?s2) (not (= ?s1 ?s2))
                       (not (task-completed)))
    :effect (task-completed))
)
