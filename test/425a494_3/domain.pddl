(define (domain appworld-425a494-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token genre - object
    entity - object
    playlist song - entity)
  (:constants spotify supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (playlists-known)
    (playlist-songs-known)
    (liked-songs-known)
    (found-most-liked-genre ?g - genre)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?p - playlist)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (playlists-known) (known-id ?p)))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (known-id ?p) (not (task-completed)))
    :effect (and (playlist-songs-known) (known-id ?s)))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-songs-known))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?g - genre)
    :precondition (and (known-id ?s) (playlist-songs-known) (liked-songs-known) (not (task-completed)))
    :effect (found-most-liked-genre ?g))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?g - genre)
    :precondition (and (playlists-known) (playlist-songs-known) (liked-songs-known) (found-most-liked-genre ?g) (not (task-completed)))
    :effect (task-completed)))
