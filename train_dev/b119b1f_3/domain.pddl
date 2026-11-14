(define (domain appworld-b119b1f-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query artist song position - object)
  (:constants spotify - app)
  (:predicates
    (supervisor ?p - person)
    (profile-known)
    (passwords-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (artist-query ?ar - artist ?q - query)
    (known-id ?ar - artist)
    (target-artist ?ar - artist)
    (prev-position ?p - position ?q - position)
    (song-at ?p - position ?s - song)
    (by-artist ?s - song ?ar - artist)
    (cursor-at ?p - position)
    (may-go-previous)
    (checked ?s - song ?ar - artist)
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
    :precondition (and (profile-known) (passwords-known) (supervisor-username ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.search_artists
  (:action spotify-search-artists
    :parameters (?q - query ?ar - artist)
    :precondition (and (artist-query ?ar ?q) (not (task-completed)))
    :effect (and (known-id ?ar)))

  ; API: spotify.previous_song
  (:action spotify-previous-song
    :parameters (?t - token ?p - position ?q - position)
    :precondition (and (has-token spotify ?t) (cursor-at ?p) (prev-position ?p ?q) (may-go-previous) (not (task-completed)))
    :effect (and (not (cursor-at ?p)) (cursor-at ?q) (not (may-go-previous))))

  ; API: spotify.show_current_song
  (:action spotify-show-current-song
    :parameters (?t - token ?p - position ?s - song ?ar - artist)
    :precondition (and (has-token spotify ?t) (cursor-at ?p) (song-at ?p ?s) (known-id ?ar) (not (task-completed)))
    :effect (and (checked ?s ?ar) (may-go-previous)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (task-completed)))
)
