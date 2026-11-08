(define (domain appworld-09b0ee6-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token playlist song artist-list - object
  )
  (:constants spotify supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-library ?pl - playlist)
    (contains ?pl - playlist ?s - song)
    (tallies ?ans - artist-list ?s - song)
    (found-playlists)
    (found-playlist-songs ?pl - playlist)
    (known-id ?s - song)
    (known-artists ?s - song)
    (found ?ans - artist-list)
    (task-completed)
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
      (passwords-known)
      (password-for spotify ?pw)
      (not (has-token spotify ?t))
      (not (task-completed))
    )
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and
      (has-token spotify ?t)
      (not (task-completed))
    )
    :effect (and (found-playlists))
  )

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token ?s - song)
    :precondition (and
      (has-token spotify ?t)
      (found-playlists)
      (in-library ?pl)
      (contains ?pl ?s)
      (not (task-completed))
    )
    :effect (and (found-playlist-songs ?pl) (known-id ?s))
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?ans - artist-list)
    :precondition (and
      (known-id ?s)
      (tallies ?ans ?s)
      (not (task-completed))
    )
    :effect (and (known-artists ?s) (found ?ans))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - artist-list)
    :precondition (and
      (found ?ans)
      (not (task-completed))
    )
    :effect (and (task-completed))
  )
)
