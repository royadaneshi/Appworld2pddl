(define (domain appworld-07b42fd-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query genre follower-count artist - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (target-genre ?g - genre)
    (target-min-followers ?m - follower-count)
    (query-for-genre ?q - query ?g - genre)
    (matching-artist ?art - artist)
    (matching-artists-found)
    (followed ?art - artist)
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
    :parameters (?q - query ?g - genre ?m - follower-count)
    :precondition (and (query-for-genre ?q ?g) (target-genre ?g) (target-min-followers ?m)
                       (not (task-completed)))
    :effect (and (matching-artists-found)))

  ; API: spotify.follow_artist
  (:action spotify-follow-artist
    :parameters (?art - artist ?t - token)
    :precondition (and (has-token spotify ?t) (matching-artists-found) (matching-artist ?art)
                       (not (followed ?art)) (not (task-completed)))
    :effect (and (followed ?art)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?a1 - artist)
    :precondition (and (matching-artist ?a1)
                       (followed ?a1) (not (task-completed)))
    :effect (and (task-completed)))
)
