(define (domain appworld-692c77d-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app email password token song review rating - object)
  (:constants
    spotify - app
    song-1 song-2 song-3 song-4 song-5 song-6 song-7 song-8 song-9 song-10 song-11 - song
    rating-5 - rating)
  (:predicates
    (profile-known)
    (passwords-known)
    (supervisor-email ?e - email)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (playlists-fetched)
    (liked-fetched)
    (in-playlist ?s - song)
    (liked ?s - song)
    (reviews-checked ?s - song)
    (has-existing-review ?s - song)
    (review-of ?rev - review ?s - song)
    (target-rating ?r - rating)
    (rated ?s - song ?r - rating)
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
    :parameters (?u - email ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (supervisor-email ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (playlists-fetched))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-fetched))

  ; API: spotify.show_song_reviews
  (:action spotify-show-song-reviews
    :parameters (?s - song ?e - email)
    :precondition (and (profile-known) (supervisor-email ?e) (playlists-fetched) (liked-fetched) (in-playlist ?s) (liked ?s) (not (task-completed)))
    :effect (reviews-checked ?s))

  ; API: spotify.review_song
  (:action spotify-review-song
    :parameters (?s - song ?r - rating ?t - token)
    :precondition (and (has-token spotify ?t) (reviews-checked ?s) (not (has-existing-review ?s)) (target-rating ?r) (not (task-completed)))
    :effect (and (rated ?s ?r) (has-existing-review ?s)))

  ; API: spotify.update_song_review
  (:action spotify-update-song-review
    :parameters (?rev - review ?t - token ?r - rating ?s - song)
    :precondition (and (has-token spotify ?t) (review-of ?rev ?s) (reviews-checked ?s) (target-rating ?r) (not (rated ?s ?r)) (not (task-completed)))
    :effect (rated ?s ?r))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (rated song-1 rating-5)
      (rated song-2 rating-5)
      (rated song-3 rating-5)
      (rated song-4 rating-5)
      (rated song-5 rating-5)
      (rated song-6 rating-5)
      (rated song-7 rating-5)
      (rated song-8 rating-5)
      (rated song-9 rating-5)
      (rated song-10 rating-5)
      (rated song-11 rating-5)
      (not (task-completed)))
    :effect (task-completed))
)
