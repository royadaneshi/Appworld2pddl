(define (domain appworld-ccb4494-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song - object)
  (:constants
    spotify - app
    song-55 song-30 song-242 song-179 song-111 song-322 - song)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (supervisor-username ?u - username)
    (has-token ?a - app ?t - token)
    (current-song-known)
    (queue-known)
    (played-so-far ?s - song)
    (liked ?s - song)
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
    :precondition (and (not (task-completed))
                       (profile-known)
                       (supervisor-username ?u)
                       (passwords-known)
                       (password-for spotify ?pw)
                       (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_current_song
  (:action spotify-show-current-song
    :parameters (?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t))
    :effect (current-song-known))

  ; API: spotify.show_song_queue
  (:action spotify-show-song-queue
    :parameters (?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t))
    :effect (queue-known))

  ; API: spotify.like_song
  (:action spotify-like-song
    :parameters (?s - song ?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (current-song-known)
                       (queue-known)
                       (played-so-far ?s)
                       (not (liked ?s)))
    :effect (liked ?s))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (liked song-55)
      (liked song-30)
      (liked song-242)
      (liked song-179)
      (liked song-111)
      (liked song-322)
      (not (task-completed)))
    :effect (task-completed))
)
