(define (domain appworld-287e338-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token artist-name entity - object
    song artist - entity)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (supervisor-username ?u - username)
    (has-token ?a - app ?t - token)
    (recommendations-fetched)
    (recommended ?s - song)
    (song-by ?s - song ?ar - artist)
    (most-recommended ?ar - artist)
    (name-of ?ar - artist ?n - artist-name)
    (known-id ?x - entity)
    (found-recommended-artist ?ar - artist)
    (found-artist-name ?ar - artist ?n - artist-name)
    (task-completed))

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

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed))
                       (profile-known)
                       (passwords-known)
                       (supervisor-username ?u)
                       (password-for spotify ?pw)
                       (not (has-token spotify ?t)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_recommendations
  (:action spotify-show-recommendations
    :parameters (?t - token ?s - song)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (recommended ?s))
    :effect (and (recommendations-fetched)
                 (known-id ?s)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?ar - artist)
    :precondition (and (not (task-completed))
                       (known-id ?s)
                       (recommended ?s)
                       (song-by ?s ?ar))
    :effect (and (known-id ?ar)
                 (found-recommended-artist ?ar)))

  ; API: spotify.show_artist
  (:action spotify-show-artist
    :parameters (?ar - artist ?n - artist-name)
    :precondition (and (not (task-completed))
                       (known-id ?ar)
                       (name-of ?ar ?n))
    :effect (and (found-artist-name ?ar ?n)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - artist-name ?ar - artist)
    :precondition (and (not (task-completed))
                       (recommendations-fetched)
                       (found-recommended-artist ?ar)
                       (most-recommended ?ar)
                       (found-artist-name ?ar ?n))
    :effect (and (task-completed)))
)
