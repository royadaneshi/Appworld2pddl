(define (domain appworld-07b42fd-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query genre follower-count artist - object
  )
  (:constants
    spotify supervisor - app
    artist-grace-harrison - artist
  )
  (:predicates
    (profile-known)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (artists-searched ?g - genre ?c - follower-count)
    (artist-matches ?ar - artist ?g - genre ?c - follower-count)
    (following ?ar - artist)
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
    :precondition (and (profile-known) (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t)
  )
  ; API: spotify.search_artists
  (:action spotify-search-artists
    :parameters (?q - query ?g - genre ?c - follower-count)
    :precondition (not (task-completed))
    :effect (artists-searched ?g ?c)
  )
  ; API: spotify.follow_artist
  (:action spotify-follow-artist
    :parameters (?ar - artist ?t - token ?g - genre ?c - follower-count)
    :precondition (and (has-token spotify ?t) (artists-searched ?g ?c) (artist-matches ?ar ?g ?c) (not (following ?ar)) (not (task-completed)))
    :effect (following ?ar)
  )
  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (following artist-grace-harrison) (not (task-completed)))
    :effect (task-completed)
  )
)
