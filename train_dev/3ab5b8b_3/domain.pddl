(define (domain appworld-3ab5b8b-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token song - object)
  (:constants
    spotify - app
    song-31 song-32 song-48 song-49 song-50 song-51 song-52 song-57 - song)
  (:predicates
    (profile-known)
    (passwords-known)
    (supervisor-email ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-album-library ?s - song)
    (liked-song ?s - song)
    (album-library-scanned)
    (liked-songs-scanned)
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
    :precondition (and (profile-known) (supervisor-email ?u)
                       (passwords-known) (password-for spotify ?pw)
                       (not (has-token spotify ?t))
                       (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (album-library-scanned)))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (liked-songs-scanned)))

  ; API: spotify.download_song
  (:action spotify-download-song
    :parameters (?s - song ?t - token)
    :precondition (and (has-token spotify ?t)
                       (album-library-scanned) (liked-songs-scanned)
                       (in-album-library ?s) (liked-song ?s)
                       (not (downloaded ?s))
                       (not (task-completed)))
    :effect (and (downloaded ?s)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (downloaded song-31)
      (downloaded song-32)
      (downloaded song-48)
      (downloaded song-49)
      (downloaded song-50)
      (downloaded song-51)
      (downloaded song-52)
      (downloaded song-57)
      (not (task-completed)))
    :effect (and (task-completed))))
