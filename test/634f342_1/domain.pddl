(define (domain appworld-634f342-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token path title song playlist - object)
  (:constants
    file-system spotify supervisor - app
    old-song-1 old-song-2 old-song-3 old-song-4 old-song-5 old-song-6 old-song-7 old-song-8 old-song-9 old-song-10 old-song-11 old-song-12 old-song-13 old-song-14 - song
    playlist-1 playlist-2 playlist-3 playlist-4 playlist-5 playlist-6 archived-songs - playlist
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (file-read ?f - path)
    (listed-in-file ?s - song ?f - path)
    (playlists-listed)
    (playlist-exists ?p - playlist)
    (playlist-inspected ?p - playlist)
    (in-playlist ?s - song ?p - playlist)
    (playlist-title ?p - playlist ?ti - title)
    (created-playlist ?p - playlist)
    (to-archive ?s - song)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - path ?t - token)
    :precondition (and (has-token file-system ?t) (not (task-completed)))
    :effect (file-read ?f))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app spotify ?t) (credential-of-app spotify ?pw) (credential-of-app spotify ?u) (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (playlists-listed))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token)
    :precondition (and (has-token spotify ?t) (playlists-listed) (playlist-exists ?p) (not (task-completed)))
    :effect (playlist-inspected ?p))

  ; API: spotify.remove_song_from_playlist
  (:action spotify-remove-song-from-playlist
    :parameters (?p - playlist ?s - song ?t - token ?f - path)
    :precondition (and (has-token spotify ?t) (playlist-inspected ?p) (not (created-playlist ?p)) (in-playlist ?s ?p) (file-read ?f) (listed-in-file ?s ?f) (not (task-completed)))
    :effect (and (not (in-playlist ?s ?p)) (to-archive ?s)))

  ; API: spotify.create_playlist
  (:action spotify-create-playlist
    :parameters (?ti - title ?t - token ?p - playlist)
    :precondition (and (has-token spotify ?t) (playlist-title ?p ?ti) (not (playlist-exists ?p)) (not (task-completed)))
    :effect (and (playlist-exists ?p) (created-playlist ?p)))

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?p - playlist ?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (created-playlist ?p) (to-archive ?s) (not (in-playlist ?s ?p)) (not (task-completed)))
    :effect (in-playlist ?s ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (created-playlist archived-songs)
      (in-playlist old-song-1 archived-songs)
      (in-playlist old-song-2 archived-songs)
      (in-playlist old-song-3 archived-songs)
      (in-playlist old-song-4 archived-songs)
      (in-playlist old-song-5 archived-songs)
      (in-playlist old-song-6 archived-songs)
      (in-playlist old-song-7 archived-songs)
      (in-playlist old-song-8 archived-songs)
      (in-playlist old-song-9 archived-songs)
      (in-playlist old-song-10 archived-songs)
      (in-playlist old-song-11 archived-songs)
      (in-playlist old-song-12 archived-songs)
      (in-playlist old-song-13 archived-songs)
      (in-playlist old-song-14 archived-songs)
      (not (in-playlist old-song-3 playlist-1))
      (not (in-playlist old-song-12 playlist-1))
      (not (in-playlist old-song-11 playlist-2))
      (not (in-playlist old-song-14 playlist-2))
      (not (in-playlist old-song-1 playlist-2))
      (not (in-playlist old-song-2 playlist-3))
      (not (in-playlist old-song-7 playlist-3))
      (not (in-playlist old-song-5 playlist-3))
      (not (in-playlist old-song-9 playlist-4))
      (not (in-playlist old-song-13 playlist-4))
      (not (in-playlist old-song-10 playlist-4))
      (not (in-playlist old-song-8 playlist-5))
      (not (in-playlist old-song-9 playlist-6))
      (not (in-playlist old-song-6 playlist-6))
      (not (in-playlist old-song-4 playlist-6))
      (not (task-completed)))
    :effect (task-completed))
)
