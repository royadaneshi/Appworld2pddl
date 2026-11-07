(define (domain appworld-50e1ac9-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token song album playlist answer - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (username-of ?p - person ?u - username)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-song-library ?s - song)
    (in-album-library ?al - album)
    (in-playlist-library ?pl - playlist)
    (in-album ?s - song ?al - album)
    (in-playlist ?s - song ?pl - playlist)
    (known-id-song ?s - song)
    (known-id-album ?al - album)
    (known-id-playlist ?pl - playlist)
    (song-details-known ?s - song)
    (answer-from ?ans - answer ?s1 - song ?s2 - song ?s3 - song)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known)))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (supervisor-username ?u) (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (in-song-library ?s) (not (task-completed)))
    :effect (and (known-id-song ?s)))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token ?al - album)
    :precondition (and (has-token spotify ?t) (in-album-library ?al) (not (task-completed)))
    :effect (and (known-id-album ?al)))

  ; API: spotify.show_album
  (:action spotify-show-album
    :parameters (?al - album ?s - song)
    :precondition (and (known-id-album ?al) (in-album ?s ?al) (not (task-completed)))
    :effect (and (known-id-song ?s)))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?pl - playlist)
    :precondition (and (has-token spotify ?t) (in-playlist-library ?pl) (not (task-completed)))
    :effect (and (known-id-playlist ?pl)))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (known-id-playlist ?pl) (in-playlist ?s ?pl) (not (task-completed)))
    :effect (and (known-id-song ?s)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song)
    :precondition (and (known-id-song ?s) (not (task-completed)))
    :effect (and (song-details-known ?s)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - answer ?s1 - song ?s2 - song ?s3 - song)
    :precondition (and (answer-from ?ans ?s1 ?s2 ?s3) (song-details-known ?s1) (song-details-known ?s2) (song-details-known ?s3) (not (task-completed)))
    :effect (and (task-completed)))
)
