(define (domain appworld-d6d8cb6-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query - object
    order product deliverer quantity - object
    email-thread email email-address - object)
  (:constants supervisor amazon gmail phone - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (known-id ?x - object)
    (order-matches-query ?o - order ?q - query)
    (order-contains ?o - order ?p - product)
    (return-initiated ?o - order ?p - product ?d - deliverer ?qty - quantity)
    (return-confirmation-sent ?o - order)
    (confirmation-thread-of ?o - order ?th - email-thread)
    (thread-matches-query ?th - email-thread ?q - query)
    (email-in-thread ?e - email ?th - email-thread)
    (contact-matches-query ?p - person ?q - query)
    (email-address-of ?p - person ?e - email-address)
    (known-email ?p - person ?e - email-address)
    (forwarded ?e - email ?addr - email-address))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw)
                       (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?q - query ?o - order)
    :precondition (and (has-token amazon ?t) (order-matches-query ?o ?q) (not (task-completed)))
    :effect (and (known-id ?o)))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-id ?o) (order-contains ?o ?p) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters (?d - deliverer)
    :precondition (and (not (task-completed)))
    :effect (and (known-id ?d)))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?p - product ?d - deliverer ?qty - quantity ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?o) (known-id ?p) (known-id ?d)
                       (order-contains ?o ?p)
                       (not (return-initiated ?o ?p ?d ?qty)) (not (task-completed)))
    :effect (and (return-initiated ?o ?p ?d ?qty) (return-confirmation-sent ?o)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email-address)
    :precondition (and (has-token phone ?t) (contact-matches-query ?p ?q) (email-address-of ?p ?e)
                       (not (task-completed)))
    :effect (and (known-email ?p ?e)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw)
                       (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t)))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread ?o - order)
    :precondition (and (has-token gmail ?t) (return-confirmation-sent ?o) (confirmation-thread-of ?o ?th)
                       (thread-matches-query ?th ?q) (not (task-completed)))
    :effect (and (known-id ?th)))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?e - email)
    :precondition (and (has-token gmail ?t) (known-id ?th) (email-in-thread ?e ?th) (not (task-completed)))
    :effect (and (known-id ?e)))

  ; API: gmail.forward_email_from_thread
  (:action gmail-forward-email-from-thread
    :parameters (?th - email-thread ?e - email ?addr - email-address ?t - token ?p - person)
    :precondition (and (has-token gmail ?t) (known-id ?th) (known-id ?e) (email-in-thread ?e ?th)
                       (known-email ?p ?addr) (not (forwarded ?e ?addr)) (not (task-completed)))
    :effect (and (forwarded ?e ?addr)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?d - deliverer ?qty - quantity ?e - email ?addr - email-address)
    :precondition (and (return-initiated ?o ?p ?d ?qty) (forwarded ?e ?addr) (not (task-completed)))
    :effect (and (task-completed)))
)
