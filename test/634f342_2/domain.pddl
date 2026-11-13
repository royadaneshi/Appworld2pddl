(define (domain appworld-634f342-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token path query playlist song playlist-title - object)
  (:constants file-system spotify - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (archive-list-file ?f - path)
    (archive-list-known)
    (archive-song ?s - song)
    (song-query ?s - song ?q - query)
    (known-id ?s - song)
    (playlists-listed)
    (playlist-exists ?p - playlist)
    (playlist-inspected ?p - playlist)
    (in-playlist ?p - playlist ?s - song)
    (playlist-created ?p - playlist)
    (playlist-titled ?p - playlist ?title - playlist-title)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - path ?t - token)
    :precondition (and (has-token file-system ?t) (archive-list-file ?f) (not (task-completed)))
    :effect (archive-list-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app spotify ?t) (credential-of-app spotify ?pw) (credential-of-app spotify ?u) (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?s - song)
    :precondition (and (archive-list-known) (archive-song ?s) (song-query ?s ?q) (not (task-completed)))
    :effect (known-id ?s))

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
    :parameters (?p - playlist ?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (playlist-inspected ?p) (in-playlist ?p ?s) (archive-song ?s) (known-id ?s) (not (task-completed)))
    :effect (not (in-playlist ?p ?s)))

  ; API: spotify.create_playlist
  (:action spotify-create-playlist
    :parameters (?title - playlist-title ?t - token ?np - playlist)
    :precondition (and (has-token spotify ?t) (not (playlist-exists ?np)) (not (task-completed)))
    :effect (and (playlist-exists ?np) (playlist-created ?np) (playlist-titled ?np ?title)))

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?np - playlist ?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (playlist-created ?np) (archive-song ?s) (known-id ?s) (not (in-playlist ?np ?s)) (not (task-completed)))
    :effect (in-playlist ?np ?s))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?np - playlist ?title - playlist-title)
    :precondition (and (archive-list-known) (playlists-listed) (playlist-created ?np) (playlist-titled ?np ?title) (not (task-completed)))
    :effect (task-completed))
)
