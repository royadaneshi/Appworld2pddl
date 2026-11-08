(define (domain appworld-66b7899-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query amount order - object
  )
  (:constants
    supervisor amazon phone venmo - app
  )
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?o - order)
    (found-cost ?o - order ?amt - amount)
    (order-for ?o - order ?p - person)
    (query-for ?p - person ?q - query)
    (known-email ?p - person ?e - email)
    (request-sent ?p - person ?o - order)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?o))
  )

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?amt - amount)
    :precondition (and (has-token amazon ?t) (known-id ?o) (not (task-completed)))
    :effect (and (found-cost ?o ?amt))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (query-for ?p ?q) (not (task-completed)))
    :effect (and (known-email ?p ?e))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?p - person ?o - order)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (order-for ?o ?p) (found-cost ?o ?amt) (not (request-sent ?p ?o)) (not (task-completed)))
    :effect (and (request-sent ?p ?o))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?o - order)
    :precondition (and (request-sent ?p ?o) (not (task-completed)))
    :effect (and (task-completed))
  )
)
