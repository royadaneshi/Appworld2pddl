(define (domain appworld-50e1ac9-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token answer item - object
    song album playlist - item)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-song-library ?s - song)
    (in-album-library ?al - album)
    (in-playlist-library ?pl - playlist)
    (album-has-song ?al - album ?s - song)
    (playlist-has-song ?pl - playlist ?s - song)
    (known-id ?x - item)
    (song-details-known ?s - song)
    (song-library-listed)
    (album-library-listed)
    (playlist-library-listed)
    (answer-covers ?ans - answer ?s - song)
    (task-completed))

  (:action supervisor-show-profile
    ; API: supervisor.show_profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action spotify-login
    ; API: spotify.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  (:action spotify-show-song-library
    ; API: spotify.show_song_library
    :parameters (?t - token ?s - song)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (in-song-library ?s))
    :effect (and (song-library-listed) (known-id ?s)))

  (:action spotify-show-song
    ; API: spotify.show_song
    :parameters (?s - song)
    :precondition (and (not (task-completed)) (known-id ?s))
    :effect (song-details-known ?s))

  (:action spotify-show-album-library
    ; API: spotify.show_album_library
    :parameters (?t - token ?al - album)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (in-album-library ?al))
    :effect (and (album-library-listed) (known-id ?al)))

  (:action spotify-show-album
    ; API: spotify.show_album
    :parameters (?al - album ?s - song)
    :precondition (and (not (task-completed)) (known-id ?al) (album-has-song ?al ?s))
    :effect (known-id ?s))

  (:action spotify-show-playlist-library
    ; API: spotify.show_playlist_library
    :parameters (?t - token ?pl - playlist)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (in-playlist-library ?pl))
    :effect (and (playlist-library-listed) (known-id ?pl)))

  (:action spotify-show-playlist
    ; API: spotify.show_playlist
    :parameters (?pl - playlist ?t - token ?s - song)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (known-id ?pl) (playlist-has-song ?pl ?s))
    :effect (known-id ?s))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?ans - answer ?s1 - song ?s2 - song ?s3 - song)
    :precondition (and (not (task-completed)) (song-library-listed) (album-library-listed) (playlist-library-listed) (answer-covers ?ans ?s1) (answer-covers ?ans ?s2) (answer-covers ?ans ?s3) (not (= ?s1 ?s2)) (not (= ?s1 ?s3)) (not (= ?s2 ?s3)) (song-details-known ?s1) (song-details-known ?s2) (song-details-known ?s3))
    :effect (task-completed))
)
