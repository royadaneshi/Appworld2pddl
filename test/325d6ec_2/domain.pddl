(define (domain appworld-325d6ec-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song - object)
  (:constants spotify supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (downloaded ?s - song)
    (queue-next ?s1 - song ?s2 - song)
    (cursor-at ?s - song)
    (downloads-known)
    (queue-known))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed))
                       (passwords-known)
                       (password-for spotify ?pw)
                       (not (has-token spotify ?t)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_downloaded_songs
  (:action spotify-show-downloaded-songs
    :parameters (?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t))
    :effect (and (downloads-known)))

  ; API: spotify.show_song_queue
  (:action spotify-show-song-queue
    :parameters (?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t))
    :effect (and (queue-known)))

  ; API: spotify.next_song
  (:action spotify-next-song
    :parameters (?t - token ?from - song ?to - song)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (downloads-known)
                       (queue-known)
                       (cursor-at ?from)
                       (queue-next ?from ?to)
                       (not (downloaded ?from)))
    :effect (and (not (cursor-at ?from))
                 (cursor-at ?to)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?s - song)
    :precondition (and (not (task-completed))
                       (downloads-known)
                       (queue-known)
                       (cursor-at ?s)
                       (downloaded ?s))
    :effect (and (task-completed)))
)
