(define (domain appworld-229360a-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app username password token song album - object)
  (:constants spotify - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-library-songs)
    (known-library-albums)
    (known-downloaded-songs)
    (known-liked-songs)
    (known-liked-albums)
    (song-in-library ?s - song)
    (song-liked ?s - song)
    (song-downloaded ?s - song)
    (song-removed-from-library ?s - song)
    (album-in-library ?al - album)
    (album-liked ?al - album)
    (album-downloaded ?al - album)
    (album-removed-from-library ?al - album)
    (task-completed)
  )

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
    :precondition (and (not (task-completed)) (profile-known) (passwords-known)
                       (username-for spotify ?u) (password-for spotify ?pw)
                       (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (known-library-songs))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (known-library-albums))

  ; API: spotify.show_downloaded_songs
  (:action spotify-show-downloaded-songs
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (known-downloaded-songs))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (known-liked-songs))

  ; API: spotify.show_liked_albums
  (:action spotify-show-liked-albums
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (known-liked-albums))

  ; API: spotify.remove_song_from_library
  (:action spotify-remove-song-from-library
    :parameters (?s - song ?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t)
                       (known-library-songs) (known-liked-songs) (known-downloaded-songs)
                       (song-in-library ?s) (not (song-liked ?s)) (not (song-downloaded ?s)))
    :effect (and (not (song-in-library ?s)) (song-removed-from-library ?s)))

  ; API: spotify.remove_album_from_library
  (:action spotify-remove-album-from-library
    :parameters (?al - album ?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t)
                       (known-library-albums) (known-liked-albums) (known-downloaded-songs)
                       (album-in-library ?al) (not (album-liked ?al)) (not (album-downloaded ?al)))
    :effect (and (not (album-in-library ?al)) (album-removed-from-library ?al)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (task-completed))
)
