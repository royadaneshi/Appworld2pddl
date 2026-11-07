(define (domain appworld-ce359b5-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token count song collection - object
    song-library playlist - collection)
  (:constants spotify - app n0 - count)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (contains ?c - collection ?s - song)
    (listed ?c - collection)
    (playlists-listed)
    (release-known ?s - song)
    (released-after-2021 ?s - song)
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
    :precondition (and (profile-known) (username-for spotify ?u)
                       (passwords-known) (password-for spotify ?pw)
                       (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token ?l - song-library)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (listed ?l))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?c - collection)
    :precondition (and (listed ?c) (contains ?c ?s) (not (task-completed)))
    :effect (release-known ?s))

  ; API: spotify.remove_song_from_library
  (:action spotify-remove-song-from-library
    :parameters (?s - song ?t - token ?l - song-library ?n - count ?m - count)
    :precondition (and (has-token spotify ?t) (listed ?l) (contains ?l ?s)
                       (release-known ?s) (released-after-2021 ?s)
                       (pending-removals ?n) (succ ?m ?n) (not (task-completed)))
    :effect (and (not (contains ?l ?s)) (not (pending-removals ?n)) (pending-removals ?m)))

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

  ; API: spotify.remove_song_from_playlist
  (:action spotify-remove-song-from-playlist
    :parameters (?p - playlist ?s - song ?t - token ?n - count ?m - count)
    :precondition (and (has-token spotify ?t) (listed ?p) (contains ?p ?s)
                       (release-known ?s) (released-after-2021 ?s)
                       (pending-removals ?n) (succ ?m ?n) (not (task-completed)))
    :effect (and (not (contains ?p ?s)) (not (pending-removals ?n)) (pending-removals ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (pending-removals n0) (not (task-completed)))
    :effect (task-completed))
)
