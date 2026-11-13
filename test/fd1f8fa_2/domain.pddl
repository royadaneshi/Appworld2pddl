(define (domain appworld-fd1f8fa-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song position - object)
  (:constants
    spotify - app
    unliked-queue-song-1 unliked-queue-song-2 unliked-queue-song-3 unliked-queue-song-4 unliked-queue-song-5 unliked-queue-song-6 unliked-queue-song-7 unliked-queue-song-8 unliked-queue-song-9 unliked-queue-song-10 unliked-queue-song-11 unliked-queue-song-12 liked-queue-song - song
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (queue-known)
    (liked-known)
    (in-queue ?s - song)
    (at-position ?s - song ?p - position)
    (liked ?s - song)
    (later-unliked ?s - song ?later - song)
    (player-playing)
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

  ; API: spotify.remove_song_from_queue
  (:action spotify-remove-song-from-queue
    :parameters (?p - position ?t - token ?s - song ?later - song)
    :precondition (and (has-token spotify ?t) (queue-known) (liked-known)
                       (in-queue ?s) (at-position ?s ?p) (not (liked ?s))
                       (later-unliked ?s ?later) (not (in-queue ?later))
                       (not (player-playing)) (not (task-completed)))
    :effect (and (not (in-queue ?s)) (not (at-position ?s ?p))))

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (queue-known) (not (player-playing)) (not (task-completed)))
    :effect (player-playing))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (in-queue liked-queue-song)
      (not (in-queue unliked-queue-song-1))
      (not (in-queue unliked-queue-song-2))
      (not (in-queue unliked-queue-song-3))
      (not (in-queue unliked-queue-song-4))
      (not (in-queue unliked-queue-song-5))
      (not (in-queue unliked-queue-song-6))
      (not (in-queue unliked-queue-song-7))
      (not (in-queue unliked-queue-song-8))
      (not (in-queue unliked-queue-song-9))
      (not (in-queue unliked-queue-song-10))
      (not (in-queue unliked-queue-song-11))
      (not (in-queue unliked-queue-song-12))
      (player-playing)
      (not (task-completed))
      (not (task-completed)))
    :effect (task-completed))
)
