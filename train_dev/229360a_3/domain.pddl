(define (domain appworld-229360a-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song album - object
  )
  (:constants
    spotify - app
    liked-song-in-library downloaded-song-in-library unliked-undownloaded-song - song
    liked-album-in-library fully-downloaded-album-in-library unliked-undownloaded-album - album
  )
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (song-library-known)
    (album-library-known)
    (downloaded-songs-known)
    (liked-songs-known)
    (liked-albums-known)
    (in-song-library ?s - song)
    (in-album-library ?al - album)
    (liked-song ?s - song)
    (downloaded-song ?s - song)
    (liked-album ?al - album)
    (album-downloaded ?al - album)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (profile-known)
      (passwords-known)
      (username-for spotify ?u)
      (password-for spotify ?pw)
      (not (has-token spotify ?t))
      (not (task-completed))
    )
    :effect (has-token spotify ?t)
  )

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (song-library-known)
  )

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (album-library-known)
  )

  ; API: spotify.show_downloaded_songs
  (:action spotify-show-downloaded-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (downloaded-songs-known)
  )

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-songs-known)
  )

  ; API: spotify.show_liked_albums
  (:action spotify-show-liked-albums
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-albums-known)
  )

  ; API: spotify.remove_song_from_library
  (:action spotify-remove-song-from-library
    :parameters (?s - song ?t - token)
    :precondition (and
      (has-token spotify ?t)
      (song-library-known)
      (liked-songs-known)
      (downloaded-songs-known)
      (in-song-library ?s)
      (not (liked-song ?s))
      (not (downloaded-song ?s))
      (not (task-completed))
    )
    :effect (not (in-song-library ?s))
  )

  ; API: spotify.remove_album_from_library
  (:action spotify-remove-album-from-library
    :parameters (?al - album ?t - token)
    :precondition (and
      (has-token spotify ?t)
      (album-library-known)
      (liked-albums-known)
      (downloaded-songs-known)
      (in-album-library ?al)
      (not (liked-album ?al))
      (not (album-downloaded ?al))
      (not (task-completed))
    )
    :effect (not (in-album-library ?al))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (not (in-song-library unliked-undownloaded-song))
      (in-song-library liked-song-in-library)
      (in-song-library downloaded-song-in-library)
      (not (in-album-library unliked-undownloaded-album))
      (in-album-library liked-album-in-library)
      (in-album-library fully-downloaded-album-in-library)
      (not (task-completed))
    )
    :effect (task-completed)
  )
)
