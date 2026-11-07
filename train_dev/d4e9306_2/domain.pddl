(define (domain appworld-d4e9306-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song album artist - object)
  ; artists of the liked songs/albums are domain constants so that
  ; supervisor-complete-task can state the full goal conjunction
  (:constants
    spotify - app
    artist-1 artist-2 artist-3 artist-4 - artist)
  (:predicates
    (profile-known)
    (passwords-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (liked-song ?s - song)
    (liked-album ?al - album)
    (song-artist ?s - song ?ar - artist)
    (album-artist ?al - album ?ar - artist)
    (liked-songs-listed)
    (liked-albums-listed)
    (known-id ?ar - artist)
    (following ?ar - artist)
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

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (liked-songs-listed)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?ar - artist)
    :precondition (and (liked-songs-listed) (liked-song ?s) (song-artist ?s ?ar) (not (task-completed)))
    :effect (and (known-id ?ar)))

  ; API: spotify.show_liked_albums
  (:action spotify-show-liked-albums
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (liked-albums-listed)))

  ; API: spotify.show_album
  (:action spotify-show-album
    :parameters (?al - album ?ar - artist)
    :precondition (and (liked-albums-listed) (liked-album ?al) (album-artist ?al ?ar) (not (task-completed)))
    :effect (and (known-id ?ar)))

  ; API: spotify.follow_artist
  (:action spotify-follow-artist
    :parameters (?ar - artist ?t - token)
    :precondition (and (has-token spotify ?t) (known-id ?ar) (not (following ?ar)) (not (task-completed)))
    :effect (and (following ?ar)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (following artist-1) (following artist-2) (following artist-3) (following artist-4) (not (task-completed)))
    :effect (and (task-completed))))
