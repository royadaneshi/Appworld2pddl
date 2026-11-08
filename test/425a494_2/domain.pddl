(define (domain appworld-425a494-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token album song genre - object)
  (:constants supervisor spotify - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-library ?al - album)
    (song-in-album ?s - song ?al - album)
    (song-genre ?s - song ?g - genre)
    (known-id ?x)
    (liked-songs-known)
    (found-least-liked-genre ?g - genre)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token ?al - album)
    :precondition (and (has-token spotify ?t) (in-library ?al) (not (task-completed)))
    :effect (known-id ?al))

  ; API: spotify.show_album
  (:action spotify-show-album
    :parameters (?al - album ?s - song)
    :precondition (and (known-id ?al) (song-in-album ?s ?al) (not (task-completed)))
    :effect (known-id ?s))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-songs-known))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?g - genre)
    :precondition (and (known-id ?s) (liked-songs-known) (song-genre ?s ?g) (not (task-completed)))
    :effect (found-least-liked-genre ?g))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?g - genre)
    :precondition (and (found-least-liked-genre ?g) (not (task-completed)))
    :effect (task-completed))
)
