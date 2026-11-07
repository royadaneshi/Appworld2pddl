(define (domain appworld-229360a-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token song album - object
  )
  (:constants
    spotify - app
    song-liked-downloaded song-liked-not-downloaded song-downloaded-not-liked song-not-liked-not-downloaded - song
    album-liked-all-downloaded album-liked-partly-downloaded album-not-liked - album
  )
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (supervisor-username ?u - username)
    (has-token ?a - app ?t - token)
    (in-song-library ?s - song)
    (in-album-library ?al - album)
    (song-liked-and-downloaded ?s - song)
    (album-liked-and-downloaded ?al - album)
    (song-library-known)
    (album-library-known)
    (downloaded-songs-known)
    (liked-songs-known)
    (liked-albums-known)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known))
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (supervisor-username ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (song-library-known))
  )

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (album-library-known))
  )

  ; API: spotify.show_downloaded_songs
  (:action spotify-show-downloaded-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (downloaded-songs-known))
  )

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (liked-songs-known))
  )

  ; API: spotify.show_liked_albums
  (:action spotify-show-liked-albums
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (liked-albums-known))
  )

  ; API: spotify.remove_song_from_library
  (:action spotify-remove-song-from-library
    :parameters (?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (song-library-known) (liked-songs-known) (downloaded-songs-known) (in-song-library ?s) (not (song-liked-and-downloaded ?s)) (not (task-completed)))
    :effect (and (not (in-song-library ?s)))
  )

  ; API: spotify.remove_album_from_library
  (:action spotify-remove-album-from-library
    :parameters (?al - album ?t - token)
    :precondition (and (has-token spotify ?t) (album-library-known) (liked-albums-known) (downloaded-songs-known) (in-album-library ?al) (not (album-liked-and-downloaded ?al)) (not (task-completed)))
    :effect (and (not (in-album-library ?al)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (in-song-library song-liked-downloaded)
      (not (in-song-library song-liked-not-downloaded))
      (not (in-song-library song-downloaded-not-liked))
      (not (in-song-library song-not-liked-not-downloaded))
      (in-album-library album-liked-all-downloaded)
      (not (in-album-library album-liked-partly-downloaded))
      (not (in-album-library album-not-liked))
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
