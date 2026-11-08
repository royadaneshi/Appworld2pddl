(define (domain appworld-59fae45-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token playlist genre title - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (library-listed)
    (in-library ?p - playlist)
    (genre-slot ?p - playlist ?g - genre)
    (found-most-common-genre ?p - playlist ?g - genre)
    (derived-title ?p - playlist ?g - genre ?ti - title)
    (title-updated ?p - playlist ?ti - title)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)) (not (passwords-known)))
    :effect (passwords-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (not (library-listed)))
    :effect (library-listed))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token ?g - genre)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (library-listed) (in-library ?p) (genre-slot ?p ?g) (not (found-most-common-genre ?p ?g)))
    :effect (found-most-common-genre ?p ?g))

  ; API: spotify.update_playlist
  (:action spotify-update-playlist
    :parameters (?p - playlist ?t - token ?ti - title ?g - genre)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (in-library ?p) (found-most-common-genre ?p ?g) (derived-title ?p ?g ?ti) (not (title-updated ?p ?ti)))
    :effect (title-updated ?p ?ti))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - playlist ?ti1 - title ?p2 - playlist ?ti2 - title)
    :precondition (and (not (task-completed)) (not (= ?p1 ?p2)) (title-updated ?p1 ?ti1) (title-updated ?p2 ?ti2))
    :effect (task-completed))
)
