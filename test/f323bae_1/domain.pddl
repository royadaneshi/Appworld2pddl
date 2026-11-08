(define (domain appworld-f323bae-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note file-path file-content - object)
  (:constants
    simple-note file-system - app
    downloads-habit-tracker-csv - file-path
    habit-csv-content - file-content)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (query-finds ?q - query ?n - note)
    (known-id ?n - note)
    (note-read ?n - note)
    (content-for ?c - file-content ?n - note)
    (file-created ?f - file-path ?c - file-content)
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
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (query-finds ?q ?n) (not (task-completed)))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (note-read ?n))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?f - file-path ?t - token ?c - file-content ?n - note)
    :precondition (and (has-token file-system ?t) (note-read ?n) (content-for ?c ?n) (not (task-completed)))
    :effect (file-created ?f ?c))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (file-created downloads-habit-tracker-csv habit-csv-content) (not (task-completed)))
    :effect (task-completed)))
