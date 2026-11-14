(define (domain appworld-e3d6c94-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token title song playlist - object)
  (:constants spotify phone supervisor - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-date-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (recommendations-listed)
    (recommended ?s - song)
    (song-details-known ?s - song)
    (genre-rnb ?s - song)
    (released-recently ?s - song)
    (playlist-created ?p - playlist)
    (playlist-titled ?p - playlist ?ti - title)
    (song-in-playlist ?s - song ?p - playlist)
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
    :precondition (and (profile-known) (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (current-date-known)))

  ; API: spotify.show_recommendations
  (:action spotify-show-recommendations
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (recommendations-listed)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song)
    :precondition (and (recommendations-listed) (recommended ?s) (not (task-completed)))
    :effect (and (song-details-known ?s)))

  ; API: spotify.create_playlist
  (:action spotify-create-playlist
    :parameters (?ti - title ?t - token ?p - playlist)
    :precondition (and (has-token spotify ?t) (not (playlist-created ?p)) (not (task-completed)))
    :effect (and (playlist-created ?p) (playlist-titled ?p ?ti)))

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?p - playlist ?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (playlist-created ?p) (song-details-known ?s) (current-date-known) (genre-rnb ?s) (released-recently ?s) (not (song-in-playlist ?s ?p)) (not (task-completed)))
    :effect (and (song-in-playlist ?s ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (task-completed)))
)
