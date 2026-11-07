(define (domain appworld-e3d6c94-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token - object
    song playlist title genre year - object)
  (:constants spotify phone - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-date-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (recommendations-listed)
    (is-recommended ?s - song)
    (song-details-known ?s - song)
    (song-genre ?s - song ?g - genre)
    (release-year ?s - song ?y - year)
    (target-genre ?g - genre)
    (current-year ?y - year)
    (playlist-created ?pl - playlist)
    (playlist-title ?pl - playlist ?ti - title)
    (in-playlist ?pl - playlist ?s - song)
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

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (not (task-completed))
    :effect (current-date-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed))
                       (profile-known)
                       (passwords-known)
                       (username-for spotify ?u)
                       (password-for spotify ?pw)
                       (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_recommendations
  (:action spotify-show-recommendations
    :parameters (?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t))
    :effect (recommendations-listed))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song)
    :precondition (and (not (task-completed))
                       (recommendations-listed)
                       (is-recommended ?s))
    :effect (song-details-known ?s))

  ; API: spotify.create_playlist
  (:action spotify-create-playlist
    :parameters (?ti - title ?t - token ?pl - playlist)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (not (playlist-created ?pl)))
    :effect (and (playlist-created ?pl)
                 (playlist-title ?pl ?ti)))

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?pl - playlist ?s - song ?t - token ?g - genre ?y - year)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (playlist-created ?pl)
                       (song-details-known ?s)
                       (song-genre ?s ?g)
                       (target-genre ?g)
                       (current-date-known)
                       (release-year ?s ?y)
                       (current-year ?y)
                       (not (in-playlist ?pl ?s)))
    :effect (in-playlist ?pl ?s))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?pl - playlist ?ti - title ?s1 - song ?s2 - song)
    :precondition (and (not (task-completed))
                       (playlist-created ?pl)
                       (playlist-title ?pl ?ti)
                       (in-playlist ?pl ?s1)
                       (in-playlist ?pl ?s2)
                       (not (= ?s1 ?s2)))
    :effect (task-completed))
)
