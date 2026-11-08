(define (domain appworld-5800354-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship query phone-number email message order product deliverer quantity amount - object)
  (:constants phone amazon venmo - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (has-relationship ?p - person ?r - relationship)
    (has-phone ?p - person ?n - phone-number)
    (has-email ?p - person ?e - email)
    (known-phone ?p - person ?n - phone-number)
    (known-email ?p - person ?e - email)
    (message-from ?m - message ?p - person)
    (message-mentions ?m - message ?pr - product)
    (known-return-product ?pr - product)
    (product-query ?pr - product ?q - query)
    (order-contains ?o - order ?pr - product)
    (known-order ?o - order)
    (order-item-quantity ?o - order ?pr - product ?qty - quantity)
    (order-item-cost ?o - order ?pr - product ?amt - amount)
    (known-order-item ?o - order ?pr - product ?qty - quantity)
    (known-cost ?o - order ?pr - product ?amt - amount)
    (known-deliverer ?d - deliverer)
    (return-initiated ?o - order ?pr - product)
    (transaction-sent ?p - person ?amt - amount))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?n - phone-number ?e - email)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (has-phone ?p ?n) (has-email ?p ?e) (not (task-completed)))
    :effect (and (known-phone ?p ?n) (known-email ?p ?e)))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person ?m - message ?pr - product)
    :precondition (and (has-token phone ?t) (known-phone ?p ?n) (message-from ?m ?p) (message-mentions ?m ?pr) (not (task-completed)))
    :effect (known-return-product ?pr))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?q - query ?pr - product ?o - order)
    :precondition (and (has-token amazon ?t) (known-return-product ?pr) (product-query ?pr ?q) (order-contains ?o ?pr) (not (task-completed)))
    :effect (known-order ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?pr - product ?qty - quantity ?amt - amount)
    :precondition (and (has-token amazon ?t) (known-order ?o) (order-contains ?o ?pr) (order-item-quantity ?o ?pr ?qty) (order-item-cost ?o ?pr ?amt) (not (task-completed)))
    :effect (and (known-order-item ?o ?pr ?qty) (known-cost ?o ?pr ?amt)))

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters (?d - deliverer)
    :precondition (not (task-completed))
    :effect (known-deliverer ?d))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?pr - product ?d - deliverer ?qty - quantity ?t - token)
    :precondition (and (has-token amazon ?t) (known-return-product ?pr) (known-order-item ?o ?pr ?qty) (known-deliverer ?d) (not (return-initiated ?o ?pr)) (not (task-completed)))
    :effect (return-initiated ?o ?pr))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?p - person ?o - order ?pr - product)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (known-return-product ?pr) (known-cost ?o ?pr ?amt) (not (transaction-sent ?p ?amt)) (not (task-completed)))
    :effect (transaction-sent ?p ?amt))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?pr - product ?p - person ?amt - amount)
    :precondition (and (return-initiated ?o ?pr) (transaction-sent ?p ?amt) (not (task-completed)))
    :effect (task-completed))
)
