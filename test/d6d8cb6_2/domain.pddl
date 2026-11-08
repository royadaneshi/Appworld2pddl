(define (domain appworld-d6d8cb6-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query quantity email - object
    entity - object
    order product deliverer email-thread email-msg - entity)
  (:constants supervisor amazon phone gmail - app)
  (:predicates
    (passwords-known)
    (task-completed)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (known-email ?p - person ?e - email)
    (has-email ?p - person ?e - email)
    (order-query ?q - query ?o - order)
    (ordered-product ?o - order ?p - product)
    (contact-query ?q - query ?p - person)
    (confirmation-query ?q - query)
    (confirmation-thread ?th - email-thread ?o - order)
    (in-thread ?em - email-msg ?th - email-thread)
    (return-initiated ?o - order ?p - product ?d - deliverer ?qty - quantity)
    (return-initiated-for ?o - order)
    (forwarded ?em - email-msg ?e - email))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?q - query ?o - order)
    :precondition (and (has-token amazon ?t) (order-query ?q ?o) (not (task-completed)))
    :effect (known-id ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-id ?o) (ordered-product ?o ?p) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters (?d - deliverer)
    :precondition (not (task-completed))
    :effect (known-id ?d))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?p - product ?d - deliverer ?qty - quantity ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?o) (known-id ?p) (known-id ?d) (ordered-product ?o ?p) (not (task-completed)))
    :effect (and (return-initiated ?o ?p ?d ?qty) (return-initiated-for ?o)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (contact-query ?q ?p) (has-email ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread ?o - order)
    :precondition (and (has-token gmail ?t) (confirmation-query ?q) (confirmation-thread ?th ?o) (return-initiated-for ?o) (not (task-completed)))
    :effect (known-id ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?em - email-msg)
    :precondition (and (has-token gmail ?t) (known-id ?th) (in-thread ?em ?th) (not (task-completed)))
    :effect (known-id ?em))

  ; API: gmail.forward_email_from_thread
  (:action gmail-forward-email-from-thread
    :parameters (?th - email-thread ?em - email-msg ?e - email ?t - token ?p - person)
    :precondition (and (has-token gmail ?t) (known-id ?th) (known-id ?em) (in-thread ?em ?th) (known-email ?p ?e) (not (task-completed)))
    :effect (forwarded ?em ?e))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?d - deliverer ?qty - quantity ?em - email-msg ?e - email)
    :precondition (and (return-initiated ?o ?p ?d ?qty) (forwarded ?em ?e) (not (task-completed)))
    :effect (task-completed))
)
