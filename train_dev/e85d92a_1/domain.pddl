(define (domain appworld-e85d92a-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person artist song query sort-key - object
  )
  (:constants
    spotify - app
  )
  (:predicates
    (passwords-known)
    (profile-known)
    (query-for ?q - query ?a - artist)
    (known-id ?a - artist)
    (sort-most-played ?sk - sort-key)
    (song-by ?s - song ?a - artist)
    (found-most-played ?s - song ?a - artist)
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

  ; API: spotify.search_artists
  (:action spotify-search-artists
    :parameters (?q - query ?a - artist)
    :precondition (and (query-for ?q ?a) (not (task-completed)))
    :effect (and (known-id ?a))
  )

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?a - artist ?sk - sort-key ?s - song)
    :precondition (and (known-id ?a) (sort-most-played ?sk) (song-by ?s ?a) (not (task-completed)))
    :effect (and (found-most-played ?s ?a))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?s - song ?a - artist)
    :precondition (and (found-most-played ?s ?a) (not (task-completed)))
    :effect (and (task-completed))
  )
)
