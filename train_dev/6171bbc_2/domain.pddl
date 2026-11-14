(define (domain appworld-6171bbc-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token title playlist song - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (user-playlist ?p - playlist)
    (new-playlist ?p - playlist)
    (in-playlist ?s - song ?p - playlist)
    (highest-rated ?p - playlist ?s - song)
    (library-shown)
    (songs-known ?p - playlist)
    (rating-known ?s - song)
    (playlist-exists ?p - playlist)
    (playlist-titled ?p - playlist ?ti - title)
    (song-in-playlist ?s - song ?p - playlist)
    (added-highest-rated ?src - playlist ?dst - playlist)
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
    :precondition (and (not (task-completed)) (profile-known) (passwords-known)
                       (password-for spotify ?pw) (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (library-shown))

  ; API: spotify.create_playlist
  (:action spotify-create-playlist
    :parameters (?ti - title ?t - token ?pl - playlist)
    :precondition (and (not (task-completed)) (has-token spotify ?t)
                       (new-playlist ?pl) (not (playlist-exists ?pl)))
    :effect (and (playlist-exists ?pl) (playlist-titled ?pl ?ti)))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t)
                       (library-shown) (user-playlist ?p))
    :effect (songs-known ?p))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?p - playlist)
    :precondition (and (not (task-completed)) (in-playlist ?s ?p) (songs-known ?p))
    :effect (rating-known ?s))

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?pl - playlist ?s - song ?t - token ?src - playlist ?o - song)
    :precondition (and (not (task-completed)) (has-token spotify ?t)
                       (new-playlist ?pl) (playlist-exists ?pl)
                       (user-playlist ?src) (songs-known ?src)
                       (in-playlist ?s ?src) (in-playlist ?o ?src) (not (= ?s ?o))
                       (rating-known ?s) (rating-known ?o)
                       (highest-rated ?src ?s)
                       (not (added-highest-rated ?src ?pl)))
    :effect (and (song-in-playlist ?s ?pl) (added-highest-rated ?src ?pl)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (task-completed))
)
