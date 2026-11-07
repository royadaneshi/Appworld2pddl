(define (domain appworld-ccb4494-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song - object)
  (:constants
    spotify supervisor - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (current-song-known)
    (queue-known)
    (in-queue ?s - song)
    (current-song ?s - song)
    (played-so-far ?s - song)
    (liked ?s - song)
    (task-completed))

  (:action supervisor-show-profile
    ; API: supervisor.show_profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action spotify-login
    ; API: spotify.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  (:action spotify-show-current-song
    ; API: spotify.show_current_song
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (current-song-known))

  (:action spotify-show-song-queue
    ; API: spotify.show_song_queue
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (queue-known))

  (:action spotify-like-song
    ; API: spotify.like_song
    :parameters (?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (queue-known) (current-song-known) (in-queue ?s) (played-so-far ?s) (not (liked ?s)) (not (task-completed)))
    :effect (liked ?s))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?s1 - song ?s2 - song ?s3 - song)
    :precondition (and (played-so-far ?s1) (played-so-far ?s2) (played-so-far ?s3) (not (= ?s1 ?s2)) (not (= ?s1 ?s3)) (not (= ?s2 ?s3)) (liked ?s1) (liked ?s2) (liked ?s3) (not (task-completed)))
    :effect (task-completed))
)
