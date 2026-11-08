(define (domain appworld-fa327a6-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship order amount datetime txn-direction note - object)
  (:constants phone amazon venmo - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (contact-query ?p - person ?q - query)
    (contact-relationship ?p - person ?r - relationship)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (last-two-orders ?o1 - order ?o2 - order)
    (known-id ?o - order)
    (found-order-total ?o - order)
    (found-received-today ?p - person)
    (underpaid ?p - person ?amt - amount)
    (overpaid ?p - person ?amt - amount)
    (payment-request-created ?p - person ?amt - amount ?n - note)
    (money-sent ?p - person ?amt - amount ?n - note)
    (difference-settled ?p - person ?amt - amount ?n - note)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship ?p - person ?e - email)
    :precondition (and (not (task-completed)) (has-token phone ?t) (contact-query ?p ?q) (contact-relationship ?p ?r) (email-of ?p ?e))
    :effect (known-email ?p ?e))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?o1 - order ?o2 - order)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (last-two-orders ?o1 ?o2))
    :effect (and (known-id ?o1) (known-id ?o2)))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-id ?o))
    :effect (found-order-total ?o))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?dt - datetime ?d - txn-direction ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (known-email ?p ?e))
    :effect (found-received-today ?p))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?p - person ?o1 - order ?o2 - order)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (known-email ?p ?e) (last-two-orders ?o1 ?o2) (found-order-total ?o1) (found-order-total ?o2) (found-received-today ?p) (underpaid ?p ?amt) (not (difference-settled ?p ?amt ?n)))
    :effect (and (payment-request-created ?p ?amt ?n) (difference-settled ?p ?amt ?n)))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?p - person ?o1 - order ?o2 - order)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (known-email ?p ?e) (last-two-orders ?o1 ?o2) (found-order-total ?o1) (found-order-total ?o2) (found-received-today ?p) (overpaid ?p ?amt) (not (difference-settled ?p ?amt ?n)))
    :effect (and (money-sent ?p ?amt ?n) (difference-settled ?p ?amt ?n)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?amt - amount ?n - note)
    :precondition (and (not (task-completed)) (difference-settled ?p ?amt ?n))
    :effect (task-completed)))
