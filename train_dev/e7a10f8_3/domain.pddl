(define (domain appworld-e7a10f8-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token playlist item - object
    song minutes - item)
  (:constants spotify - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (library-listed)
    (in-library ?pl - playlist)
    (songs-listed ?pl - playlist)
    (in-playlist ?s - song ?pl - playlist)
    (next-item ?s - song ?x - item)
    (unlocked ?x - item)
    (duration-known ?s - song)
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
    :precondition (and (not (task-completed)) (profile-known) (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (library-listed))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (library-listed) (in-library ?pl))
    :effect (songs-listed ?pl))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?pl - playlist ?next - item)
    :precondition (and (not (task-completed)) (in-playlist ?s ?pl) (songs-listed ?pl) (unlocked ?s) (not (duration-known ?s)) (next-item ?s ?next))
    :effect (and (duration-known ?s) (unlocked ?next)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?m - minutes)
    :precondition (and (not (task-completed)) (unlocked ?m))
    :effect (task-completed))
)
