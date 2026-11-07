(define (domain appworld-ccb4494-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song - object)
  (:constants
    spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (supervisor ?p - person)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (queue-first ?s - song)
    (queue-next ?s1 - song ?s2 - song)
    (current-song ?s - song)
    (played-so-far ?s - song)
    (current-song-known)
    (queue-known)
    (next-to-like ?s - song)
    (liked ?s - song)
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
    :precondition (and
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (supervisor-username ?u)
      (password-for spotify ?pw)
      (not (has-token spotify ?t)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_current_song
  (:action spotify-show-current-song
    :parameters (?t - token)
    :precondition (and
      (not (task-completed))
      (has-token spotify ?t))
    :effect (and (current-song-known)))

  ; API: spotify.show_song_queue
  (:action spotify-show-song-queue
    :parameters (?t - token ?first - song)
    :precondition (and
      (not (task-completed))
      (has-token spotify ?t)
      (queue-first ?first)
      (not (queue-known)))
    :effect (and (queue-known) (next-to-like ?first)))

  ; API: spotify.like_song
  (:action spotify-like-song
    :parameters (?s - song ?t - token ?next - song)
    :precondition (and
      (not (task-completed))
      (has-token spotify ?t)
      (current-song-known)
      (queue-known)
      (next-to-like ?s)
      (played-so-far ?s)
      (not (liked ?s))
      (queue-next ?s ?next))
    :effect (and
      (liked ?s)
      (not (next-to-like ?s))
      (next-to-like ?next)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - song)
    :precondition (and
      (not (task-completed))
      (current-song ?c)
      (liked ?c))
    :effect (and (task-completed))))
