(define (domain appworld-0d01c76-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token directory file title content - object
  )
  (:constants
    file-system simple-note - app
  )
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (file-in-directory ?f - file ?d - directory)
    (markdown-file ?f - file)
    (title-of ?f - file ?ti - title)
    (file-content ?f - file ?c - content)
    (directory-listed ?d - directory)
    (content-read ?f - file)
    (note-created ?ti - title ?c - content)
    (imported ?f - file)
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
      (not (has-token file-system ?t))
      (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory)
    :precondition (and
      (has-token file-system ?t)
      (not (task-completed)))
    :effect (and (directory-listed ?d))
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file ?t - token ?d - directory)
    :precondition (and
      (has-token file-system ?t)
      (file-in-directory ?f ?d)
      (directory-listed ?d)
      (not (task-completed)))
    :effect (and (content-read ?f))
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (passwords-known)
      (username-for simple-note ?u)
      (password-for simple-note ?pw)
      (not (has-token simple-note ?t))
      (not (task-completed)))
    :effect (and (has-token simple-note ?t))
  )

  ; API: simple_note.create_note
  (:action simple-note-create-note
    :parameters (?ti - title ?c - content ?t - token ?f - file)
    :precondition (and
      (has-token simple-note ?t)
      (markdown-file ?f)
      (content-read ?f)
      (title-of ?f ?ti)
      (file-content ?f ?c)
      (not (imported ?f))
      (not (task-completed)))
    :effect (and (note-created ?ti ?c) (imported ?f))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f1 - file ?f2 - file ?f3 - file)
    :precondition (and
      (imported ?f1)
      (imported ?f2)
      (imported ?f3)
      (not (= ?f1 ?f2))
      (not (= ?f1 ?f3))
      (not (= ?f2 ?f3))
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
