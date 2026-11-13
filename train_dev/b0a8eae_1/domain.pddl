(define (domain appworld-b0a8eae-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note duration playlist song - object
  )
  (:constants
    simple-note spotify phone - app
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (date-known)
    (task-completed)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x)
    (query-matches-note ?q - query ?n - note)
    (is-workout-note ?n - note)
    (note-duration-for-today ?n - note ?d - duration)
    (found-workout-duration ?d - duration)
    (in-library ?p - playlist)
    (song-in-playlist ?s - song ?p - playlist)
    (song-duration-known ?s - song)
    (playlist-duration-known ?p - playlist)
    (long-enough-for ?p - playlist ?d - duration)
    (playing ?p - playlist)
    (workout-playlist-playing)
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
    :precondition (and (credential-of-app simple-note ?t) (credential-of-app simple-note ?pw)
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (supervisor-username ?u)
      (password-for simple-note ?pw)
      (not (has-token simple-note ?t))
    )
    :effect (and (has-token simple-note ?t))
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and
      (not (task-completed))
      (has-token simple-note ?t)
      (query-matches-note ?q ?n)
    )
    :effect (and (known-id ?n))
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?d - duration)
    :precondition (and
      (not (task-completed))
      (has-token simple-note ?t)
      (known-id ?n)
      (is-workout-note ?n)
      (date-known)
      (note-duration-for-today ?n ?d)
    )
    :effect (and (found-workout-duration ?d))
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app spotify ?t) (credential-of-app spotify ?pw)
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (supervisor-username ?u)
      (password-for spotify ?pw)
      (not (has-token spotify ?t))
    )
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?p - playlist)
    :precondition (and
      (not (task-completed))
      (has-token spotify ?t)
      (in-library ?p)
    )
    :effect (and (known-id ?p))
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?p - playlist)
    :precondition (and
      (not (task-completed))
      (known-id ?p)
      (song-in-playlist ?s ?p)
    )
    :effect (and (song-duration-known ?s) (playlist-duration-known ?p))
  )

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token ?p - playlist ?d - duration)
    :precondition (and
      (not (task-completed))
      (has-token spotify ?t)
      (known-id ?p)
      (playlist-duration-known ?p)
      (found-workout-duration ?d)
      (long-enough-for ?p ?d)
    )
    :effect (and (playing ?p) (workout-playlist-playing))
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
