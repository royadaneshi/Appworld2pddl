(define (domain appworld-325d6ec-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song - object)
  (:constants
    spotify - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (queue-known)
    (liked-known)
    (current-song ?s - song)
    (next-in-queue ?s1 - song ?s2 - song)
    (liked ?s - song)
    (reached-liked-song)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_song_queue
  (:action spotify-show-song-queue
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (queue-known))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-known))

  ; API: spotify.next_song
  (:action spotify-next-song
    :parameters (?t - token ?from - song ?to - song)
    :precondition (and (has-token spotify ?t) (queue-known) (liked-known) (current-song ?from) (next-in-queue ?from ?to) (not (= ?from ?to)) (not (liked ?from)) (not (task-completed)))
    :effect (and (not (current-song ?from)) (current-song ?to)))

  ; API: spotify.show_current_song
  (:action spotify-show-current-song
    :parameters (?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (liked-known) (current-song ?s) (liked ?s) (not (task-completed)))
    :effect (reached-liked-song))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (reached-liked-song) (not (task-completed)))
    :effect (task-completed)))
