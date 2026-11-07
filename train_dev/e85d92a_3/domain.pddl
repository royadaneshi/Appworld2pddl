(define (domain appworld-e85d92a-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person artist song query sort-key - object)
  (:constants spotify - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (artist-query ?q - query ?ar - artist)
    (target-artist ?ar - artist)
    (sort-most-played ?sb - sort-key)
    (known-id ?ar - artist)
    (found-most-played ?ar - artist ?s - song)
    (answer-found ?s - song)
    (task-completed))

  (:action supervisor-show-profile
    ; API: supervisor.show_profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action spotify-search-artists
    ; API: spotify.search_artists
    :parameters (?q - query ?ar - artist)
    :precondition (and (not (task-completed)) (profile-known) (passwords-known) (artist-query ?q ?ar))
    :effect (known-id ?ar))

  (:action spotify-search-songs
    ; API: spotify.search_songs
    :parameters (?ar - artist ?sb - sort-key ?s - song)
    :precondition (and (not (task-completed)) (known-id ?ar) (target-artist ?ar) (sort-most-played ?sb))
    :effect (and (found-most-played ?ar ?s) (answer-found ?s)))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?s - song)
    :precondition (and (not (task-completed)) (answer-found ?s))
    :effect (task-completed)))
