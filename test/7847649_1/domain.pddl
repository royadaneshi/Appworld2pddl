(define (domain appworld-7847649-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note count - object)
  (:constants simple-note - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?n - note)
    (known-id ?n - note)
    (answer-for ?n - note ?c - count)
    (found-completed-count ?c - count)
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
    :precondition (and (has-token simple-note ?t) (query-for ?q ?n) (not (task-completed)))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?c - count)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (answer-for ?n ?c) (not (task-completed)))
    :effect (found-completed-count ?c))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - count)
    :precondition (and (found-completed-count ?c) (not (task-completed)))
    :effect (task-completed))
)
