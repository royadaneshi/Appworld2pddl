(define (domain appworld-5800354-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token phone-number email relationship query
    text-message order product deliverer quantity amount - object)
  (:constants supervisor phone amazon venmo - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (contact-phone ?p - person ?n - phone-number)
    (contact-email ?p - person ?e - email)
    (known-phone ?p - person ?n - phone-number)
    (known-email ?p - person ?e - email)
    (message-from ?m - text-message ?p - person)
    (message-about ?m - text-message ?pr - product)
    (instruction-read ?m - text-message)
    (known-product ?pr - product)
    (product-query ?pr - product ?q - query)
    (order-contains ?o - order ?pr - product)
    (order-item-quantity ?o - order ?pr - product ?qty - quantity)
    (order-item-cost ?o - order ?pr - product ?amt - amount)
    (known-id ?x - object)
    (known-quantity ?o - order ?pr - product ?qty - quantity)
    (known-cost ?o - order ?pr - product ?amt - amount)
    (return-initiated ?o - order ?pr - product)
    (money-sent ?p - person ?amt - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?n - phone-number ?e - email)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r)
                       (contact-phone ?p ?n) (contact-email ?p ?e) (not (task-completed)))
    :effect (and (known-phone ?p ?n) (known-email ?p ?e)))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?m - text-message ?p - person ?pr - product)
    :precondition (and (has-token phone ?t) (known-phone ?p ?n) (message-from ?m ?p)
                       (message-about ?m ?pr) (not (task-completed)))
    :effect (and (instruction-read ?m) (known-product ?pr)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw)
                       (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?q - query ?o - order ?pr - product)
    :precondition (and (has-token amazon ?t) (known-product ?pr) (product-query ?pr ?q)
                       (order-contains ?o ?pr) (not (task-completed)))
    :effect (known-id ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?pr - product ?qty - quantity ?amt - amount)
    :precondition (and (has-token amazon ?t) (known-id ?o) (order-contains ?o ?pr)
                       (order-item-quantity ?o ?pr ?qty) (order-item-cost ?o ?pr ?amt)
                       (not (task-completed)))
    :effect (and (known-id ?pr) (known-quantity ?o ?pr ?qty) (known-cost ?o ?pr ?amt)))

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters (?d - deliverer)
    :precondition (not (task-completed))
    :effect (known-id ?d))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?pr - product ?d - deliverer ?qty - quantity ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?o) (known-id ?pr) (known-id ?d)
                       (known-quantity ?o ?pr ?qty) (not (return-initiated ?o ?pr))
                       (not (task-completed)))
    :effect (return-initiated ?o ?pr))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?p - person ?o - order ?pr - product)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (known-cost ?o ?pr ?amt)
                       (not (money-sent ?p ?amt)) (not (task-completed)))
    :effect (money-sent ?p ?amt))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?pr - product ?p - person ?amt - amount)
    :precondition (and (return-initiated ?o ?pr) (money-sent ?p ?amt) (not (task-completed)))
    :effect (task-completed))
)
