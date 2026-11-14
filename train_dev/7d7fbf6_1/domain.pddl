(define (domain appworld-7d7fbf6-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token directory filepath flag - object
  )
  (:constants
    file-system - app
  )
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (supervisor-username ?u - username)
    (has-token ?a - app ?t - token)
    (listed ?p - directory)
    (sub-directory-of ?d - directory ?p - directory)
    (zip-target ?d - directory ?z - filepath)
    (is-true ?f - flag)
    (archived ?d - directory)
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

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (profile-known)
      (supervisor-username ?u)
      (passwords-known)
      (password-for file-system ?pw)
      (not (has-token file-system ?t))
      (not (task-completed))
    )
    :effect (and (has-token file-system ?t))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?p - directory)
    :precondition (and
      (has-token file-system ?t)
      (not (task-completed))
    )
    :effect (and (listed ?p))
  )

  ; API: file_system.compress_directory
  (:action file-system-compress-directory
    :parameters (?d - directory ?t - token ?z - filepath ?del - flag ?ow - flag ?p - directory)
    :precondition (and
      (has-token file-system ?t)
      (sub-directory-of ?d ?p)
      (listed ?p)
      (zip-target ?d ?z)
      (is-true ?del)
      (is-true ?ow)
      (not (archived ?d))
      (not (task-completed))
    )
    :effect (and (archived ?d))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (not (task-completed))
    )
    :effect (and (task-completed))
  )
)
