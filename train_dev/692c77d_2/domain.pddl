(define (domain appworld-692c77d-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song review rating - object
    email - username)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (supervisor-email ?u - username)
    (in-library ?s - song)
    (liked ?s - song)
    (library-listed)
    (liked-listed)
    (unreviewed ?s - song)
    (has-review ?s - song ?r - review)
    (reviews-checked ?s - song)
    (target-rating ?g - rating)
    (rated-one ?s - song)
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
    :precondition (and (passwords-known) (profile-known) (supervisor-email ?u)
                       (password-for spotify ?pw) (not (has-token spotify ?t))
                       (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (library-listed))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-listed))

  ; API: spotify.show_song_reviews
  (:action spotify-show-song-reviews
    :parameters (?s - song ?e - email)
    :precondition (and (library-listed) (liked-listed) (in-library ?s) (not (liked ?s))
                       (profile-known) (supervisor-email ?e) (not (task-completed)))
    :effect (reviews-checked ?s))

  ; API: spotify.update_song_review
  (:action spotify-update-song-review
    :parameters (?r - review ?t - token ?g - rating ?s - song)
    :precondition (and (has-token spotify ?t) (has-review ?s ?r) (reviews-checked ?s)
                       (target-rating ?g) (not (rated-one ?s)) (not (task-completed)))
    :effect (rated-one ?s))

  ; API: spotify.review_song
  (:action spotify-review-song
    :parameters (?s - song ?g - rating ?t - token)
    :precondition (and (has-token spotify ?t) (unreviewed ?s) (reviews-checked ?s)
                       (target-rating ?g) (not (rated-one ?s)) (not (task-completed)))
    :effect (rated-one ?s))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (task-completed)))
