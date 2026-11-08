(define (domain appworld-fa327a6-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email order count amount note - object)
  (:constants supervisor phone amazon venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (search-query-for ?p - person ?q - query)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (orders-listed)
    (recent-order ?o - order)
    (found-order-total ?o - order)
    (orders-checked ?c - count)
    (next-count ?c1 - count ?c2 - count)
    (required-order-count ?c - count)
    (found-received-amount ?p - person)
    (difference-amount ?p - person ?amt - amount)
    (adjustment-note ?n - note)
    (underpaid ?p - person)
    (overpaid ?p - person)
    (payment-request-created ?p - person ?amt - amount ?n - note)
    (transaction-created ?p - person ?amt - amount ?n - note)
    (difference-settled ?p - person ?amt - amount ?n - note)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (not (task-completed)) (has-token phone ?t) (search-query-for ?p ?q) (email-of ?p ?e))
    :effect (and (known-email ?p ?e)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (and (orders-listed)))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?c - count ?c2 - count)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (orders-listed) (recent-order ?o) (not (found-order-total ?o)) (orders-checked ?c) (next-count ?c ?c2))
    :effect (and (found-order-total ?o) (not (orders-checked ?c)) (orders-checked ?c2)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (known-email ?p ?e))
    :effect (and (found-received-amount ?p)))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?p - person ?c - count)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (known-email ?p ?e) (found-received-amount ?p) (orders-checked ?c) (required-order-count ?c) (difference-amount ?p ?amt) (adjustment-note ?n) (underpaid ?p) (not (difference-settled ?p ?amt ?n)))
    :effect (and (payment-request-created ?p ?amt ?n) (difference-settled ?p ?amt ?n)))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?p - person ?c - count)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (known-email ?p ?e) (found-received-amount ?p) (orders-checked ?c) (required-order-count ?c) (difference-amount ?p ?amt) (adjustment-note ?n) (overpaid ?p) (not (difference-settled ?p ?amt ?n)))
    :effect (and (transaction-created ?p ?amt ?n) (difference-settled ?p ?amt ?n)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?amt - amount ?n - note)
    :precondition (and (not (task-completed)) (difference-settled ?p ?amt ?n))
    :effect (and (task-completed))))
