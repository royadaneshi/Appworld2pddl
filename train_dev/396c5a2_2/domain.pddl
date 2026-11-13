(define (domain appworld-396c5a2-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query artist song playcount - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (email-of ?p - person ?u - username)
    (has-token ?a - app ?t - token)
    (artist-query ?q - query ?ar - artist)
    (known-id ?ar - artist)
    (play-count-threshold ?pc - playcount)
    (matching-songs-found ?ar - artist ?pc - playcount)
    (song-by ?s - song ?ar - artist)
    (played-over ?s - song ?pc - playcount)
    (in-queue ?s - song)
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
    :precondition (and (profile-known) (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.search_artists
  (:action spotify-search-artists
    :parameters (?q - query ?ar - artist)
    :precondition (and (artist-query ?q ?ar) (not (task-completed)))
    :effect (and (known-id ?ar))
  )

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?ar - artist ?pc - playcount)
    :precondition (and (known-id ?ar) (artist-query ?q ?ar) (play-count-threshold ?pc) (not (task-completed)))
    :effect (and (matching-songs-found ?ar ?pc))
  )

  ; API: spotify.add_to_queue
  (:action spotify-add-to-queue
    :parameters (?t - token ?s - song ?ar - artist ?pc - playcount)
    :precondition (and (has-token spotify ?t) (matching-songs-found ?ar ?pc) (song-by ?s ?ar) (played-over ?s ?pc) (not (in-queue ?s)) (not (task-completed)))
    :effect (and (in-queue ?s))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?s1 - song)
    :precondition (and
      (in-queue ?s1)
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
