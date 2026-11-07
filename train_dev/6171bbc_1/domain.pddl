(define (domain appworld-6171bbc-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token album song playlist title - object)
  (:constants spotify - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (library-listed)
    (in-library ?al - album)
    (album-songs-known ?al - album)
    (song-in-album ?s - song ?al - album)
    (most-played ?al - album ?s - song)
    (play-count-known ?s - song)
    (playlist-created ?pl - playlist)
    (playlist-titled ?pl - playlist ?ti - title)
    (song-added ?pl - playlist ?s - song)
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
    :precondition (and (not (task-completed))
                       (profile-known)
                       (passwords-known)
                       (username-for spotify ?u)
                       (password-for spotify ?pw)
                       (not (has-token spotify ?t)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t))
    :effect (and (library-listed)))

  ; API: spotify.create_playlist
  (:action spotify-create-playlist
    :parameters (?ti - title ?t - token ?pl - playlist)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (not (playlist-created ?pl)))
    :effect (and (playlist-created ?pl)
                 (playlist-titled ?pl ?ti)))

  ; API: spotify.show_album
  (:action spotify-show-album
    :parameters (?al - album)
    :precondition (and (not (task-completed))
                       (library-listed)
                       (in-library ?al))
    :effect (and (album-songs-known ?al)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?al - album)
    :precondition (and (not (task-completed))
                       (album-songs-known ?al)
                       (song-in-album ?s ?al))
    :effect (and (play-count-known ?s)))

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?pl - playlist ?s - song ?t - token ?al - album)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (playlist-created ?pl)
                       (song-in-album ?s ?al)
                       (most-played ?al ?s)
                       (play-count-known ?s)
                       (not (song-added ?pl ?s)))
    :effect (and (song-added ?pl ?s)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?pl - playlist ?ti - title ?s1 - song ?s2 - song)
    :precondition (and (not (task-completed))
                       (playlist-created ?pl)
                       (playlist-titled ?pl ?ti)
                       (song-added ?pl ?s1)
                       (song-added ?pl ?s2)
                       (not (= ?s1 ?s2)))
    :effect (and (task-completed)))
)
