(define (domain appworld-325d6ec-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (queue-known)
    (liked-songs-known)
    (current-song ?s - song)
    (prev-in-queue ?s - song ?p - song)
    (liked ?s - song)
    (task-completed))
  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))
  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))
  ; API: spotify.show_song_queue
  (:action spotify-show-song-queue
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (queue-known)))
  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (liked-songs-known)))
  ; API: spotify.previous_song
  (:action spotify-previous-song
    :parameters (?t - token ?from - song ?to - song)
    :precondition (and (has-token spotify ?t) (queue-known) (liked-songs-known) (current-song ?from) (prev-in-queue ?from ?to) (not (liked ?from)) (not (= ?from ?to)) (not (task-completed)))
    :effect (and (not (current-song ?from)) (current-song ?to)))
  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?s - song)
    :precondition (and (current-song ?s) (liked ?s) (queue-known) (liked-songs-known) (not (task-completed)))
    :effect (and (task-completed))))
