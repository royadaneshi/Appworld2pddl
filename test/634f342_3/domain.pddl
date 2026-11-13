(define (domain appworld-634f342-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token file-path playlist-title playlist song - object)
  (:constants
    supervisor file-system spotify - app
    playlist-1 playlist-2 playlist-3 playlist-4 playlist-5 playlist-6 playlist-7 archived-playlist-songs - playlist
    old-song-1 old-song-2 old-song-3 old-song-4 old-song-5 old-song-6 old-song-7 old-song-8 old-song-9 old-song-10 old-song-11 old-song-12 old-song-13 - song
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (old-songs-file ?f - file-path)
    (old-songs-known)
    (old-song ?s - song)
    (playlists-listed)
    (preexisting-playlist ?p - playlist)
    (playlist-contents-known ?p - playlist)
    (song-in-playlist ?s - song ?p - playlist)
    (removed-from-playlist ?s - song)
    (has-title ?p - playlist ?title - playlist-title)
    (created-playlist ?p - playlist)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (not (task-completed)) (passwords-known)
                       (username-for file-system ?u) (password-for file-system ?pw)
                       (not (has-token file-system ?t)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file-path ?t - token)
    :precondition (and (not (task-completed)) (has-token file-system ?t) (old-songs-file ?f))
    :effect (and (old-songs-known)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app spotify ?t) (credential-of-app spotify ?pw) (credential-of-app spotify ?u) (not (task-completed)) (passwords-known)
                       (username-for spotify ?u) (password-for spotify ?pw)
                       (not (has-token spotify ?t)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (and (playlists-listed)))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (playlists-listed) (preexisting-playlist ?p))
    :effect (and (playlist-contents-known ?p)))

  ; API: spotify.remove_song_from_playlist
  (:action spotify-remove-song-from-playlist
    :parameters (?p - playlist ?s - song ?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t)
                       (playlist-contents-known ?p) (old-songs-known) (old-song ?s)
                       (song-in-playlist ?s ?p))
    :effect (and (not (song-in-playlist ?s ?p)) (removed-from-playlist ?s)))

  ; API: spotify.create_playlist
  (:action spotify-create-playlist
    :parameters (?title - playlist-title ?t - token ?p - playlist)
    :precondition (and (not (task-completed)) (has-token spotify ?t)
                       (has-title ?p ?title) (not (preexisting-playlist ?p)) (not (created-playlist ?p)))
    :effect (and (created-playlist ?p)))

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?p - playlist ?s - song ?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t)
                       (created-playlist ?p) (removed-from-playlist ?s)
                       (not (song-in-playlist ?s ?p)))
    :effect (and (song-in-playlist ?s ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (created-playlist archived-playlist-songs)
      (not (song-in-playlist old-song-9 playlist-1))
      (not (song-in-playlist old-song-13 playlist-2))
      (not (song-in-playlist old-song-2 playlist-2))
      (not (song-in-playlist old-song-6 playlist-3))
      (not (song-in-playlist old-song-12 playlist-4))
      (not (song-in-playlist old-song-4 playlist-4))
      (not (song-in-playlist old-song-11 playlist-4))
      (not (song-in-playlist old-song-1 playlist-5))
      (not (song-in-playlist old-song-8 playlist-6))
      (not (song-in-playlist old-song-3 playlist-6))
      (not (song-in-playlist old-song-5 playlist-6))
      (not (song-in-playlist old-song-2 playlist-7))
      (not (song-in-playlist old-song-10 playlist-7))
      (not (song-in-playlist old-song-7 playlist-7))
      (song-in-playlist old-song-1 archived-playlist-songs)
      (song-in-playlist old-song-2 archived-playlist-songs)
      (song-in-playlist old-song-3 archived-playlist-songs)
      (song-in-playlist old-song-4 archived-playlist-songs)
      (song-in-playlist old-song-5 archived-playlist-songs)
      (song-in-playlist old-song-6 archived-playlist-songs)
      (song-in-playlist old-song-7 archived-playlist-songs)
      (song-in-playlist old-song-8 archived-playlist-songs)
      (song-in-playlist old-song-9 archived-playlist-songs)
      (song-in-playlist old-song-10 archived-playlist-songs)
      (song-in-playlist old-song-11 archived-playlist-songs)
      (song-in-playlist old-song-12 archived-playlist-songs)
      (song-in-playlist old-song-13 archived-playlist-songs)
      (not (task-completed)))
    :effect (and (task-completed)))
)
