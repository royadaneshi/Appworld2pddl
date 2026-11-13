(define (domain appworld-8749218-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song - object
  )
  (:constants
    supervisor spotify - app
    rec-song-1 rec-song-2 rec-song-3 rec-song-4 rec-song-5 rec-song-6 rec-song-7 rec-song-8 rec-song-9 rec-song-10 rec-song-11 rec-song-12 rec-song-13 rec-song-14 rec-song-15 rec-song-16 rec-song-17 rec-song-18 rec-song-19 rec-song-20 rec-song-21 rec-song-22 rec-song-23 - song
  )
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (recommendations-known)
    (recommended-song ?s - song)
    (queue-cleared)
    (in-queue ?s - song)
    (queue-shuffled)
    (is-playing)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_recommendations
  (:action spotify-show-recommendations
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (recommendations-known))
  )

  ; API: spotify.clear_song_queue
  (:action spotify-clear-song-queue
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (queue-cleared)) (not (task-completed)))
    :effect (and (queue-cleared))
  )

  ; API: spotify.add_to_queue
  (:action spotify-add-to-queue
    :parameters (?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (recommendations-known) (recommended-song ?s) (queue-cleared) (not (in-queue ?s)) (not (queue-shuffled)) (not (task-completed)))
    :effect (and (in-queue ?s))
  )

  ; API: spotify.shuffle_song_queue
  (:action spotify-shuffle-song-queue
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (queue-cleared) (not (queue-shuffled)) (not (task-completed)))
    :effect (and (queue-shuffled))
  )

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (queue-shuffled) (not (is-playing)) (not (task-completed)))
    :effect (and (is-playing))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (in-queue rec-song-1)
      (in-queue rec-song-2)
      (in-queue rec-song-3)
      (in-queue rec-song-4)
      (in-queue rec-song-5)
      (in-queue rec-song-6)
      (in-queue rec-song-7)
      (in-queue rec-song-8)
      (in-queue rec-song-9)
      (in-queue rec-song-10)
      (in-queue rec-song-11)
      (in-queue rec-song-12)
      (in-queue rec-song-13)
      (in-queue rec-song-14)
      (in-queue rec-song-15)
      (in-queue rec-song-16)
      (in-queue rec-song-17)
      (in-queue rec-song-18)
      (in-queue rec-song-19)
      (in-queue rec-song-20)
      (in-queue rec-song-21)
      (in-queue rec-song-22)
      (in-queue rec-song-23)
      (queue-shuffled)
      (is-playing)
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
