(define (domain appworld-59fae45-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person playlist song genre title username password token count - object
  )
  (:constants
    spotify - app
  )
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (playlists-listed)
    (songs-known ?p - playlist)
    (in-playlist ?s - song ?p - playlist)
    (song-genre ?s - song ?g - genre)
    (known-genre ?s - song ?g - genre)
    (genre-checked ?s - song ?p - playlist)
    (genres-known-count ?p - playlist ?n - count)
    (song-count ?p - playlist ?n - count)
    (most-common-genre ?p - playlist ?g - genre)
    (new-title ?p - playlist ?g - genre ?ti - title)
    (title-updated ?p - playlist ?ti - title)
    (updated-count ?n - count)
    (playlist-count ?n - count)
    (succ ?n1 - count ?n2 - count)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and
      (not (task-completed))
    )
    :effect (and
      (passwords-known)
    )
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
    :effect (and
      (has-token spotify ?t)
    )
  )

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and
      (has-token spotify ?t)
      (not (task-completed))
    )
    :effect (and
      (playlists-listed)
    )
  )

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token)
    :precondition (and
      (has-token spotify ?t)
      (playlists-listed)
      (not (task-completed))
    )
    :effect (and
      (songs-known ?p)
    )
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?p - playlist ?g - genre ?n - count ?n2 - count)
    :precondition (and
      (songs-known ?p)
      (in-playlist ?s ?p)
      (song-genre ?s ?g)
      (not (genre-checked ?s ?p))
      (genres-known-count ?p ?n)
      (succ ?n ?n2)
      (not (task-completed))
    )
    :effect (and
      (known-genre ?s ?g)
      (genre-checked ?s ?p)
      (not (genres-known-count ?p ?n))
      (genres-known-count ?p ?n2)
    )
  )

  ; API: spotify.update_playlist
  (:action spotify-update-playlist
    :parameters (?p - playlist ?t - token ?ti - title ?g - genre ?n - count ?m - count ?m2 - count)
    :precondition (and
      (has-token spotify ?t)
      (songs-known ?p)
      (genres-known-count ?p ?n)
      (song-count ?p ?n)
      (most-common-genre ?p ?g)
      (new-title ?p ?g ?ti)
      (not (title-updated ?p ?ti))
      (updated-count ?m)
      (succ ?m ?m2)
      (not (task-completed))
    )
    :effect (and
      (title-updated ?p ?ti)
      (not (updated-count ?m))
      (updated-count ?m2)
    )
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - count)
    :precondition (and
      (updated-count ?n)
      (playlist-count ?n)
      (not (task-completed))
    )
    :effect (and
      (task-completed)
    )
  )
)
