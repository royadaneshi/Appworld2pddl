(define (domain appworld-4ec8de5-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song album count - object)
  (:constants spotify phone - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-date-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-song-library ?s - song)
    (in-album-library ?al - album)
    (song-library-listed)
    (album-library-listed)
    (known-id ?s - song)
    (known-release-date ?s - song)
    (known-album-release-date ?al - album)
    (known-album-songs ?al - album)
    (task-completed))

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
    :effect (current-date-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed))
                       (profile-known)
                       (passwords-known)
                       (supervisor-username ?u)
                       (password-for spotify ?pw)
                       (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token ?s - song)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (in-song-library ?s))
    :effect (and (song-library-listed) (known-id ?s)))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token ?al - album)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (in-album-library ?al))
    :effect (and (album-library-listed)
                 (known-album-release-date ?al)
                 (known-album-songs ?al)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song)
    :precondition (and (not (task-completed))
                       (known-id ?s))
    :effect (known-release-date ?s))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - count ?s - song ?al - album)
    :precondition (and (not (task-completed))
                       (current-date-known)
                       (song-library-listed)
                       (album-library-listed)
                       (in-song-library ?s)
                       (known-release-date ?s)
                       (in-album-library ?al)
                       (known-album-release-date ?al)
                       (known-album-songs ?al))
    :effect (task-completed))
)
