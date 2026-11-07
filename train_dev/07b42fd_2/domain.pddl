(define (domain appworld-07b42fd-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query genre follower-count artist - object)
  (:constants
    spotify - app
    artist-1 artist-2 artist-3 - artist)
  (:predicates
    (profile-known)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (target-genre ?g - genre)
    (target-min-followers ?f - follower-count)
    (query-for-genre ?q - query ?g - genre)
    (matches-criteria ?x - artist)
    (matching-artists-found)
    (following ?x - artist)
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
    :precondition (and (profile-known) (passwords-known)
                       (username-for spotify ?u) (password-for spotify ?pw)
                       (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.search_artists
  (:action spotify-search-artists
    :parameters (?q - query ?g - genre ?f - follower-count)
    :precondition (and (query-for-genre ?q ?g) (target-genre ?g) (target-min-followers ?f)
                       (not (task-completed)))
    :effect (and (matching-artists-found)))

  ; API: spotify.follow_artist
  (:action spotify-follow-artist
    :parameters (?x - artist ?t - token)
    :precondition (and (has-token spotify ?t) (matching-artists-found) (matches-criteria ?x)
                       (not (following ?x)) (not (task-completed)))
    :effect (and (following ?x)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (following artist-1) (following artist-2) (following artist-3)
                       (not (task-completed)))
    :effect (and (task-completed))))
