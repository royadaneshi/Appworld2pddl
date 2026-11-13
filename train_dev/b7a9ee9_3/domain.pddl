(define (domain appworld-b7a9ee9-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token playlist song artist genre - object)
  (:constants
    spotify - app
    indie - genre
    artist-ethan-wallace artist-nova-harmony artist-noah-bennett - artist)
  (:predicates
    (passwords-known)
    (profile-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (library-listed)
    (playlist-shown ?p - playlist)
    (in-playlist ?p - playlist ?s - song)
    (song-inspected ?s - song)
    (song-genre ?s - song ?g - genre)
    (song-artist ?s - song ?ar - artist)
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

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (library-listed))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token)
    :precondition (and (has-token spotify ?t) (library-listed) (not (task-completed)))
    :effect (playlist-shown ?p))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?p - playlist)
    :precondition (and (playlist-shown ?p) (in-playlist ?p ?s) (not (task-completed)))
    :effect (song-inspected ?s))

  ; API: spotify.follow_artist
  (:action spotify-follow-artist
    :parameters (?ar - artist ?t - token ?s - song)
    :precondition (and (has-token spotify ?t) (song-inspected ?s) (song-genre ?s indie) (song-artist ?s ?ar) (not (following ?ar)) (not (task-completed)))
    :effect (following ?ar))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (following artist-ethan-wallace)
      (following artist-nova-harmony)
      (following artist-noah-bennett)
      (not (task-completed)))
    :effect (task-completed))
)
