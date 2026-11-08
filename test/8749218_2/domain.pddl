(define (domain appworld-8749218-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song - object
  )
  (:constants
    spotify - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (recommended ?s - song)
    (recommendations-known)
    (queue-reset)
    (in-queue ?s - song)
    (queue-nonempty)
    (queue-shuffled)
    (music-playing)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (passwords-known)
      (username-for spotify ?u)
      (password-for spotify ?pw)
      (not (has-token spotify ?t))
      (not (task-completed))
    )
    :effect (has-token spotify ?t)
  )

  ; API: spotify.show_recommendations
  (:action spotify-show-recommendations
    :parameters (?t - token)
    :precondition (and
      (has-token spotify ?t)
      (not (task-completed))
    )
    :effect (recommendations-known)
  )

  ; API: spotify.clear_song_queue
  (:action spotify-clear-song-queue
    :parameters (?t - token)
    :precondition (and
      (has-token spotify ?t)
      (not (queue-reset))
      (not (task-completed))
    )
    :effect (queue-reset)
  )

  ; API: spotify.add_to_queue
  (:action spotify-add-to-queue
    :parameters (?t - token ?s - song)
    :precondition (and
      (has-token spotify ?t)
      (recommendations-known)
      (recommended ?s)
      (queue-reset)
      (not (in-queue ?s))
      (not (task-completed))
    )
    :effect (and
      (in-queue ?s)
      (queue-nonempty)
      (not (queue-shuffled))
    )
  )

  ; API: spotify.shuffle_song_queue
  (:action spotify-shuffle-song-queue
    :parameters (?t - token)
    :precondition (and
      (has-token spotify ?t)
      (queue-reset)
      (queue-nonempty)
      (not (task-completed))
    )
    :effect (queue-shuffled)
  )

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token)
    :precondition (and
      (has-token spotify ?t)
      (queue-reset)
      (queue-nonempty)
      (queue-shuffled)
      (not (task-completed))
    )
    :effect (music-playing)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (queue-reset)
      (queue-shuffled)
      (music-playing)
      (not (task-completed))
    )
    :effect (task-completed)
  )
)
