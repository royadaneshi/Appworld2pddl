(define (domain appworld-b119b1f-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query artist song - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (supervisor ?p - person)
    (supervisor-username ?u - username)
    (artist-query ?q - query ?a - artist)
    (target-artist ?a - artist)
    (known-id ?a - artist)
    (song-by ?s - song ?a - artist)
    (queue-next ?s1 - song ?s2 - song)
    (cursor-at ?s - song)
    (current-song-inspected)
    (confirmed-song-by ?s - song ?a - artist)
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
    :parameters (?q - query ?a - artist)
    :precondition (and (artist-query ?q ?a) (not (task-completed)))
    :effect (and (known-id ?a)))

  ; API: spotify.next_song
  (:action spotify-next-song
    :parameters (?t - token ?from - song ?to - song)
    :precondition (and (has-token spotify ?t) (cursor-at ?from) (queue-next ?from ?to) (current-song-inspected) (not (task-completed)))
    :effect (and (not (cursor-at ?from)) (cursor-at ?to) (not (current-song-inspected))))

  ; API: spotify.show_current_song
  (:action spotify-show-current-song
    :parameters (?t - token ?s - song ?a - artist)
    :precondition (and (has-token spotify ?t) (cursor-at ?s) (song-by ?s ?a) (not (task-completed)))
    :effect (and (current-song-inspected) (confirmed-song-by ?s ?a)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?s - song ?a - artist)
    :precondition (and (target-artist ?a) (known-id ?a) (cursor-at ?s) (confirmed-song-by ?s ?a) (not (task-completed)))
    :effect (and (task-completed))))
