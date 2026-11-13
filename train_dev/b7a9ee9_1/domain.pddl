(define (domain appworld-b7a9ee9-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token playlist song artist genre - object
  )
  (:constants
    spotify - app
    classical - genre
    classical-artist-1 classical-artist-2 classical-artist-3 classical-artist-4 classical-artist-5 - artist
  )
  (:predicates
    (passwords-known)
    (profile-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (library-shown)
    (owns-playlist ?p - playlist)
    (playlist-shown ?p - playlist)
    (contains ?p - playlist ?s - song)
    (song-shown ?s - song)
    (song-genre ?s - song ?g - genre)
    (song-artist ?s - song ?ar - artist)
    (following ?ar - artist)
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

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (profile-known)
      (passwords-known)
      (username-for spotify ?u)
      (password-for spotify ?pw)
      (not (has-token spotify ?t))
      (not (task-completed)))
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (library-shown))
  )

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token)
    :precondition (and
      (has-token spotify ?t)
      (library-shown)
      (owns-playlist ?p)
      (not (task-completed)))
    :effect (and (playlist-shown ?p))
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?p - playlist)
    :precondition (and
      (playlist-shown ?p)
      (contains ?p ?s)
      (not (task-completed)))
    :effect (and (song-shown ?s))
  )

  ; API: spotify.follow_artist
  (:action spotify-follow-artist
    :parameters (?ar - artist ?t - token ?s - song)
    :precondition (and
      (has-token spotify ?t)
      (song-shown ?s)
      (song-genre ?s classical)
      (song-artist ?s ?ar)
      (not (following ?ar))
      (not (task-completed)))
    :effect (and (following ?ar))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (following classical-artist-1)
      (following classical-artist-2)
      (following classical-artist-3)
      (following classical-artist-4)
      (following classical-artist-5)
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
