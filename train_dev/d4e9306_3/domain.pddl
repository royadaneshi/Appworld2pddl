(define (domain appworld-d4e9306-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song album artist - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
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

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-songs-listed))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?ar - artist)
    :precondition (and (liked-songs-listed) (liked-song ?s) (song-artist ?s ?ar) (not (task-completed)))
    :effect (known-id ?ar))

  ; API: spotify.show_liked_albums
  (:action spotify-show-liked-albums
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-albums-listed))

  ; API: spotify.show_album
  (:action spotify-show-album
    :parameters (?al - album ?ar - artist)
    :precondition (and (liked-albums-listed) (liked-album ?al) (album-artist ?al ?ar) (not (task-completed)))
    :effect (known-id ?ar))

  ; API: spotify.follow_artist
  (:action spotify-follow-artist
    :parameters (?ar - artist ?t - token)
    :precondition (and (has-token spotify ?t) (known-id ?ar) (not (following ?ar)) (not (task-completed)))
    :effect (following ?ar))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?a1 ?a2 ?a3 - artist)
    :precondition (and (following ?a1) (following ?a2) (following ?a3) (not (= ?a1 ?a2)) (not (= ?a1 ?a3)) (not (= ?a2 ?a3)) (not (task-completed)))
    :effect (task-completed))
)
