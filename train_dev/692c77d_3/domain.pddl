(define (domain appworld-692c77d-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person email password token song review rating - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (is-supervisor ?p - person)
    (has-email ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (in-album-library ?s - song)
    (liked ?s - song)
    (library-known)
    (liked-songs-known)
    (song-reviewed ?s - song)
    (has-review ?s - song ?r - review)
    (reviews-checked ?s - song)
    (target-rating ?rt - rating)
    (song-rated ?s - song ?rt - rating)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters (?p - person ?e - email)
    :precondition (and (is-supervisor ?p) (has-email ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (passwords-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - email ?pw - password ?t - token ?p - person)
    :precondition (and (passwords-known) (password-for spotify ?pw) (is-supervisor ?p) (known-email ?p ?u) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (library-known))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-songs-known))

  ; API: spotify.show_song_reviews
  (:action spotify-show-song-reviews
    :parameters (?s - song ?e - email ?p - person)
    :precondition (and (library-known) (liked-songs-known) (in-album-library ?s) (liked ?s) (is-supervisor ?p) (known-email ?p ?e) (not (task-completed)))
    :effect (reviews-checked ?s))

  ; API: spotify.review_song
  (:action spotify-review-song
    :parameters (?s - song ?rt - rating ?t - token)
    :precondition (and (has-token spotify ?t) (target-rating ?rt) (library-known) (liked-songs-known) (in-album-library ?s) (liked ?s) (reviews-checked ?s) (not (song-reviewed ?s)) (not (task-completed)))
    :effect (and (song-reviewed ?s) (song-rated ?s ?rt)))

  ; API: spotify.update_song_review
  (:action spotify-update-song-review
    :parameters (?r - review ?t - token ?rt - rating ?s - song)
    :precondition (and (has-token spotify ?t) (target-rating ?rt) (library-known) (liked-songs-known) (in-album-library ?s) (liked ?s) (reviews-checked ?s) (has-review ?s ?r) (not (task-completed)))
    :effect (song-rated ?s ?rt))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (task-completed))
)
