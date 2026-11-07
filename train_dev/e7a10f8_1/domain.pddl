(define (domain appworld-e7a10f8-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token playlist song minutes - object
  )
  (:constants
    spotify - app
  )
  (:predicates
    (passwords-known)
    (profile-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-library ?p - playlist)
    (song-in ?p - playlist ?s - song)
    (minutes-of ?p - playlist ?m - minutes)
    (library-listed)
    (songs-listed ?p - playlist)
    (duration-known ?s - song)
    (found-longest-minutes ?m - minutes)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known)
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
    :precondition (and (profile-known) (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t)
  )

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (library-listed)
  )

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token)
    :precondition (and (has-token spotify ?t) (library-listed) (in-library ?p) (not (task-completed)))
    :effect (songs-listed ?p)
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?p - playlist ?m - minutes)
    :precondition (and (songs-listed ?p) (song-in ?p ?s) (minutes-of ?p ?m) (not (task-completed)))
    :effect (and (duration-known ?s) (found-longest-minutes ?m))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?m - minutes)
    :precondition (and (found-longest-minutes ?m) (not (task-completed)))
    :effect (task-completed)
  )
)
