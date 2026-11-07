(define (domain appworld-287e338-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token song artist artist-name - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (account-username ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (recommended ?s - song)
    (known-song-id ?s - song)
    (artist-of ?s - song ?ar - artist)
    (known-artist-id ?ar - artist)
    (least-recommended ?ar - artist)
    (name-of ?ar - artist ?n - artist-name)
    (found-name ?ar - artist ?n - artist-name)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (account-username spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_recommendations
  (:action spotify-show-recommendations
    :parameters (?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (recommended ?s) (not (task-completed)))
    :effect (known-song-id ?s))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?ar - artist)
    :precondition (and (known-song-id ?s) (artist-of ?s ?ar) (not (task-completed)))
    :effect (known-artist-id ?ar))

  ; API: spotify.show_artist
  (:action spotify-show-artist
    :parameters (?ar - artist ?n - artist-name)
    :precondition (and (known-artist-id ?ar) (name-of ?ar ?n) (not (task-completed)))
    :effect (found-name ?ar ?n))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - artist-name ?ar - artist)
    :precondition (and (least-recommended ?ar) (found-name ?ar ?n) (not (task-completed)))
    :effect (task-completed)))
