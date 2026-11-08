(define (domain appworld-32616b5-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note group expense email email-list amount amount-list description - object
  )
  (:constants supervisor simple-note splitwise - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (notes-searched)
    (note-read ?n - note)
    (groups-listed)
    (note-describes ?n - note ?e - expense)
    (expense-in-group ?e - expense ?g - group)
    (expense-description ?e - expense ?d - description)
    (expense-amount ?e - expense ?amt - amount)
    (expense-payer ?e - expense ?p - email)
    (expense-debtors ?e - expense ?ds - email-list)
    (expense-debts ?e - expense ?as - amount-list)
    (expense-recorded ?e - expense)
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
    :precondition (and (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t)
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query)
    :precondition (and (has-token simple-note ?t) (not (task-completed)))
    :effect (notes-searched)
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (notes-searched) (not (note-read ?n)) (not (task-completed)))
    :effect (note-read ?n)
  )

  ; API: splitwise.login
  (:action splitwise-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for splitwise ?pw) (not (has-token splitwise ?t)) (not (task-completed)))
    :effect (has-token splitwise ?t)
  )

  ; API: splitwise.show_groups
  (:action splitwise-show-groups
    :parameters (?t - token)
    :precondition (and (has-token splitwise ?t) (not (task-completed)))
    :effect (groups-listed)
  )

  ; API: splitwise.record_expense
  (:action splitwise-record-expense
    :parameters (?desc - description ?amt - amount ?payer - email ?debtors - email-list ?t - token ?debts - amount-list ?g - group ?e - expense ?n - note)
    :precondition (and (has-token splitwise ?t) (groups-listed) (note-describes ?n ?e) (note-read ?n) (expense-description ?e ?desc) (expense-amount ?e ?amt) (expense-payer ?e ?payer) (expense-debtors ?e ?debtors) (expense-debts ?e ?debts) (expense-in-group ?e ?g) (not (expense-recorded ?e)) (not (task-completed)))
    :effect (expense-recorded ?e)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?e1 - expense ?e2 - expense ?e3 - expense)
    :precondition (and (expense-recorded ?e1) (expense-recorded ?e2) (expense-recorded ?e3) (not (= ?e1 ?e2)) (not (= ?e1 ?e3)) (not (= ?e2 ?e3)) (not (task-completed)))
    :effect (task-completed)
  )
)
