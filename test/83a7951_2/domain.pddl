(define (domain appworld-83a7951-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email amount transaction
    splitwise-group file-path description direction datetime - object
  )
  (:constants supervisor venmo file-system splitwise - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (supervisor-email ?e - email)
    (email-of ?p - person ?e - email)
    (venmo-paid-today ?x - transaction ?p - person ?amt - amount)
    (owed-in-group ?p - person ?g - splitwise-group ?amt - amount)
    (receipt-path-for ?x - transaction ?f - file-path)
    (payment-note ?d - description)
    (is-sent-direction ?dir - direction)
    (is-start-of-today ?dt - datetime)
    (transactions-listed)
    (expenses-listed)
    (receipt-downloaded ?x - transaction ?f - file-path)
    (payment-recorded ?x - transaction)
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
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: splitwise.login
  (:action splitwise-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app splitwise ?t) (credential-of-app splitwise ?pw) (credential-of-app splitwise ?u) (passwords-known) (username-for splitwise ?u) (password-for splitwise ?pw) (not (has-token splitwise ?t)) (not (task-completed)))
    :effect (and (has-token splitwise ?t))
  )

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?dt - datetime ?dir - direction)
    :precondition (and (has-token venmo ?t) (is-start-of-today ?dt) (is-sent-direction ?dir) (not (task-completed)))
    :effect (and (transactions-listed))
  )

  ; API: venmo.download_transaction_receipt
  (:action venmo-download-transaction-receipt
    :parameters (?x - transaction ?t - token ?f - file-path ?ft - token)
    :precondition (and (has-token venmo ?t) (has-token file-system ?ft) (transactions-listed) (receipt-path-for ?x ?f) (not (receipt-downloaded ?x ?f)) (not (task-completed)))
    :effect (and (receipt-downloaded ?x ?f))
  )

  ; API: splitwise.show_activity
  (:action splitwise-show-activity
    :parameters (?t - token)
    :precondition (and (has-token splitwise ?t) (not (task-completed)))
    :effect (and (expenses-listed))
  )

  ; API: splitwise.record_payment
  (:action splitwise-record-payment
    :parameters (?payer - email ?receiver - email ?amt - amount ?t - token ?g - splitwise-group ?d - description ?f - file-path ?ft - token ?x - transaction ?p - person)
    :precondition (and (has-token splitwise ?t) (has-token file-system ?ft) (transactions-listed) (expenses-listed) (supervisor-email ?payer) (email-of ?p ?receiver) (venmo-paid-today ?x ?p ?amt) (owed-in-group ?p ?g ?amt) (payment-note ?d) (receipt-downloaded ?x ?f) (not (payment-recorded ?x)) (not (task-completed)))
    :effect (and (payment-recorded ?x))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?x1 - transaction ?x2 - transaction)
    :precondition (and (payment-recorded ?x1) (payment-recorded ?x2) (not (= ?x1 ?x2)) (not (task-completed)))
    :effect (and (task-completed))
  )
)
