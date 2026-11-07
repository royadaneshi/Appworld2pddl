(define (domain appworld-ce359b5-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token container song - object
    library playlist - container)
  (:constants spotify - app song-library - library)
  (:predicates
    (profile-known)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-container ?c - container ?s - song)
    (released-in-or-before-2021 ?s - song)
    (listed ?c - container)
    (playlists-listed)
    (release-known ?s - song)
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

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (listed song-library))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (playlists-listed))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token)
    :precondition (and (has-token spotify ?t) (playlists-listed) (not (task-completed)))
    :effect (listed ?p))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?c - container)
    :precondition (and (listed ?c) (in-container ?c ?s) (not (task-completed)))
    :effect (release-known ?s))

  ; API: spotify.remove_song_from_library
  (:action spotify-remove-song-from-library
    :parameters (?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (listed song-library) (in-container song-library ?s) (release-known ?s) (released-in-or-before-2021 ?s) (not (task-completed)))
    :effect (not (in-container song-library ?s)))

  ; API: spotify.remove_song_from_playlist
  (:action spotify-remove-song-from-playlist
    :parameters (?p - playlist ?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (listed ?p) (in-container ?p ?s) (release-known ?s) (released-in-or-before-2021 ?s) (not (task-completed)))
    :effect (not (in-container ?p ?s)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?old-lib - song ?new-lib - song ?p - playlist ?old-pl - song ?new-pl - song)
    :precondition (and (release-known ?old-lib) (released-in-or-before-2021 ?old-lib) (not (in-container song-library ?old-lib)) (release-known ?new-lib) (not (released-in-or-before-2021 ?new-lib)) (in-container song-library ?new-lib) (listed ?p) (release-known ?old-pl) (released-in-or-before-2021 ?old-pl) (not (in-container ?p ?old-pl)) (release-known ?new-pl) (not (released-in-or-before-2021 ?new-pl)) (in-container ?p ?new-pl) (not (task-completed)))
    :effect (task-completed))
)
