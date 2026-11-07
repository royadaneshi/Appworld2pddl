(define (domain appworld-b0a8eae-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note duration playlist song - object
  )
  (:constants
    supervisor phone simple-note spotify - app
  )
  (:predicates
    (profile-known)
    (passwords-known)
    (date-known)
    (supervisor-email ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-query ?n - note ?q - query)
    (workout-note ?n - note)
    (known-id ?n - note)
    (found-workout-duration ?d - duration)
    (known-playlist ?pl - playlist)
    (song-in-playlist ?s - song ?pl - playlist)
    (known-song-duration ?s - song)
    (playlist-fits-workout ?pl - playlist)
    (playing ?pl - playlist)
    (workout-playlist-playing)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known))
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (date-known))
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (profile-known)
      (passwords-known)
      (supervisor-email ?u)
      (password-for simple-note ?pw)
      (not (has-token simple-note ?t))
      (not (task-completed))
    )
    :effect (and (has-token simple-note ?t))
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and
      (has-token simple-note ?t)
      (note-query ?n ?q)
      (not (task-completed))
    )
    :effect (and (known-id ?n))
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?d - duration)
    :precondition (and
      (has-token simple-note ?t)
      (known-id ?n)
      (workout-note ?n)
      (date-known)
      (not (task-completed))
    )
    :effect (and (found-workout-duration ?d))
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (profile-known)
      (passwords-known)
      (supervisor-email ?u)
      (password-for spotify ?pw)
      (not (has-token spotify ?t))
      (not (task-completed))
    )
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?pl - playlist)
    :precondition (and
      (has-token spotify ?t)
      (not (task-completed))
    )
    :effect (and (known-playlist ?pl))
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?pl - playlist ?d - duration)
    :precondition (and
      (known-playlist ?pl)
      (song-in-playlist ?s ?pl)
      (found-workout-duration ?d)
      (not (task-completed))
    )
    :effect (and (known-song-duration ?s) (playlist-fits-workout ?pl))
  )

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token ?pl - playlist)
    :precondition (and
      (has-token spotify ?t)
      (known-playlist ?pl)
      (playlist-fits-workout ?pl)
      (not (task-completed))
    )
    :effect (and (playing ?pl) (workout-playlist-playing))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (workout-playlist-playing)
      (not (task-completed))
    )
    :effect (and (task-completed))
  )
)
