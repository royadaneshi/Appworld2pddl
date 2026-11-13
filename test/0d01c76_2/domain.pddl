(define (domain appworld-0d01c76-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token directory-path file-path file note-title note-content - object
  )
  (:constants file-system simple-note - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-directory ?f - file ?d - directory-path)
    (path-of ?f - file ?p - file-path)
    (is-markdown ?f - file)
    (title-of ?f - file ?title - note-title)
    (content-of ?f - file ?c - note-content)
    (directory-listed ?d - directory-path)
    (known-content ?f - file)
    (imported ?f - file)
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
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory-path)
    :precondition (and (has-token file-system ?t) (not (task-completed)))
    :effect (and (directory-listed ?d))
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?p - file-path ?t - token ?f - file ?d - directory-path)
    :precondition (and (has-token file-system ?t) (path-of ?f ?p) (in-directory ?f ?d) (directory-listed ?d) (not (task-completed)))
    :effect (and (known-content ?f))
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app simple-note ?t) (credential-of-app simple-note ?pw) (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t))
  )

  ; API: simple_note.create_note
  (:action simple-note-create-note
    :parameters (?title - note-title ?content - note-content ?t - token ?f - file)
    :precondition (and (has-token simple-note ?t) (is-markdown ?f) (known-content ?f) (title-of ?f ?title) (content-of ?f ?content) (not (imported ?f)) (not (task-completed)))
    :effect (and (imported ?f))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f1 - file ?f2 - file ?f3 - file)
    :precondition (and (imported ?f1) (imported ?f2) (imported ?f3) (not (= ?f1 ?f2)) (not (= ?f1 ?f3)) (not (= ?f2 ?f3)) (not (task-completed)))
    :effect (and (task-completed))
  )
)
