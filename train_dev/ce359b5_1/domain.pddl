(define (domain appworld-ce359b5-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token count song container - object
    library playlist - container)
  (:constants
    spotify - app
    song-library - library
    n0 - count)
  (:predicates
    (passwords-known)
    (profile-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (contains ?c - container ?s - song)
    (released-before-2021 ?s - song)
    (container-shown ?c - container)
    (playlists-listed)
    (known-release-date ?s - song)
    (succ ?m - count ?n - count)
    (pending-removals ?n - count)
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
    :precondition (and (not (task-completed))
                       (profile-known)
                       (passwords-known)
                       (username-for spotify ?u)
                       (password-for spotify ?pw)
                       (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (container-shown song-library))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (playlists-listed))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (playlists-listed))
    :effect (container-shown ?p))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?c - container)
    :precondition (and (not (task-completed)) (contains ?c ?s) (container-shown ?c))
    :effect (known-release-date ?s))

  ; API: spotify.remove_song_from_library
  (:action spotify-remove-song-from-library
    :parameters (?s - song ?t - token ?n - count ?m - count)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (container-shown song-library)
                       (contains song-library ?s)
                       (known-release-date ?s)
                       (released-before-2021 ?s)
                       (pending-removals ?n)
                       (succ ?m ?n))
    :effect (and (not (contains song-library ?s))
                 (not (pending-removals ?n))
                 (pending-removals ?m)))

  ; API: spotify.remove_song_from_playlist
  (:action spotify-remove-song-from-playlist
    :parameters (?p - playlist ?s - song ?t - token ?n - count ?m - count)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (container-shown ?p)
                       (contains ?p ?s)
                       (known-release-date ?s)
                       (released-before-2021 ?s)
                       (pending-removals ?n)
                       (succ ?m ?n))
    :effect (and (not (contains ?p ?s))
                 (not (pending-removals ?n))
                 (pending-removals ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)) (pending-removals n0))
    :effect (task-completed)))
