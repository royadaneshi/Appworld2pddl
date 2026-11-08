(define (domain appworld-425a494-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token genre - object)
  (:constants
    spotify supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (library-songs-known)
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

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (library-songs-known))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token ?g - genre)
    :precondition (and (has-token spotify ?t) (library-songs-known) (not (task-completed)))
    :effect (and (liked-songs-known) (found-most-liked-genre ?g)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?g - genre)
    :precondition (and (library-songs-known) (liked-songs-known) (found-most-liked-genre ?g) (not (task-completed)))
    :effect (task-completed))
)
