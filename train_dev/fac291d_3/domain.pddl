(define (domain appworld-fac291d-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token count - object)
  (:constants supervisor spotify - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (song-library-collected ?c - count)
    (album-library-collected ?c - count)
    (playlist-library-collected ?c - count)
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
    :precondition (and (profile-known) (passwords-known) (supervisor-username ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token ?c - count)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (song-library-collected ?c)))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token ?c - count)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (album-library-collected ?c)))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?c - count)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (playlist-library-collected ?c)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - count)
    :precondition (and (song-library-collected ?c) (album-library-collected ?c) (playlist-library-collected ?c) (not (task-completed)))
    :effect (and (task-completed)))
)
