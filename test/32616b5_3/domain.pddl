(define (domain appworld-32616b5-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person note splitwise-group expense username password token query email description amount email-list amount-list - object)
  (:constants
    simple-note splitwise - app
    expense-a1-1 expense-a1-2 expense-a1-3 expense-a1-4 expense-a1-5 expense-a1-6 expense-a1-7 expense-a1-8 expense-a1-9 expense-a1-10 expense-a1-11 expense-a1-12 expense-a1-13 expense-a1-14 expense-a1-15 expense-a1-16 - expense)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?n - note)
    (known-id ?n - note)
    (note-read ?n - note)
    (described-in ?e - expense ?n - note)
    (groups-listed)
    (expense-description ?e - expense ?d - description)
    (expense-amount ?e - expense ?amt - amount)
    (expense-payer ?e - expense ?p - email)
    (expense-debtors ?e - expense ?ds - email-list)
    (expense-debt-amounts ?e - expense ?da - amount-list)
    (expense-group ?e - expense ?g - splitwise-group)
    (expense-recorded ?e - expense)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (token-for simple-note ?t) (not (has-token simple-note ?t)))
    :effect (and (has-token simple-note ?t)))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (query-for ?q ?n) (not (known-id ?n)))
    :effect (and (known-id ?n)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (known-id ?n) (not (note-read ?n)))
    :effect (and (note-read ?n)))

  ; API: splitwise.login
  (:action splitwise-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for splitwise ?u) (password-for splitwise ?pw) (token-for splitwise ?t) (not (has-token splitwise ?t)))
    :effect (and (has-token splitwise ?t)))

  ; API: splitwise.show_groups
  (:action splitwise-show-groups
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token splitwise ?t) (not (groups-listed)))
    :effect (and (groups-listed)))

  ; API: splitwise.record_expense
  (:action splitwise-record-expense
    :parameters (?d - description ?amt - amount ?payer - email ?debtors - email-list ?t - token ?debts - amount-list ?g - splitwise-group ?e - expense ?n - note)
    :precondition (and (not (task-completed)) (has-token splitwise ?t) (groups-listed) (described-in ?e ?n) (note-read ?n) (expense-description ?e ?d) (expense-amount ?e ?amt) (expense-payer ?e ?payer) (expense-debtors ?e ?debtors) (expense-debt-amounts ?e ?debts) (expense-group ?e ?g) (not (expense-recorded ?e)))
    :effect (and (expense-recorded ?e)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (expense-recorded expense-a1-1)
      (expense-recorded expense-a1-2)
      (expense-recorded expense-a1-3)
      (expense-recorded expense-a1-4)
      (expense-recorded expense-a1-5)
      (expense-recorded expense-a1-6)
      (expense-recorded expense-a1-7)
      (expense-recorded expense-a1-8)
      (expense-recorded expense-a1-9)
      (expense-recorded expense-a1-10)
      (expense-recorded expense-a1-11)
      (expense-recorded expense-a1-12)
      (expense-recorded expense-a1-13)
      (expense-recorded expense-a1-14)
      (expense-recorded expense-a1-15)
      (expense-recorded expense-a1-16)
      (not (task-completed)))
    :effect (and (task-completed)))
)
