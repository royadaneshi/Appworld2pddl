(define (domain appworld-0a9d82a-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query note streak-count - object)
  (:constants supervisor simple-note - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (habit-query ?q - query)
    (habit-note ?n - note)
    (answer-from-logs ?s - streak-count ?n1 - note ?n2 - note)
    (habit-notes-listed)
    (note-read ?n - note)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query)
    :precondition (and (has-token simple-note ?t) (habit-query ?q) (not (task-completed)))
    :effect (habit-notes-listed))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (habit-notes-listed) (habit-note ?n) (not (note-read ?n)) (not (task-completed)))
    :effect (note-read ?n))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?s - streak-count ?n1 - note ?n2 - note)
    :precondition (and (answer-from-logs ?s ?n1 ?n2) (note-read ?n1) (note-read ?n2) (not (task-completed)))
    :effect (task-completed)))
