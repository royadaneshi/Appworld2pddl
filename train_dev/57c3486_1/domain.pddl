(define (domain appworld-57c3486-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query artist song - object
  )
  (:constants
    spotify - app
    song-1-1 song-1-2 song-2-1 song-2-2 - song
  )
  (:predicates
    (profile-known)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (followed ?ar - artist)
    (following-artists-known)
    (artist-name ?ar - artist ?q - query)
    (artist-details-known ?ar - artist)
    (song-by ?s - song ?ar - artist)
    (songs-searched ?ar - artist)
    (liked ?s - song)
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
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (username-for spotify ?u)
      (password-for spotify ?pw)
      (not (has-token spotify ?t))
    )
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_following_artists
  (:action spotify-show-following-artists
    :parameters (?t - token)
    :precondition (and
      (not (task-completed))
      (has-token spotify ?t)
    )
    :effect (and (following-artists-known))
  )

  ; API: spotify.show_artist
  (:action spotify-show-artist
    :parameters (?ar - artist)
    :precondition (and
      (not (task-completed))
      (following-artists-known)
      (followed ?ar)
    )
    :effect (and (artist-details-known ?ar))
  )

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?ar - artist)
    :precondition (and
      (not (task-completed))
      (artist-details-known ?ar)
      (artist-name ?ar ?q)
    )
    :effect (and (songs-searched ?ar))
  )

  ; API: spotify.like_song
  (:action spotify-like-song
    :parameters (?s - song ?t - token ?ar - artist)
    :precondition (and
      (not (task-completed))
      (has-token spotify ?t)
      (songs-searched ?ar)
      (song-by ?s ?ar)
      (not (liked ?s))
    )
    :effect (and (liked ?s))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (not (task-completed))
      (liked song-1-1)
      (liked song-1-2)
      (liked song-2-1)
      (liked song-2-2)
    )
    :effect (and (task-completed))
  )
)
