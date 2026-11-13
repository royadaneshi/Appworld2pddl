(define (domain appworld-5800354-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship phone-number email
    message query order product deliverer quantity amount - object)
  (:constants supervisor phone amazon venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (contact-relationship ?p - person ?r - relationship)
    (phone-of ?p - person ?ph - phone-number)
    (email-of ?p - person ?e - email)
    (known-phone ?p - person ?ph - phone-number)
    (known-email ?p - person ?e - email)
    (message-from ?m - message ?p - person)
    (message-mentions ?m - message ?q - query)
    (message-read ?m - message)
    (order-matches ?o - order ?q - query)
    (order-contains ?o - order ?p - product)
    (item-quantity ?o - order ?p - product ?n - quantity)
    (order-cost ?o - order ?a - amount)
    (known-id ?x - object)
    (known-quantity ?o - order ?p - product ?n - quantity)
    (found-cost ?o - order ?a - amount)
    (return-initiated ?o - order ?p - product)
    (money-sent ?p - person ?a - amount))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?ph - phone-number ?e - email)
    :precondition (and (has-token phone ?t) (contact-relationship ?p ?r)
                       (phone-of ?p ?ph) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-phone ?p ?ph) (known-email ?p ?e)))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?ph - phone-number ?m - message ?p - person)
    :precondition (and (has-token phone ?t) (known-phone ?p ?ph) (message-from ?m ?p)
                       (not (task-completed)))
    :effect (message-read ?m))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw)
                       (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?q - query ?m - message ?o - order)
    :precondition (and (has-token amazon ?t) (message-read ?m) (message-mentions ?m ?q)
                       (order-matches ?o ?q) (not (task-completed)))
    :effect (known-id ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product ?n - quantity ?a - amount)
    :precondition (and (has-token amazon ?t) (known-id ?o) (order-contains ?o ?p)
                       (item-quantity ?o ?p ?n) (order-cost ?o ?a) (not (task-completed)))
    :effect (and (known-id ?p) (known-quantity ?o ?p ?n) (found-cost ?o ?a)))

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters (?d - deliverer)
    :precondition (not (task-completed))
    :effect (known-id ?d))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?p - product ?d - deliverer ?n - quantity ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?o) (known-id ?p) (known-id ?d)
                       (known-quantity ?o ?p ?n) (not (return-initiated ?o ?p))
                       (not (task-completed)))
    :effect (return-initiated ?o ?p))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?a - amount ?t - token ?p - person ?o - order)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (found-cost ?o ?a)
                       (not (money-sent ?p ?a)) (not (task-completed)))
    :effect (money-sent ?p ?a))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?r - person ?a - amount)
    :precondition (and (return-initiated ?o ?p) (money-sent ?r ?a) (not (task-completed)))
    :effect (task-completed))
)
