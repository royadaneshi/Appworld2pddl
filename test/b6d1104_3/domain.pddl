(define (domain appworld-b6d1104-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note month amount content direction datetime - object
  )
  (:constants
    supervisor simple-note venmo - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (query-for-note ?q - query ?n - note)
    (known-id ?n - note)
    (note-content-known ?n - note)
    (this-month ?m - month)
    (month-range ?m - month ?min - datetime ?max - datetime)
    (expense-direction ?d - direction)
    (expense-of ?m - month ?amt - amount)
    (expense-found ?m - month ?amt - amount)
    (content-with-entry ?c - content ?n - note ?m - month ?amt - amount)
    (note-updated ?n - note ?c - content)
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
    :precondition (and (has-token simple-note ?t) (query-for-note ?q ?n) (not (task-completed)))
    :effect (and (known-id ?n))
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (and (note-content-known ?n))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?d - direction ?min - datetime ?max - datetime ?m - month ?amt - amount)
    :precondition (and (has-token venmo ?t) (expense-direction ?d) (this-month ?m) (month-range ?m ?min ?max) (expense-of ?m ?amt) (not (task-completed)))
    :effect (and (expense-found ?m ?amt))
  )

  ; API: simple_note.update_note
  (:action simple-note-update-note
    :parameters (?n - note ?t - token ?c - content ?m - month ?amt - amount)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (note-content-known ?n) (expense-found ?m ?amt) (content-with-entry ?c ?n ?m ?amt) (not (note-updated ?n ?c)) (not (task-completed)))
    :effect (and (note-updated ?n ?c))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - note ?c - content)
    :precondition (and (note-updated ?n ?c) (not (task-completed)))
    :effect (and (task-completed))
  )
)
