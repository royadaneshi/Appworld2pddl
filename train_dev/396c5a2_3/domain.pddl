(define (domain appworld-396c5a2-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query artist song play-count - object)
  (:constants spotify - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (artist-query ?q - query ?ar - artist)
    (known-id ?ar - artist)
    (songs-searched ?ar - artist ?pc - play-count)
    (qualifies ?s - song ?ar - artist ?pc - play-count)
    (queued ?s - song)
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
    :precondition (and (profile-known) (passwords-known) (supervisor-username ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.search_artists
  (:action spotify-search-artists
    :parameters (?q - query ?ar - artist)
    :precondition (and (artist-query ?q ?ar) (not (task-completed)))
    :effect (known-id ?ar))

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?ar - artist ?pc - play-count)
    :precondition (and (artist-query ?q ?ar) (known-id ?ar) (not (task-completed)))
    :effect (songs-searched ?ar ?pc))

  ; API: spotify.add_to_queue
  (:action spotify-add-to-queue
    :parameters (?t - token ?s - song ?ar - artist ?pc - play-count)
    :precondition (and (has-token spotify ?t) (songs-searched ?ar ?pc) (qualifies ?s ?ar ?pc) (not (queued ?s)) (not (task-completed)))
    :effect (queued ?s))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?s - song)
    :precondition (and (queued ?s) (not (task-completed)))
    :effect (task-completed))
)
