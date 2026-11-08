(define (domain appworld-83a7951-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email amount note
    transaction group file-path direction datetime - object)
  (:constants venmo splitwise file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (task-completed)
    (supervisor-email ?e - email)
    (payment-note ?n - note)
    ; hidden world structure (discovered through lookups)
    (sent-today ?txn - transaction ?p - person)
    (txn-amount ?txn - transaction ?amt - amount)
    (person-email ?p - person ?e - email)
    (expense-group ?p - person ?g - group)
    (receipt-path-for ?txn - transaction ?f - file-path)
    ; knowledge gained by lookup APIs
    (transactions-listed)
    (groups-listed)
    (group-expenses-known ?g - group)
    (receipt-downloaded ?txn - transaction ?f - file-path)
    ; database changes
    (payment-recorded ?txn - transaction))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)) (not (passwords-known)))
    :effect (passwords-known))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
                       (password-for venmo ?pw) (token-for venmo ?t)
                       (not (has-token venmo ?t)))
    :effect (has-token venmo ?t))

  ; API: splitwise.login
  (:action splitwise-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
                       (password-for splitwise ?pw) (token-for splitwise ?t)
                       (not (has-token splitwise ?t)))
    :effect (has-token splitwise ?t))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
                       (password-for file-system ?pw) (token-for file-system ?t)
                       (not (has-token file-system ?t)))
    :effect (has-token file-system ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?since - datetime ?dir - direction)
    :precondition (and (not (task-completed)) (has-token venmo ?t)
                       (not (transactions-listed)))
    :effect (transactions-listed))

  ; API: venmo.download_transaction_receipt
  (:action venmo-download-transaction-receipt
    :parameters (?txn - transaction ?t - token ?f - file-path ?fst - token)
    :precondition (and (not (task-completed)) (has-token venmo ?t)
                       (has-token file-system ?fst) (transactions-listed)
                       (receipt-path-for ?txn ?f)
                       (not (receipt-downloaded ?txn ?f)))
    :effect (receipt-downloaded ?txn ?f))

  ; API: splitwise.show_groups
  (:action splitwise-show-groups
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token splitwise ?t)
                       (not (groups-listed)))
    :effect (groups-listed))

  ; API: splitwise.show_group_expenses
  (:action splitwise-show-group-expenses
    :parameters (?g - group ?t - token)
    :precondition (and (not (task-completed)) (has-token splitwise ?t)
                       (groups-listed) (not (group-expenses-known ?g)))
    :effect (group-expenses-known ?g))

  ; API: splitwise.record_payment
  (:action splitwise-record-payment
    :parameters (?payer - email ?receiver - email ?amt - amount ?t - token
                 ?g - group ?n - note ?f - file-path ?fst - token
                 ?p - person ?txn - transaction)
    :precondition (and (not (task-completed))
                       (has-token splitwise ?t) (has-token file-system ?fst)
                       (supervisor-email ?payer)
                       (transactions-listed)
                       (sent-today ?txn ?p)
                       (person-email ?p ?receiver)
                       (txn-amount ?txn ?amt)
                       (group-expenses-known ?g)
                       (expense-group ?p ?g)
                       (receipt-downloaded ?txn ?f)
                       (payment-note ?n)
                       (not (payment-recorded ?txn)))
    :effect (payment-recorded ?txn))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?txn1 - transaction ?txn2 - transaction)
    :precondition (and (not (task-completed)) (not (= ?txn1 ?txn2))
                       (payment-recorded ?txn1) (payment-recorded ?txn2))
    :effect (task-completed)))
