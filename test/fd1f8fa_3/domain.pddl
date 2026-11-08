(define (domain appworld-fd1f8fa-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app username password token song position - object)
  (:constants spotify supervisor - app pos-none - position)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (queue-known)
    (liked-songs-known)
    (liked ?s - song)
    (in-queue ?s - song)
    (at-position ?s - song ?p - position)
    (next-liked-removal ?p - position)
    (next-liked-below ?p - position ?below - position)
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
    :parameters (?pos - position ?t - token ?s - song ?below - position)
    :precondition (and (has-token spotify ?t) (queue-known) (liked-songs-known) (in-queue ?s) (at-position ?s ?pos) (liked ?s) (next-liked-removal ?pos) (next-liked-below ?pos ?below) (not (task-completed)))
    :effect (and (not (in-queue ?s)) (not (next-liked-removal ?pos)) (next-liked-removal ?below)))

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (queue-known) (next-liked-removal pos-none) (not (task-completed)))
    :effect (playing))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (next-liked-removal pos-none) (playing) (not (task-completed)))
    :effect (task-completed))
)
