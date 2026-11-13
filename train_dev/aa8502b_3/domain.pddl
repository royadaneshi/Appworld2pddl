(define (domain appworld-aa8502b-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token artist song - object
  )
  (:constants
    spotify - app
    artist-olivia-roberts artist-phoenix-rivers artist-jasper-skye artist-marigold-muse artist-ava-morgan artist-aria-sterling artist-zoe-mitchell artist-eliana-harper artist-mia-sullivan artist-grace-harrison artist-apollo-serenade artist-dylan-stone artist-astrid-nightshade - artist
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
      (following artist-olivia-roberts)
      (following artist-phoenix-rivers)
      (following artist-jasper-skye)
      (following artist-marigold-muse)
      (following artist-ava-morgan)
      (following artist-aria-sterling)
      (following artist-zoe-mitchell)
      (following artist-eliana-harper)
      (following artist-mia-sullivan)
      (following artist-grace-harrison)
      (following artist-apollo-serenade)
      (following artist-dylan-stone)
      (following artist-astrid-nightshade)
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
