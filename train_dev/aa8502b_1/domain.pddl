(define (domain appworld-aa8502b-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song artist - object)
  (:constants
    spotify - app
    artist-a artist-b artist-c - artist)
  (:predicates
    (profile-known)
    (passwords-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (following-known)
    (liked-songs-known)
    (liked ?s - song)
    (sung-by ?s - song ?ar - artist)
    (following ?ar - artist)
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
    :precondition (and (profile-known)
                       (passwords-known)
                       (supervisor-username ?u)
                       (password-for spotify ?pw)
                       (not (has-token spotify ?t))
                       (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_following_artists
  (:action spotify-show-following-artists
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t)
                       (not (task-completed)))
    :effect (following-known))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t)
                       (not (task-completed)))
    :effect (liked-songs-known))

  ; API: spotify.follow_artist
  (:action spotify-follow-artist
    :parameters (?artist-id - artist ?t - token ?s - song)
    :precondition (and (has-token spotify ?t)
                       (following-known)
                       (liked-songs-known)
                       (liked ?s)
                       (sung-by ?s ?artist-id)
                       (not (following ?artist-id))
                       (not (task-completed)))
    :effect (following ?artist-id))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (following artist-a)
                       (following artist-b)
                       (following artist-c)
                       (not (task-completed)))
    :effect (task-completed))
)
