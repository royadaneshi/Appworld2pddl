(define (domain appworld-fd1f8fa-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token song position count - object)
  (:constants spotify supervisor - app count-0 - count)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (queue-known)
    (liked-songs-known)
    (liked ?s - song)
    (in-queue ?s - song)
    (at-position ?s - song ?p - position)
    (liked-in-queue ?c - count)
    (count-after-removal ?c - count ?c2 - count)
    (next-liked-to-remove ?c - count ?s - song)
    (playing)
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
    :effect (liked-songs-known))

  ; API: spotify.remove_song_from_queue
  (:action spotify-remove-song-from-queue
    :parameters (?p - position ?t - token ?s - song ?c - count ?c2 - count)
    :precondition (and (has-token spotify ?t) (queue-known) (liked-songs-known) (liked ?s) (in-queue ?s) (at-position ?s ?p) (liked-in-queue ?c) (next-liked-to-remove ?c ?s) (count-after-removal ?c ?c2) (not (playing)) (not (task-completed)))
    :effect (and (not (in-queue ?s)) (not (liked-in-queue ?c)) (liked-in-queue ?c2)))

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (playing)) (not (task-completed)))
    :effect (playing))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (liked-in-queue count-0) (playing) (not (task-completed)))
    :effect (task-completed)))
