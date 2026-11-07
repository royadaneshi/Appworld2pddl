(define (domain appworld-6bdbc26-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song artist count - object
  )
  (:constants
    spotify - app
  )
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (supervisor-username ?u - username)
    (has-token ?a - app ?t - token)
    (playing ?s - song)
    (artist-of ?s - song ?ar - artist)
    (follower-count-of ?ar - artist ?c - count)
    (known-current-song ?s - song)
    (known-artist ?ar - artist)
    (found-follower-count ?ar - artist ?c - count)
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
      (profile-known)
      (passwords-known)
      (supervisor-username ?u)
      (password-for spotify ?pw)
      (not (has-token spotify ?t))
      (not (task-completed))
    )
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_current_song
  (:action spotify-show-current-song
    :parameters (?t - token ?s - song ?ar - artist)
    :precondition (and
      (has-token spotify ?t)
      (playing ?s)
      (artist-of ?s ?ar)
      (not (task-completed))
    )
    :effect (and (known-current-song ?s) (known-artist ?ar))
  )

  ; API: spotify.show_artist
  (:action spotify-show-artist
    :parameters (?ar - artist ?c - count)
    :precondition (and
      (known-artist ?ar)
      (follower-count-of ?ar ?c)
      (not (task-completed))
    )
    :effect (and (found-follower-count ?ar ?c))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - count ?ar - artist)
    :precondition (and
      (found-follower-count ?ar ?c)
      (not (task-completed))
    )
    :effect (and (task-completed))
  )
)
