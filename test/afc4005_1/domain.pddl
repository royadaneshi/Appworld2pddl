(define (domain appworld-afc4005-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note duration - object
  )
  (:constants simple-note - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-matches ?n - note ?q - query)
    (known-id ?n - note)
    (answer-in ?n - note ?d - duration)
    (found-duration ?d - duration)
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
    :precondition (and (has-token simple-note ?t) (note-matches ?n ?q) (not (task-completed)))
    :effect (and (known-id ?n))
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?d - duration)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (answer-in ?n ?d) (not (task-completed)))
    :effect (and (found-duration ?d))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - duration)
    :precondition (and (found-duration ?d) (not (task-completed)))
    :effect (and (task-completed))
  )
)
