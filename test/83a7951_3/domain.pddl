(define (domain appworld-83a7951-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email transaction group amount file-path note direction datetime - object
  )
  (:constants venmo splitwise file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (supervisor-email ?e - email)
    (email-of ?p - person ?e - email)
    (venmo-payment-today ?tx - transaction ?p - person ?amt - amount)
    (expense-in-group ?p - person ?g - group)
    (receipt-path-for ?tx - transaction ?path - file-path)
    (venmo-transactions-listed)
    (splitwise-activity-listed)
    (receipt-downloaded ?tx - transaction ?path - file-path)
    (payment-recorded ?tx - transaction ?g - group ?d - note)
    (receipt-attached ?tx - transaction ?g - group)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t)
  )

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?since - datetime ?dir - direction)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (venmo-transactions-listed)
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t)
  )

  ; API: venmo.download_transaction_receipt
  (:action venmo-download-transaction-receipt
    :parameters (?tx - transaction ?t - token ?path - file-path ?ft - token)
    :precondition (and (has-token venmo ?t) (has-token file-system ?ft) (venmo-transactions-listed) (receipt-path-for ?tx ?path) (not (receipt-downloaded ?tx ?path)) (not (task-completed)))
    :effect (receipt-downloaded ?tx ?path)
  )

  ; API: splitwise.login
  (:action splitwise-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for splitwise ?u) (password-for splitwise ?pw) (token-for splitwise ?t) (not (has-token splitwise ?t)) (not (task-completed)))
    :effect (has-token splitwise ?t)
  )

  ; API: splitwise.show_activity
  (:action splitwise-show-activity
    :parameters (?t - token)
    :precondition (and (has-token splitwise ?t) (not (task-completed)))
    :effect (splitwise-activity-listed)
  )

  ; API: splitwise.record_payment
  (:action splitwise-record-payment
    :parameters (?payer - email ?receiver - email ?amt - amount ?t - token ?g - group ?d - note ?path - file-path ?ft - token ?p - person ?tx - transaction)
    :precondition (and (has-token splitwise ?t) (has-token file-system ?ft) (venmo-transactions-listed) (splitwise-activity-listed) (supervisor-email ?payer) (email-of ?p ?receiver) (venmo-payment-today ?tx ?p ?amt) (expense-in-group ?p ?g) (receipt-downloaded ?tx ?path) (not (payment-recorded ?tx ?g ?d)) (not (task-completed)))
    :effect (and (payment-recorded ?tx ?g ?d) (receipt-attached ?tx ?g))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?tx1 - transaction ?g1 - group ?tx2 - transaction ?g2 - group ?d - note)
    :precondition (and (payment-recorded ?tx1 ?g1 ?d) (receipt-attached ?tx1 ?g1) (payment-recorded ?tx2 ?g2 ?d) (receipt-attached ?tx2 ?g2) (not (= ?tx1 ?tx2)) (not (task-completed)))
    :effect (task-completed)
  )
)
