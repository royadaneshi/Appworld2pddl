(define (domain appworld-4ec8de5-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app username password token song count - object)
  (:constants spotify phone - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (current-date-known)
    (in-song-library ?s - song)
    (known-id ?s - song)
    (song-library-listed)
    (album-library-listed)
    (release-date-known ?s - song)
    (library-song-release-dates-known)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known)))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (current-date-known)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (supervisor-username ?u) (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token ?s - song)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (in-song-library ?s))
    :effect (and (song-library-listed) (known-id ?s)))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (and (album-library-listed)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song)
    :precondition (and (not (task-completed)) (song-library-listed) (known-id ?s))
    :effect (and (release-date-known ?s) (library-song-release-dates-known)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - count)
    :precondition (and (not (task-completed)) (current-date-known) (song-library-listed) (album-library-listed) (library-song-release-dates-known))
    :effect (and (task-completed)))
)
