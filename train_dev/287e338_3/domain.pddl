(define (domain appworld-287e338-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token song artist artist-name - object)
  (:constants spotify - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (recommendations-known)
    (recommended ?s - song)
    (known-id ?s - song)
    (artist-of ?s - song ?ar - artist)
    (known-artist-of ?s - song ?ar - artist)
    (found-most-recommended ?ar - artist)
    (artist-named ?ar - artist ?n - artist-name)
    (answer-known ?n - artist-name)
    (answered ?n - artist-name)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t)
  )

  ; API: spotify.show_recommendations
  (:action spotify-show-recommendations
    :parameters (?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (recommended ?s) (not (task-completed)))
    :effect (and (recommendations-known) (known-id ?s))
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?ar - artist)
    :precondition (and (recommendations-known) (known-id ?s) (recommended ?s) (artist-of ?s ?ar) (not (task-completed)))
    :effect (and (known-artist-of ?s ?ar) (found-most-recommended ?ar))
  )

  ; API: spotify.show_artist
  (:action spotify-show-artist
    :parameters (?ar - artist ?n - artist-name)
    :precondition (and (found-most-recommended ?ar) (artist-named ?ar ?n) (not (task-completed)))
    :effect (answer-known ?n)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - artist-name)
    :precondition (and (answer-known ?n) (not (task-completed)))
    :effect (and (task-completed) (answered ?n))
  )
)
