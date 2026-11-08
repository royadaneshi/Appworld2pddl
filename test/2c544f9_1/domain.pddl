(define (domain appworld-2c544f9-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query amount payment-card transaction - object)
  (:constants venmo supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (query-for ?p - person ?q - query)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (balance-checked)
    (known-id ?c - payment-card)
    (transaction-sent ?tx - transaction ?p - person ?amt - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token venmo ?t) (query-for ?p ?q) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e)))

  ; API: venmo.show_venmo_balance
  (:action venmo-show-venmo-balance
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (and (balance-checked)))

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (and (known-id ?c)))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?c - payment-card ?p - person ?tx - transaction)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (balance-checked) (known-id ?c) (not (transaction-sent ?tx ?p ?amt)) (not (task-completed)))
    :effect (and (transaction-sent ?tx ?p ?amt)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?tx - transaction ?p - person ?amt - amount)
    :precondition (and (transaction-sent ?tx ?p ?amt) (not (task-completed)))
    :effect (and (task-completed))))
