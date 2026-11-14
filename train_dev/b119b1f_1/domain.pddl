(define (domain appworld-b119b1f-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query queue-pos song artist - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (artist-query ?ar - artist ?qy - query)
    (known-id ?ar - artist)
    (cursor-at ?q - queue-pos)
    (prev-of ?q - queue-pos ?qp - queue-pos)
    (song-at ?q - queue-pos ?s - song)
    (by-artist ?s - song ?ar - artist)
    (inspected ?q - queue-pos)
    (seen-song-by ?q - queue-pos ?ar - artist)
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
    :parameters (?qy - query ?ar - artist)
    :precondition (and (artist-query ?ar ?qy) (not (task-completed)))
    :effect (and (known-id ?ar)))

  ; API: spotify.previous_song
  (:action spotify-previous-song
    :parameters (?t - token ?q - queue-pos ?qp - queue-pos)
    :precondition (and (has-token spotify ?t) (cursor-at ?q) (prev-of ?q ?qp)
                       (inspected ?q) (not (task-completed)))
    :effect (and (not (cursor-at ?q)) (cursor-at ?qp)))

  ; API: spotify.show_current_song
  (:action spotify-show-current-song
    :parameters (?t - token ?q - queue-pos ?s - song ?ar - artist)
    :precondition (and (has-token spotify ?t) (cursor-at ?q) (song-at ?q ?s)
                       (by-artist ?s ?ar) (not (task-completed)))
    :effect (and (inspected ?q) (seen-song-by ?q ?ar)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (task-completed)))
)
