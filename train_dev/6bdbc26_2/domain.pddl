(define (domain appworld-6bdbc26-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token song artist count - object)
  (:constants spotify - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (supervisor-username ?u - username)
    (song-artist ?s - song ?ar - artist)
    (artist-follower-count ?ar - artist ?c - count)
    (found-current-song ?s - song)
    (known-id ?ar - artist)
    (answer-known ?c - count)
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
    :parameters (?t - token ?s - song ?ar - artist)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (song-artist ?s ?ar))
    :effect (and (found-current-song ?s) (known-id ?ar)))

  ; API: spotify.show_artist
  (:action spotify-show-artist
    :parameters (?ar - artist ?c - count)
    :precondition (and (not (task-completed))
                       (known-id ?ar)
                       (artist-follower-count ?ar ?c))
    :effect (answer-known ?c))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - count)
    :precondition (and (not (task-completed))
                       (answer-known ?c))
    :effect (task-completed))
)
