(define (domain appworld-b0a8eae-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token query weekday duration note playlist song - object)
  (:constants simple-note spotify phone - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (date-known)
    (task-completed)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (current-weekday ?d - weekday)
    (note-matches ?n - note ?q - query)
    (known-id ?n - note)
    (plan-duration ?n - note ?d - weekday ?dur - duration)
    (note-content-known ?n - note)
    (workout-duration-known ?dur - duration)
    (playlists-listed)
    (song-to-check ?p - playlist ?s - song)
    (followed-by ?p - playlist ?s1 - song ?s2 - song)
    (last-song ?p - playlist ?s - song)
    (song-duration-known ?s - song)
    (long-enough ?p - playlist ?dur - duration)
    (playing-playlist ?p - playlist))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (not (task-completed))
    :effect (date-known))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (supervisor-username ?u)
                       (password-for simple-note ?pw)
                       (token-for simple-note ?t)
                       (not (has-token simple-note ?t))
                       (not (task-completed)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t)
                       (note-matches ?n ?q)
                       (not (task-completed)))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?d - weekday ?dur - duration)
    :precondition (and (has-token simple-note ?t)
                       (known-id ?n)
                       (date-known)
                       (current-weekday ?d)
                       (plan-duration ?n ?d ?dur)
                       (not (task-completed)))
    :effect (and (note-content-known ?n) (workout-duration-known ?dur)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (supervisor-username ?u)
                       (password-for spotify ?pw)
                       (token-for spotify ?t)
                       (not (has-token spotify ?t))
                       (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (playlists-listed))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?p - playlist ?next - song)
    :precondition (and (playlists-listed)
                       (song-to-check ?p ?s)
                       (followed-by ?p ?s ?next)
                       (not (task-completed)))
    :effect (and (song-duration-known ?s) (song-to-check ?p ?next)))

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token ?p - playlist ?s - song ?dur - duration)
    :precondition (and (has-token spotify ?t)
                       (playlists-listed)
                       (last-song ?p ?s)
                       (song-duration-known ?s)
                       (workout-duration-known ?dur)
                       (long-enough ?p ?dur)
                       (not (task-completed)))
    :effect (playing-playlist ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - playlist)
    :precondition (and (playing-playlist ?p) (not (task-completed)))
    :effect (task-completed))
)
