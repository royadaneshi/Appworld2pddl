(define (domain appworld-c901732-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query album song - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (task-completed)
    (password-for ?a - app ?pw - password)
    (supervisor-username ?u - username)
    (has-token ?a - app ?t - token)
    (album-query ?q - query ?al - album)
    (album-found ?al - album)
    (song-in-album ?s - song ?al - album)
    (play-count-known ?s - song)
    (playing ?s - song))

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
    :precondition (and (profile-known) (passwords-known) (supervisor-username ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.search_albums
  (:action spotify-search-albums
    :parameters (?q - query ?al - album)
    :precondition (and (album-query ?q ?al) (not (task-completed)))
    :effect (album-found ?al))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?al - album)
    :precondition (and (album-found ?al) (song-in-album ?s ?al) (not (task-completed)))
    :effect (play-count-known ?s))

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (play-count-known ?s) (not (task-completed)))
    :effect (playing ?s))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (task-completed))
)
