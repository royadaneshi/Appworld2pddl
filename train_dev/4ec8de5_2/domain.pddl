(define (domain appworld-4ec8de5-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song count - object
  )
  (:constants
    spotify phone - app
  )
  (:predicates
    (is-supervisor ?p - person)
    (supervisor-username ?u - username)
    (profile-known)
    (passwords-known)
    (current-date-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (song-library-listed)
    (album-library-listed)
    (in-song-library ?s - song)
    (release-date-known ?s - song)
    (song-release-dates-known)
    (answer-count ?c - count)
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
    :effect (and (current-date-known))
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (supervisor-username ?u)
      (password-for spotify ?pw)
      (not (has-token spotify ?t)))
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and
      (not (task-completed))
      (has-token spotify ?t))
    :effect (and (song-library-listed))
  )

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and
      (not (task-completed))
      (has-token spotify ?t))
    :effect (and (album-library-listed))
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song)
    :precondition (and
      (not (task-completed))
      (song-library-listed)
      (in-song-library ?s))
    :effect (and (release-date-known ?s) (song-release-dates-known))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - count)
    :precondition (and
      (not (task-completed))
      (answer-count ?c)
      (current-date-known)
      (song-library-listed)
      (album-library-listed)
      (song-release-dates-known))
    :effect (and (task-completed))
  )
)
