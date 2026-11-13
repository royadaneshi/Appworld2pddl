(define (domain appworld-7d7fbf6-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token dirpath filepath flag - object
  )
  (:constants
    file-system - app
    spot-dir-1 spot-dir-2 spot-dir-3 spot-dir-4 - dirpath
    spot-tar-1 spot-tar-2 spot-tar-3 spot-tar-4 - filepath
  )
  (:predicates
    (passwords-known)
    (profile-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (is-true ?b - flag)
    (subdir-of ?d - dirpath ?p - dirpath)
    (tar-path-for ?d - dirpath ?f - filepath)
    (directory-listed ?p - dirpath)
    (compressed-to ?d - dirpath ?f - filepath)
    (directory-deleted ?d - dirpath)
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
      (passwords-known)
      (username-for file-system ?u)
      (password-for file-system ?pw)
      (not (has-token file-system ?t))
      (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?p - dirpath)
    :precondition (and
      (has-token file-system ?t)
      (not (task-completed)))
    :effect (and (directory-listed ?p))
  )

  ; API: file_system.compress_directory
  (:action file-system-compress-directory
    :parameters (?d - dirpath ?t - token ?f - filepath ?del - flag ?p - dirpath)
    :precondition (and
      (has-token file-system ?t)
      (is-true ?del)
      (subdir-of ?d ?p)
      (directory-listed ?p)
      (tar-path-for ?d ?f)
      (not (directory-deleted ?d))
      (not (task-completed)))
    :effect (and
      (compressed-to ?d ?f)
      (directory-deleted ?d))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (compressed-to spot-dir-1 spot-tar-1)
      (directory-deleted spot-dir-1)
      (compressed-to spot-dir-2 spot-tar-2)
      (directory-deleted spot-dir-2)
      (compressed-to spot-dir-3 spot-tar-3)
      (directory-deleted spot-dir-3)
      (compressed-to spot-dir-4 spot-tar-4)
      (directory-deleted spot-dir-4)
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
