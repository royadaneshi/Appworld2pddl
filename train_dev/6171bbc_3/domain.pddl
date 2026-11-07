(define (domain appworld-6171bbc-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app username password token title playlist song - object)
  ; goal-referenced records are domain constants so supervisor-complete-task can name them
  (:constants spotify - app
              new-playlist - playlist
              top-song-1 top-song-2 - song)
  (:predicates
    (profile-known)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (owned-playlist ?pl - playlist)
    (library-listed)
    (songs-listed ?pl - playlist)
    (in-playlist ?s - song ?pl - playlist)
    (play-count-known ?s - song)
    (most-played-in ?s - song ?pl - playlist)
    (playlist-title ?pl - playlist ?ti - title)
    (created ?pl - playlist)
    (added ?s - song ?pl - playlist)
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

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t))
    :effect (and (library-listed)))

  ; API: spotify.create_playlist
  (:action spotify-create-playlist
    :parameters (?ti - title ?t - token ?pl - playlist)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (playlist-title ?pl ?ti)
                       (not (owned-playlist ?pl))
                       (not (created ?pl)))
    :effect (and (created ?pl)))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (library-listed)
                       (owned-playlist ?pl))
    :effect (and (songs-listed ?pl)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?pl - playlist)
    :precondition (and (not (task-completed))
                       (songs-listed ?pl)
                       (in-playlist ?s ?pl))
    :effect (and (play-count-known ?s)))

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?pl - playlist ?s - song ?t - token ?src - playlist ?other - song)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (created ?pl)
                       (songs-listed ?src)
                       (in-playlist ?s ?src)
                       (most-played-in ?s ?src)
                       (in-playlist ?other ?src)
                       (not (= ?s ?other))
                       (play-count-known ?s)
                       (play-count-known ?other)
                       (not (added ?s ?pl)))
    :effect (and (added ?s ?pl)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed))
                       (created new-playlist)
                       (added top-song-1 new-playlist)
                       (added top-song-2 new-playlist))
    :effect (and (task-completed)))
)
