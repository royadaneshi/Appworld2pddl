(define (domain appworld-32616b5-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query note trip-group expense-entry amount description - object
  )
  (:constants
    supervisor simple-note splitwise - app
    entry-1 entry-2 entry-3 entry-4 - expense-entry
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (note-matches ?n - note ?q - query)
    (known-id ?n - note)
    (note-read ?n - note)
    (groups-listed)
    (entry-in-note ?e - expense-entry ?n - note)
    (entry-group ?e - expense-entry ?g - trip-group)
    (entry-payer ?e - expense-entry ?p - person)
    (entry-debtor ?e - expense-entry ?p - person)
    (entry-amount ?e - expense-entry ?amt - amount)
    (entry-description ?e - expense-entry ?d - description)
    (member-of ?g - trip-group ?p - person)
    (email-of ?p - person ?em - email)
    (expense-recorded ?e - expense-entry)
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
    :precondition (and (not (task-completed)) (passwords-known)
                       (password-for simple-note ?pw) (token-for simple-note ?t)
                       (not (has-token simple-note ?t)))
    :effect (has-token simple-note ?t)
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (note-matches ?n ?q))
    :effect (known-id ?n)
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (known-id ?n))
    :effect (note-read ?n)
  )

  ; API: splitwise.login
  (:action splitwise-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
                       (password-for splitwise ?pw) (token-for splitwise ?t)
                       (not (has-token splitwise ?t)))
    :effect (has-token splitwise ?t)
  )

  ; API: splitwise.show_groups
  (:action splitwise-show-groups
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token splitwise ?t))
    :effect (groups-listed)
  )

  ; API: splitwise.record_expense
  (:action splitwise-record-expense
    :parameters (?d - description ?amt - amount ?pe - email ?de - email ?t - token ?g - trip-group
                 ?e - expense-entry ?n - note ?payer - person ?debtor - person)
    :precondition (and (not (task-completed)) (has-token splitwise ?t) (groups-listed)
                       (entry-in-note ?e ?n) (note-read ?n)
                       (entry-group ?e ?g)
                       (entry-description ?e ?d) (entry-amount ?e ?amt)
                       (entry-payer ?e ?payer) (entry-debtor ?e ?debtor)
                       (not (= ?payer ?debtor))
                       (member-of ?g ?payer) (member-of ?g ?debtor)
                       (email-of ?payer ?pe) (email-of ?debtor ?de)
                       (not (expense-recorded ?e)))
    :effect (expense-recorded ?e)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed))
                       (expense-recorded entry-1) (expense-recorded entry-2)
                       (expense-recorded entry-3) (expense-recorded entry-4))
    :effect (task-completed)
  )
)
