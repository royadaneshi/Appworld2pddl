(define (domain appworld-b6d1104-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token note query content amount direction datetime - object
  )
  (:constants venmo simple-note - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (sent-direction ?d - direction)
    (this-month-start ?dt - datetime)
    (this-month-end ?dt - datetime)
    (found-month-expense ?amt - amount)
    (note-matches ?q - query ?n - note)
    (known-id ?n - note)
    (note-read ?n - note)
    (content-with-entry ?c - content ?n - note ?amt - amount)
    (note-updated ?n - note ?amt - amount)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?min - datetime ?max - datetime ?d - direction ?amt - amount)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (this-month-start ?min) (this-month-end ?max) (sent-direction ?d))
    :effect (and (found-month-expense ?amt))
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (not (has-token simple-note ?t)))
    :effect (and (has-token simple-note ?t))
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (note-matches ?q ?n))
    :effect (and (known-id ?n))
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (known-id ?n))
    :effect (and (note-read ?n))
  )

  ; API: simple_note.update_note
  (:action simple-note-update-note
    :parameters (?n - note ?t - token ?c - content ?amt - amount)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (known-id ?n) (note-read ?n) (found-month-expense ?amt) (content-with-entry ?c ?n ?amt))
    :effect (and (note-updated ?n ?amt))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - note ?amt - amount)
    :precondition (and (not (task-completed)) (note-updated ?n ?amt))
    :effect (and (task-completed))
  )
)
