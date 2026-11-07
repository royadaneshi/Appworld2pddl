(define (domain appworld-50e1ac9-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token answer library item - object
    song album playlist - item
  )
  (:constants
    spotify supervisor - app
    song-library album-library playlist-library - library
  )
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (supervisor-username ?u - username)
    (has-token ?a - app ?t - token)
    (known-id ?i - item)
    (in-song-library ?s - song)
    (in-album-library ?al - album)
    (in-playlist-library ?pl - playlist)
    (album-contains ?al - album ?s - song)
    (playlist-contains ?pl - playlist ?s - song)
    (song-from ?s - song ?l - library)
    (song-details-known ?s - song)
    (library-scanned ?l - library)
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
    :precondition (and
      (profile-known)
      (supervisor-username ?u)
      (passwords-known)
      (password-for spotify ?pw)
      (not (has-token spotify ?t))
      (not (task-completed))
    )
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token ?s - song)
    :precondition (and
      (has-token spotify ?t)
      (in-song-library ?s)
      (not (task-completed))
    )
    :effect (and (known-id ?s))
  )

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token ?al - album)
    :precondition (and
      (has-token spotify ?t)
      (in-album-library ?al)
      (not (task-completed))
    )
    :effect (and (known-id ?al))
  )

  ; API: spotify.show_album
  (:action spotify-show-album
    :parameters (?al - album ?s - song)
    :precondition (and
      (known-id ?al)
      (album-contains ?al ?s)
      (not (task-completed))
    )
    :effect (and (known-id ?s))
  )

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?pl - playlist)
    :precondition (and
      (has-token spotify ?t)
      (in-playlist-library ?pl)
      (not (task-completed))
    )
    :effect (and (known-id ?pl))
  )

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token ?s - song)
    :precondition (and
      (has-token spotify ?t)
      (known-id ?pl)
      (playlist-contains ?pl ?s)
      (not (task-completed))
    )
    :effect (and (known-id ?s))
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?l - library)
    :precondition (and
      (known-id ?s)
      (song-from ?s ?l)
      (not (task-completed))
    )
    :effect (and (song-details-known ?s) (library-scanned ?l))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - answer)
    :precondition (and
      (library-scanned song-library)
      (library-scanned album-library)
      (library-scanned playlist-library)
      (not (task-completed))
    )
    :effect (and (task-completed))
  )
)
