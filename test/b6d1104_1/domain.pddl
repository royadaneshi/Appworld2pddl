(define (domain appworld-b6d1104-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note content direction datetime month amount - object
  )
  (:constants simple-note venmo - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-matches ?n - note ?q - query)
    (known-id ?n - note)
    (found-content ?n - note)
    (this-month ?m - month)
    (month-range ?m - month ?min - datetime ?max - datetime)
    (outgoing ?d - direction)
    (found-expense ?m - month ?a - amount)
    (content-with-entry ?c - content ?n - note ?m - month ?a - amount)
    (note-updated ?n - note ?m - month ?a - amount)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t)
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-matches ?n ?q) (not (task-completed)))
    :effect (known-id ?n)
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (found-content ?n)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t)
  )

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?min - datetime ?max - datetime ?d - direction ?m - month ?a - amount)
    :precondition (and (has-token venmo ?t) (this-month ?m) (month-range ?m ?min ?max) (outgoing ?d) (not (task-completed)))
    :effect (found-expense ?m ?a)
  )

  ; API: simple_note.update_note
  (:action simple-note-update-note
    :parameters (?n - note ?t - token ?c - content ?m - month ?a - amount)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (found-content ?n) (this-month ?m) (found-expense ?m ?a) (content-with-entry ?c ?n ?m ?a) (not (task-completed)))
    :effect (note-updated ?n ?m ?a)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - note ?m - month ?a - amount)
    :precondition (and (note-updated ?n ?m ?a) (this-month ?m) (not (task-completed)))
    :effect (task-completed)
  )
)
