(define (domain appworld-0d01c76-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token directory file title content note - object
  )
  (:constants
    file-system simple-note - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (in-directory ?f - file ?d - directory)
    (markdown ?f - file)
    (directory-listed ?d - directory)
    (file-read ?f - file)
    (title-of ?f - file ?ti - title)
    (content-of ?f - file ?c - content)
    (note-for ?n - note ?f - file)
    (note-created ?n - note)
    (task-completed)
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
      (passwords-known)
      (username-for file-system ?u)
      (password-for file-system ?pw)
      (token-for file-system ?t)
      (not (has-token file-system ?t))
      (not (task-completed))
    )
    :effect (and (has-token file-system ?t))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory)
    :precondition (and
      (has-token file-system ?t)
      (not (task-completed))
    )
    :effect (and (directory-listed ?d))
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file ?t - token ?d - directory)
    :precondition (and
      (has-token file-system ?t)
      (in-directory ?f ?d)
      (directory-listed ?d)
      (not (task-completed))
    )
    :effect (and (file-read ?f))
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (passwords-known)
      (username-for simple-note ?u)
      (password-for simple-note ?pw)
      (token-for simple-note ?t)
      (not (has-token simple-note ?t))
      (not (task-completed))
    )
    :effect (and (has-token simple-note ?t))
  )

  ; API: simple_note.create_note
  (:action simple-note-create-note
    :parameters (?ti - title ?c - content ?t - token ?n - note ?f - file)
    :precondition (and
      (has-token simple-note ?t)
      (markdown ?f)
      (file-read ?f)
      (title-of ?f ?ti)
      (content-of ?f ?c)
      (note-for ?n ?f)
      (not (note-created ?n))
      (not (task-completed))
    )
    :effect (and (note-created ?n))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n1 - note ?n2 - note)
    :precondition (and
      (note-created ?n1)
      (note-created ?n2)
      (not (= ?n1 ?n2))
      (not (task-completed))
    )
    :effect (and (task-completed))
  )
)
