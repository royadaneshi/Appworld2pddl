(define (domain appworld-e3d6c94-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song playlist title - object
  )
  (:constants spotify phone - app)
  (:predicates
    (supervisor ?p - person)
    (profile-known)
    (passwords-known)
    (datetime-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (recommendations-known)
    (recommended ?s - song)
    (song-details-known ?s - song)
    (genre-rnb ?s - song)
    (released-this-year ?s - song)
    (playlist-title ?p - playlist ?ti - title)
    (playlist-created ?p - playlist)
    (in-playlist ?p - playlist ?s - song)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known))
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (supervisor-username ?u)
      (password-for spotify ?pw)
      (not (has-token spotify ?t))
    )
    :effect (and (has-token spotify ?t))
  )

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (datetime-known))
  )

  ; API: spotify.show_recommendations
  (:action spotify-show-recommendations
    :parameters (?t - token)
    :precondition (and
      (not (task-completed))
      (has-token spotify ?t)
    )
    :effect (and (recommendations-known))
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song)
    :precondition (and
      (not (task-completed))
      (recommendations-known)
      (recommended ?s)
    )
    :effect (and (song-details-known ?s))
  )

  ; API: spotify.create_playlist
  (:action spotify-create-playlist
    :parameters (?ti - title ?t - token ?p - playlist)
    :precondition (and
      (not (task-completed))
      (has-token spotify ?t)
      (playlist-title ?p ?ti)
      (not (playlist-created ?p))
    )
    :effect (and (playlist-created ?p))
  )

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?p - playlist ?s - song ?t - token)
    :precondition (and
      (not (task-completed))
      (has-token spotify ?t)
      (playlist-created ?p)
      (datetime-known)
      (recommended ?s)
      (song-details-known ?s)
      (genre-rnb ?s)
      (released-this-year ?s)
      (not (in-playlist ?p ?s))
    )
    :effect (and (in-playlist ?p ?s))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - playlist ?s1 - song ?s2 - song)
    :precondition (and
      (not (task-completed))
      (not (= ?s1 ?s2))
      (playlist-created ?p)
      (in-playlist ?p ?s1)
      (in-playlist ?p ?s2)
    )
    :effect (and (task-completed))
  )
)
