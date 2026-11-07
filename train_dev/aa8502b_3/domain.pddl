(define (domain appworld-aa8502b-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token artist song - object
  )
  (:constants
    spotify - app
    artist-1 artist-2 artist-3 artist-4 - artist
  )
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (following-known)
    (liked-songs-known)
    (liked ?s - song)
    (sings ?ar - artist ?s - song)
    (following ?ar - artist)
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
      (passwords-known)
      (username-for spotify ?u)
      (password-for spotify ?pw)
      (not (has-token spotify ?t))
      (not (task-completed))
    )
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_following_artists
  (:action spotify-show-following-artists
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (following-known))
  )

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (liked-songs-known))
  )

  ; API: spotify.follow_artist
  (:action spotify-follow-artist
    :parameters (?ar - artist ?t - token ?s - song)
    :precondition (and
      (has-token spotify ?t)
      (following-known)
      (liked-songs-known)
      (liked ?s)
      (sings ?ar ?s)
      (not (following ?ar))
      (not (task-completed))
    )
    :effect (and (following ?ar))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (following artist-1)
      (following artist-2)
      (following artist-3)
      (not (task-completed))
    )
    :effect (and (task-completed))
  )
)
