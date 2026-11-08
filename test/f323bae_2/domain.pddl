(define (domain appworld-f323bae-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note content filepath dirpath - object
  )
  (:constants
    supervisor simple-note file-system - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-matches ?q - query ?n - note)
    (known-id ?n - note)
    (derives-csv ?n - note ?c - content)
    (content-ready ?c - content)
    (parent-dir ?f - filepath ?d - dirpath)
    (directory-created ?d - dirpath)
    (file-created ?f - filepath ?c - content)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t))
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-matches ?q ?n) (not (task-completed)))
    :effect (and (known-id ?n))
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?c - content)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (derives-csv ?n ?c) (not (task-completed)))
    :effect (and (content-ready ?c))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: file_system.create_directory
  (:action file-system-create-directory
    :parameters (?d - dirpath ?t - token)
    :precondition (and (has-token file-system ?t) (not (directory-created ?d)) (not (task-completed)))
    :effect (and (directory-created ?d))
  )

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?f - filepath ?t - token ?c - content ?d - dirpath)
    :precondition (and (has-token file-system ?t) (content-ready ?c) (parent-dir ?f ?d) (directory-created ?d) (not (file-created ?f ?c)) (not (task-completed)))
    :effect (and (file-created ?f ?c))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f - filepath ?c - content)
    :precondition (and (file-created ?f ?c) (not (task-completed)))
    :effect (and (task-completed))
  )
)
