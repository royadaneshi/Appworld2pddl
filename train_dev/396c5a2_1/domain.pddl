(define (domain appworld-396c5a2-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query artist song playcount - object)
  (:constants
    spotify - app
    lily-moon-song-1 - song)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (supervisor-username ?u - username)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?ar - artist)
    (known-id ?ar - artist)
    (play-count-threshold ?pc - playcount)
    (songs-found ?ar - artist ?pc - playcount)
    (song-by ?s - song ?ar - artist)
    (play-count-over ?s - song ?pc - playcount)
    (in-queue ?s - song)
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
    :precondition (and (not (task-completed)) (profile-known) (passwords-known) (supervisor-username ?u) (password-for spotify ?pw) (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  ; API: spotify.search_artists
  (:action spotify-search-artists
    :parameters (?q - query ?ar - artist)
    :precondition (and (not (task-completed)) (query-for ?q ?ar))
    :effect (known-id ?ar))

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?ar - artist ?pc - playcount)
    :precondition (and (not (task-completed)) (query-for ?q ?ar) (known-id ?ar) (play-count-threshold ?pc))
    :effect (songs-found ?ar ?pc))

  ; API: spotify.add_to_queue
  (:action spotify-add-to-queue
    :parameters (?t - token ?s - song ?ar - artist ?pc - playcount)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (songs-found ?ar ?pc) (song-by ?s ?ar) (play-count-over ?s ?pc) (not (in-queue ?s)))
    :effect (in-queue ?s))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (in-queue lily-moon-song-1)
      (not (task-completed)))
    :effect (task-completed))
)
