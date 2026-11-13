(define (domain appworld-6b6ca61-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email amount description privacy file-path - object
  )
  (:constants
    file-system venmo splitwise - app
    owee-1 owee-2 owee-3 owee-4 owee-5 - person
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (csv-file ?f - file-path)
    (receipt-for ?p - person ?f - file-path)
    (person-email ?p - person ?e - email)
    (supervisor-email ?e - email)
    (owes ?p - person ?amt - amount ?d - description)
    (has-venmo-account ?p - person)
    (is-private ?pr - privacy)
    (directory-listed)
    (csv-read)
    (venmo-status-known ?p - person)
    (venmo-paid ?p - person)
    (splitwise-expense-recorded ?p - person)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)) (not (passwords-known)))
    :effect (passwords-known)
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (not (task-completed)) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)))
    :effect (has-token file-system ?t)
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token file-system ?t))
    :effect (directory-listed)
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file-path ?t - token)
    :precondition (and (not (task-completed)) (has-token file-system ?t) (directory-listed) (csv-file ?f))
    :effect (csv-read)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (not (task-completed)) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)))
    :effect (has-token venmo ?t)
  )

  ; API: venmo.search_users
  (:action venmo-search-users
    :parameters (?t - token ?e - email ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (csv-read) (person-email ?p ?e))
    :effect (venmo-status-known ?p)
  )

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?pr - privacy ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (csv-read) (person-email ?p ?e) (owes ?p ?amt ?d) (is-private ?pr) (venmo-status-known ?p) (has-venmo-account ?p) (not (venmo-paid ?p)))
    :effect (venmo-paid ?p)
  )

  ; API: splitwise.login
  (:action splitwise-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app splitwise ?t) (credential-of-app splitwise ?pw) (credential-of-app splitwise ?u) (not (task-completed)) (passwords-known) (username-for splitwise ?u) (password-for splitwise ?pw) (not (has-token splitwise ?t)))
    :effect (has-token splitwise ?t)
  )

  ; API: splitwise.record_expense
  (:action splitwise-record-expense
    :parameters (?d - description ?amt - amount ?payer - email ?debtor - email ?t - token ?receipt - file-path ?fst - token ?p - person)
    :precondition (and (not (task-completed)) (has-token splitwise ?t) (has-token file-system ?fst) (csv-read) (directory-listed) (owes ?p ?amt ?d) (person-email ?p ?payer) (supervisor-email ?debtor) (receipt-for ?p ?receipt) (venmo-status-known ?p) (not (has-venmo-account ?p)) (not (splitwise-expense-recorded ?p)))
    :effect (splitwise-expense-recorded ?p)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (venmo-paid owee-1)
      (venmo-paid owee-2)
      (splitwise-expense-recorded owee-3)
      (splitwise-expense-recorded owee-4)
      (splitwise-expense-recorded owee-5)
      (not (task-completed)))
    :effect (task-completed)
  )
)
