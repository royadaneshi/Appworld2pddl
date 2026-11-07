(define (domain appworld-6c2c621-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token note file-path content - object)
  (:constants simple-note file-system - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (username-of ?p - person ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (notes-listed)
    (note-content ?n - note ?c - content)
    (note-file ?n - note ?p - file-path)
    (known-content ?n - note ?c - content)
    (file-created ?p - file-path)
    (exported ?n - note)
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

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token)
    :precondition (and (has-token simple-note ?t) (not (task-completed)))
    :effect (notes-listed))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?c - content)
    :precondition (and (notes-listed) (has-token simple-note ?t) (note-content ?n ?c) (not (task-completed)))
    :effect (known-content ?n ?c))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?p - file-path ?t - token ?c - content ?n - note)
    :precondition (and (has-token file-system ?t) (known-content ?n ?c) (note-file ?n ?p) (not (file-created ?p)) (not (task-completed)))
    :effect (and (file-created ?p) (exported ?n)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n1 - note ?n2 - note ?n3 - note)
    :precondition (and (exported ?n1) (exported ?n2) (exported ?n3) (not (= ?n1 ?n2)) (not (= ?n1 ?n3)) (not (= ?n2 ?n3)) (not (task-completed)))
    :effect (task-completed))
)
