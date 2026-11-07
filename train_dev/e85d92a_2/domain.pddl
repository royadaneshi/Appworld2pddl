(define (domain appworld-e85d92a-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person artist song query sort-key - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (task-completed)
    (query-for ?a - artist ?q - query)
    (least-played-song-of ?a - artist ?s - song)
    (sort-ascending-play-count ?k - sort-key)
    (known-id ?a - artist)
    (found-title ?s - song))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known)))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: spotify.search_artists
  (:action spotify-search-artists
    :parameters (?q - query ?a - artist)
    :precondition (and (not (task-completed)) (query-for ?a ?q))
    :effect (and (known-id ?a)))

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?a - artist ?k - sort-key ?s - song)
    :precondition (and (not (task-completed)) (known-id ?a) (sort-ascending-play-count ?k) (least-played-song-of ?a ?s))
    :effect (and (found-title ?s)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?s - song)
    :precondition (and (not (task-completed)) (found-title ?s))
    :effect (and (task-completed)))
)
